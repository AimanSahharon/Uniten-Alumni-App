//TOREAD: This file is to allow user to post content to the firebase server

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uniten_alumni_app/models/post.dart';

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

}

