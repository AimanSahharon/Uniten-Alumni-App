//TOREAD: This file is to allow user to post content to the firebase server

import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/services/user.dart';
import 'package:quiver/iterables.dart';

class PostService {
  // Convert Firestore snapshot to a list of PostModel objects
  List<PostModel> _postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) { 
      var data = doc.data() as Map<String, dynamic>; // Cast the data to Map<String, dynamic>
      return PostModel(
        id: doc.id,
        text: data['text'] ?? '',
        creator: data['creator'] ?? '',
        timestamp: data['timestamp'] ?? 0,
      );
    }).toList();
  }

   List<PostModel> _userListFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) { 
      var data = doc.data() as Map<String, dynamic>; // Cast the data to Map<String, dynamic>
      return PostModel(
        id: doc.id,
        text: data['text'] ?? '',
        creator: data['creator'] ?? '',
        timestamp: data['timestamp'] ?? 0,
      );
    }).toList();
  }

  // Save a post to Firestore ORIGINAL, cannot save from the web
 /*Future<void> savePost(String text, File? imageFile) async {
    String? imageUrl;

    // Upload image to Firebase Storage if there's an image selected
    if (imageFile != null) {
      final storageRef = FirebaseStorage.instance.ref().child('post_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = await storageRef.putFile(imageFile);
      imageUrl = await uploadTask.ref.getDownloadURL(); // Get the image URL
    }

    // Save the post along with the image URL in Firestore
    await FirebaseFirestore.instance.collection("posts").add({
      'text': text,
      'imageUrl': imageUrl, // Save the image URL if there is an image
      'creator': FirebaseAuth.instance.currentUser!.uid,
      'timestamp': FieldValue.serverTimestamp(),
    });

    Stream<List<PostModel>> getPosts() {
  return FirebaseFirestore.instance.collection('posts')
    .snapshots()
    .map((snapshot) => snapshot.docs.map((doc) => PostModel.fromFirestore(doc)).toList());
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
  await FirebaseFirestore.instance.collection("posts").add({
    'text': text,
    'imageUrl': imageUrl, // Save the image URL if there is an image
    'creator': FirebaseAuth.instance.currentUser!.uid,
    'timestamp': FieldValue.serverTimestamp(),
  });
}



   Future<void> likePost(PostModel post, bool currentUser) async { 
    final postRef = FirebaseFirestore.instance.collection("posts").doc(post.id);

  if (currentUser) { // when user taps like on an already liked state
    await postRef.collection("likes").doc(FirebaseAuth.instance.currentUser?.uid).delete();
    await postRef.update({'likeCount': FieldValue.increment(-1)});
  } else { // when user has not liked post
    await postRef.collection("likes").doc(FirebaseAuth.instance.currentUser?.uid).set({});
    await postRef.update({'likeCount': FieldValue.increment(1)});
  }
  }

   Stream<bool> getCurrentUserLike(PostModel post) {
  return FirebaseFirestore.instance
      .collection("posts")
      .doc(post.id)
      .collection("likes")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .snapshots()
      .map((snapshot) {
        return snapshot.exists;
      });
}


  // Stream of posts by a specific user
  Stream<List<PostModel>> getPostsByUser(String uid) { // Added type annotation for uid
    return FirebaseFirestore.instance
      .collection("posts")
      .where('creator', isEqualTo: uid)
      .orderBy('timestamp', descending: true) //show the latest post first
      .snapshots()
      .map(_postListFromSnapshot); 
  }

  // Stream of posts by all the users
  Stream<List<PostModel>> getAllPosts(String uid) { // Added type annotation for uid
    return FirebaseFirestore.instance
      .collection("posts")
      .orderBy('timestamp', descending: true) //show the latest post first
      .snapshots()
      .map(_postListFromSnapshot); 
  }
  //Search posts based on the first character since Firebase does not have full text search feature
   Stream<List<PostModel>> searchPosts(String search) {
    return FirebaseFirestore.instance
        .collection("posts")
        .orderBy("text") 
        .startAt([search]) // If user search and type the first letter, start finding user starting those letters
        .endAt(['$search\uf8ff'])
        .limit(10) // Show 10 search results
        .snapshots()
        .map(_userListFromQuerySnapshot);
  }

  Future<List<PostModel>> getFeed(String uid) async {
    List<String> usersFollowing = await UserService() 
    .getUserFollowing(FirebaseAuth.instance.currentUser?.uid);

    var splitUsersFollowing = partition<dynamic>(usersFollowing, 10);
    inspect(splitUsersFollowing);


List<PostModel> feedList = [];
    for(int i = 0; i < splitUsersFollowing.length; i++) {
       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
    .collection('posts')
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
/*
   Future<void> editPost(String postId, String newText, File? newImageFile) async {
  final postRef = FirebaseFirestore.instance.collection("posts").doc(postId);
  final doc = await postRef.get();
  String? newImageUrl;

  if (doc.exists && doc.data()?['creator'] == FirebaseAuth.instance.currentUser?.uid) {
    // If a new image is provided, upload it and get the new URL
    if (newImageFile != null) {
      final storageRef = FirebaseStorage.instance.ref().child('post_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = await storageRef.putFile(newImageFile);
      newImageUrl = await uploadTask.ref.getDownloadURL();
    } else {
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
} */

Future<void> editPost(
  String postId,
  String newText,
  File? newImageFile,
  Uint8List? newWebImage // Add this parameter for web image data
) async {
  final postRef = FirebaseFirestore.instance.collection("posts").doc(postId);
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
  final postRef = FirebaseFirestore.instance.collection("posts").doc(postId);
  final doc = await postRef.get();

  if (doc.exists && doc.data()?['creator'] == FirebaseAuth.instance.currentUser?.uid) {
    await postRef.delete();
  } else {
    throw Exception('You are not authorized to delete this post.');
  }
    }

  Future<void> addComment(String postId, String text) async {
  final commentRef = FirebaseFirestore.instance.collection('posts').doc(postId).collection('comments').doc();
  await commentRef.set({
    'text': text,
    'creator': FirebaseAuth.instance.currentUser!.uid,
    'timestamp': FieldValue.serverTimestamp(),
  });

  // Increment the commentCount in the post document
  final postRef = FirebaseFirestore.instance.collection('posts').doc(postId);
  await postRef.update({'commentCount': FieldValue.increment(1)});
}

  // Edit a comment
  Future<void> editComment(String postId, String commentId, String newText) async {
  final commentRef = FirebaseFirestore.instance.collection('posts').doc(postId).collection('comments').doc(commentId);
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
  final commentRef = FirebaseFirestore.instance.collection('posts').doc(postId).collection('comments').doc(commentId);
  final doc = await commentRef.get();

  if (doc.exists && doc.data()?['creator'] == FirebaseAuth.instance.currentUser?.uid) {
    await commentRef.delete();

    // Decrement the commentCount in the post document
    final postRef = FirebaseFirestore.instance.collection('posts').doc(postId);
    await postRef.update({'commentCount': FieldValue.increment(-1)});
  } else {
    throw Exception('You are not authorized to delete this comment.');
  }
}


  // Stream of comments for a post
  Stream<List<PostModel>> getComments(String postId) {
    return FirebaseFirestore.instance
      .collection('posts')
      .doc(postId)
      .collection('comments')
      .orderBy('timestamp', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => PostModel.fromFirestore(doc)).toList());
  }

   // Stream of posts liked by the current user
  Future<List<PostModel>> getLikedPosts(String uid) async {
  // Get all posts
  QuerySnapshot postsSnapshot = await FirebaseFirestore.instance
      .collection('posts')
      .orderBy('timestamp', descending: true)
      .get();

  List<PostModel> likedPosts = [];
  
  for (var doc in postsSnapshot.docs) {
    var postId = doc.id;
    var likesSnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(uid)
        .get();

    // Check if the user has liked this post
    if (likesSnapshot.exists) {
      likedPosts.add(PostModel(
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


