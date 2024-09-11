import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Import Firebase Storage
import 'package:quiver/iterables.dart';
import 'dart:io';

import 'package:uniten_alumni_app/models/businesslistings.dart';
import 'package:uniten_alumni_app/services/user.dart'; // For File

class BusinessListingsService {
  /*Future<void> savePost(String text, File? imageFile) async {
    String? imageUrl;

    // Upload image to Firebase Storage if there's an image selected
    if (imageFile != null) {
      final storageRef = FirebaseStorage.instance.ref().child('business_listing_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = await storageRef.putFile(imageFile);
      imageUrl = await uploadTask.ref.getDownloadURL(); // Get the image URL
    }

    // Save the post along with the image URL in Firestore
    await FirebaseFirestore.instance.collection("Business Listing posts").add({
      'text': text,
      'imageUrl': imageUrl, // Save the image URL if there is an image
      'creator': FirebaseAuth.instance.currentUser!.uid,
      'timestamp': FieldValue.serverTimestamp(),
    });

    Stream<List<BusinessListingsModel>> getBusinessListings() {
  return FirebaseFirestore.instance.collection('Business Listing posts')
    .snapshots()
    .map((snapshot) => snapshot.docs.map((doc) => BusinessListingsModel.fromFirestore(doc)).toList());
}
  } */

 Future<void> savePost(String text, File? imageFile, Uint8List? webImage) async {
  String? imageUrl;

  // Upload image to Firebase Storage if there's an image selected
  if (imageFile != null) {
    final storageRef = FirebaseStorage.instance.ref().child('post_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    final uploadTask = await storageRef.putFile(imageFile);
    imageUrl = await uploadTask.ref.getDownloadURL(); // Get the image URL
  } else if (webImage != null) {
    final storageRef = FirebaseStorage.instance.ref().child('post_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    final uploadTask = await storageRef.putData(webImage);
    imageUrl = await uploadTask.ref.getDownloadURL(); // Get the image URL
  }

  // Save the post along with the image URL in Firestore
  await FirebaseFirestore.instance.collection("Business Listing posts").add({
    'text': text,
    'imageUrl': imageUrl, // Save the image URL if there is an image
    'creator': FirebaseAuth.instance.currentUser!.uid,
    'timestamp': FieldValue.serverTimestamp(),
  });
}

 List<BusinessListingsModel> _postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) { 
      var data = doc.data() as Map<String, dynamic>; // Cast the data to Map<String, dynamic>
      return BusinessListingsModel(
        id: doc.id,
        text: data['text'] ?? '',
        creator: data['creator'] ?? '',
        timestamp: data['timestamp'] ?? 0,
      );
    }).toList();
  }

   List<BusinessListingsModel> _userListFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) { 
      var data = doc.data() as Map<String, dynamic>; // Cast the data to Map<String, dynamic>
      return BusinessListingsModel(
        id: doc.id,
        text: data['text'] ?? '',
        creator: data['creator'] ?? '',
        timestamp: data['timestamp'] ?? 0,
      );
    }).toList();
  }



   Future<void> likePost(BusinessListingsModel post, bool currentUser) async { 
    final postRef = FirebaseFirestore.instance.collection("Business Listing posts").doc(post.id);

  if (currentUser) { // when user taps like on an already liked state
    await postRef.collection("likes").doc(FirebaseAuth.instance.currentUser?.uid).delete();
    await postRef.update({'likeCount': FieldValue.increment(-1)});
  } else { // when user has not liked post
    await postRef.collection("likes").doc(FirebaseAuth.instance.currentUser?.uid).set({});
    await postRef.update({'likeCount': FieldValue.increment(1)});
  }
  }

   Stream<bool> getCurrentUserLike(BusinessListingsModel post) {
  return FirebaseFirestore.instance
      .collection("Business Listing posts")
      .doc(post.id)
      .collection("likes")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .snapshots()
      .map((snapshot) {
        return snapshot.exists;
      });
}


  // Stream of posts by a specific user
  Stream<List<BusinessListingsModel>> getPostsByUser(String uid) { // Added type annotation for uid
    return FirebaseFirestore.instance
      .collection("Business Listing posts")
      .where('creator', isEqualTo: uid)
      .orderBy('timestamp', descending: true) //show the latest post first
      .snapshots()
      .map(_postListFromSnapshot); 
  }

  // Stream of posts by all the users
  Stream<List<BusinessListingsModel>> getAllPosts(String uid) { // Added type annotation for uid
    return FirebaseFirestore.instance
      .collection("Business Listing posts")
      .orderBy('timestamp', descending: true) //show the latest post first
      .snapshots()
      .map(_postListFromSnapshot); 
  }
  //Search posts based on the first character since Firebase does not have full text search feature
   Stream<List<BusinessListingsModel>> searchPosts(String search) {
    return FirebaseFirestore.instance
        .collection("Business Listing poststs")
        .orderBy("text") 
        .startAt([search]) // If user search and type the first letter, start finding user starting those letters
        .endAt(['$search\uf8ff'])
        .limit(10) // Show 10 search results
        .snapshots()
        .map(_userListFromQuerySnapshot);
  }

  Future<List<BusinessListingsModel>> getFeed(String uid) async {
    List<String> usersFollowing = await UserService() 
    .getUserFollowing(FirebaseAuth.instance.currentUser?.uid);

    var splitUsersFollowing = partition<dynamic>(usersFollowing, 10);
    inspect(splitUsersFollowing);


List<BusinessListingsModel> feedList = [];
    for(int i = 0; i < splitUsersFollowing.length; i++) {
       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
    .collection('Business Listing posts')
    .where('creator', whereIn: splitUsersFollowing.elementAt(i))
    .orderBy('timestamp', descending: true)
    .get();

    feedList.addAll(_postListFromSnapshot(querySnapshot));

    }

    feedList.sort((a, b) {
      var adate = a.timestamp;
      var bdate = b.timestamp;
      return bdate.compareTo(adate);

    });

    return feedList;
    }

    // Method to edit a post

   /*Future<void> editPost(String postId, String newText, File? newImageFile) async {
  final postRef = FirebaseFirestore.instance.collection("Business Listing posts").doc(postId);

  if (newImageFile != null) {
    // Upload new image if provided
    final storageRef = FirebaseStorage.instance.ref().child('business_listing_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    final uploadTask = await storageRef.putFile(newImageFile);
    final imageUrl = await uploadTask.ref.getDownloadURL();

    // Update post with new image URL
    await postRef.update({
      'text': newText,
      'imageUrl': imageUrl, // Save the new image URL
      'timestamp': FieldValue.serverTimestamp(),
    });
  } else {
    // Only update text if no new image is provided
    await postRef.update({
      'text': newText,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
} */

Future<void> editPost(
  String postId,
  String newText,
  File? newImageFile,
  Uint8List? newWebImage // Add this parameter for web image data
) async {
  final postRef = FirebaseFirestore.instance.collection("Business Listing posts").doc(postId);
  final doc = await postRef.get();
  String? newImageUrl;

  if (doc.exists && doc.data()?['creator'] == FirebaseAuth.instance.currentUser?.uid) {
    // If a new image is provided (mobile or web), upload it and get the new URL
    if (newImageFile != null) {
      // Mobile
      final storageRef = FirebaseStorage.instance.ref().child('post_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = await storageRef.putFile(newImageFile);
      newImageUrl = await uploadTask.ref.getDownloadURL();
    } else if (newWebImage != null) {
      // Web
      final storageRef = FirebaseStorage.instance.ref().child('post_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putData(newWebImage);
      newImageUrl = await (await uploadTask).ref.getDownloadURL();
    } else {
      // No new image
      newImageUrl = doc.data()?['imageUrl'];
    }

    await postRef.update({
      'text': newText,
      'imageUrl': newImageUrl,
      'timestamp': FieldValue.serverTimestamp(), // Optionally update the timestamp
    });
  } else {
    throw Exception('You are not authorized to edit this post.');
  }
}

// Method to delete a post
Future<void> deletePost(String postId) async {
  final postRef = FirebaseFirestore.instance.collection("Business Listing posts").doc(postId);
  final doc = await postRef.get();

  if (doc.exists && doc.data()?['creator'] == FirebaseAuth.instance.currentUser?.uid) {
    await postRef.delete();
  } else {
    throw Exception('You are not authorized to delete this post.');
  }
    }

  Future<void> addComment(String postId, String text) async {
  final commentRef = FirebaseFirestore.instance.collection('Business Listing posts').doc(postId).collection('comments').doc();
  await commentRef.set({
    'text': text,
    'creator': FirebaseAuth.instance.currentUser!.uid,
    'timestamp': FieldValue.serverTimestamp(),
  });

  // Increment the commentCount in the post document
  final postRef = FirebaseFirestore.instance.collection('Business Listing posts').doc(postId);
  await postRef.update({'commentCount': FieldValue.increment(1)});
}

  // Edit a comment
  Future<void> editComment(String postId, String commentId, String newText) async {
  final commentRef = FirebaseFirestore.instance.collection('Business Listing posts').doc(postId).collection('comments').doc(commentId);
  final doc = await commentRef.get();

  if (doc.exists && doc.data()?['creator'] == FirebaseAuth.instance.currentUser?.uid) {
    await commentRef.update({
      'text': newText,
      'timestamp': FieldValue.serverTimestamp(),
    });
  } else {
    throw Exception('You are not authorized to edit this comment.');
  }
}

  // Delete a comment
Future<void> deleteComment(String postId, String commentId) async {
  final commentRef = FirebaseFirestore.instance.collection('Business Listing posts').doc(postId).collection('comments').doc(commentId);
  final doc = await commentRef.get();

  if (doc.exists && doc.data()?['creator'] == FirebaseAuth.instance.currentUser?.uid) {
    await commentRef.delete();

    // Decrement the commentCount in the post document
    final postRef = FirebaseFirestore.instance.collection('Business Listing posts').doc(postId);
    await postRef.update({'commentCount': FieldValue.increment(-1)});
  } else {
    throw Exception('You are not authorized to delete this comment.');
  }
}


  // Stream of comments for a post
  Stream<List<BusinessListingsModel>> getComments(String postId) {
    return FirebaseFirestore.instance
      .collection('Business Listing posts')
      .doc(postId)
      .collection('comments')
      .orderBy('timestamp', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => BusinessListingsModel.fromFirestore(doc)).toList());
  }

   // Stream of posts liked by the current user
  Future<List<BusinessListingsModel>> getLikedPosts(String uid) async {
  // Get all posts
  QuerySnapshot postsSnapshot = await FirebaseFirestore.instance
      .collection('Business Listing posts')
      .orderBy('timestamp', descending: true)
      .get();

  List<BusinessListingsModel> likedPosts = [];
  
  for (var doc in postsSnapshot.docs) {
    var postId = doc.id;
    var likesSnapshot = await FirebaseFirestore.instance
        .collection('Business Listing posts')
        .doc(postId)
        .collection('likes')
        .doc(uid)
        .get();

    // Check if the user has liked this post
    if (likesSnapshot.exists) {
      likedPosts.add(BusinessListingsModel(
        id: doc.id,
        text: doc['text'] ?? '',
        creator: doc['creator'] ?? '',
        timestamp: doc['timestamp'] ?? 0,
      ));
    }
  }

  return likedPosts;
}




}
