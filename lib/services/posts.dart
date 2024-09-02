//TOREAD: This file is to allow user to post content to the firebase server

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  // Save a post to Firestore
  Future<void> savePost(String text) async { // Added type annotation for text
    await FirebaseFirestore.instance.collection("posts").add({
      'text': text,
      'creator': FirebaseAuth.instance.currentUser!.uid,
      'timestamp': FieldValue.serverTimestamp(), // Firestore generates the timestamp
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
        .endAt([search + '\uf8ff'])
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

}

