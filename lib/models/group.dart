//TOREAD: This is to pass from the Interest Group pages to Firebase
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  final String id;
  final String name;
  final String detail;
  final String leader;
  List<String> members;
  final Timestamp groupCreated;

  GroupModel({
  required this.id,
  required this.name,
  required this.detail,
  required this.leader,
  required this.members, 
  required this.groupCreated});
}