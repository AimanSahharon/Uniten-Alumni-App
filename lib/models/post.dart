import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String creator;
  final String text;
  final Timestamp timestamp;
  final int likeCount;


  PostModel({required this.id, required this.creator, required this.text, required this.timestamp, this.likeCount = 0,});


  // Add a method to convert from Firestore document
  factory PostModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PostModel(
      id: doc.id,
      text: data['text'] ?? '',
      creator: data['creator'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
      likeCount: data['likeCount'] ?? 0,
    );
  }
  
}