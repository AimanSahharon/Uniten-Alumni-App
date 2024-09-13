//TOREAD: This is to pass from the Posts pages to Firebase

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String creator;
  final String text;
  final Timestamp timestamp;
  final int likeCount;
  final int commentCount;
final String? imageUrl;

  PostModel({required this.id, required this.creator, required this.text, required this.timestamp, this.likeCount = 0, this.commentCount = 0, this.imageUrl,});


  // Add a method to convert from Firestore document
  factory PostModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PostModel(
      id: doc.id,
      text: data['text'] ?? '',
      creator: data['creator'] ?? '',
      imageUrl: data['imageUrl'] ?? '', 
      timestamp: data['timestamp'] ?? Timestamp.now(),
      likeCount: data['likeCount'] ?? 0,
      commentCount: data['commentCount'] ?? 0,
    );
  }
  
}