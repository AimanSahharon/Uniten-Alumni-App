// grouppost.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class GroupPost {
  final String id;        // Unique identifier for the post
  final String title;     // Title of the post
  final String content;   // Content of the post
  final String userId;    // ID of the user who created the post
  final DateTime createdAt; // Timestamp for when the post was created

  GroupPost({
    required this.id,
    required this.title,
    required this.content,
    required this.userId,
    required this.createdAt,
  });

  // Factory method to create a GroupPost from a JSON object (if using Firestore)
  factory GroupPost.fromJson(Map<String, dynamic> json) {
    return GroupPost(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      userId: json['userId'] ?? '',
      createdAt: (json['createdAt'] as Timestamp).toDate(), // Adjust if using a different timestamp format
    );
  }

  // Method to convert GroupPost to JSON (for saving to Firestore)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'userId': userId,
      'createdAt': createdAt,
    };
  }
}
