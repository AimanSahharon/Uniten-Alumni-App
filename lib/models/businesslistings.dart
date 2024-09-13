//TOREAD: This is to pass from the business listing pages to Firebase

import 'package:cloud_firestore/cloud_firestore.dart';

class BusinessListingsModel {
  final String id;
  final String creator;
  final String text;
  final Timestamp timestamp;
  final int likeCount;
  final int commentCount;
  final String? imageUrl;

  // Constructor using only named parameters
  BusinessListingsModel({
    required this.id,
    required this.creator,
    required this.text,
    required this.timestamp,
    this.likeCount = 0,
    this.commentCount = 0,
    this.imageUrl, // Nullable imageUrl as a named parameter
  });

  // Add a method to convert from Firestore document
  factory BusinessListingsModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BusinessListingsModel(
      id: doc.id,
      text: data['text'] ?? '',
      creator: data['creator'] ?? '',
      imageUrl: data['imageUrl'] ?? '',  // Fixed case: changed 'ImageUrl' to 'imageUrl'
      timestamp: data['timestamp'] ?? Timestamp.now(),
      likeCount: data['likeCount'] ?? 0,
      commentCount: data['commentCount'] ?? 0,
    );
  }
}
