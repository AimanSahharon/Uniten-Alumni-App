import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uniten_alumni_app/models/group.dart'; // Your GroupModel
import 'package:uniten_alumni_app/models/grouppost.dart';
import 'package:uniten_alumni_app/models/user.dart'; // Your UserModel

class GroupService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all posts from all groups
 /*Future<List<GroupModel>> getAllGroups() async {
  // Fetch all groups from the 'groups' collection
  QuerySnapshot querySnapshot = await _firestore.collection('groups').get();
  
  // Map the documents to List<GroupModel>
  return querySnapshot.docs.map((doc) {
    return GroupModel(
      id: doc.id,
      name: doc['name'],
      leader: doc['leader'],
      members: List<String>.from(doc['members']),
      groupCreated: doc['groupCreated'],
    );
  }).toList();
} */

Future<List<GroupModel>> getAllGroups() async {
  // Fetch all groups from the 'groups' collection
  QuerySnapshot querySnapshot = await _firestore.collection('groups').get();
  
  // Map the documents to List<GroupModel> and sort by 'groupCreated'
  List<GroupModel> groups = querySnapshot.docs.map((doc) {
    return GroupModel(
      id: doc.id,
      name: doc['name'],
      detail: doc['detail'],
      leader: doc['leader'],
      members: List<String>.from(doc['members']),
      groupCreated: doc['groupCreated'], // Ensure this is a timestamp
    );
  }).toList();

  // Sort groups by 'groupCreated' in descending order
  groups.sort((a, b) => b.groupCreated.compareTo(a.groupCreated));

  return groups;
}


  // Fetch the groups the user has joined
 /* Future<List<GroupModel>> getJoinedGroups(String uid) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    QuerySnapshot querySnapshot = await _firestore
        .collection('groups')
        .where('members', arrayContains: uid)
        .get();
    return querySnapshot.docs.map((doc) {
      return GroupModel(
        id: doc.id,
        name: doc['name'],
        detail: doc['detail'],
        leader: doc['leader'],
        members: List<String>.from(doc['members']),
        groupCreated: doc['groupCreated'],
      );
    }).toList();
  } */

 Future<List<GroupModel>> getJoinedGroups(String uid) async {
  QuerySnapshot querySnapshot = await _firestore
      .collection('groups')
      .where('members', arrayContains: uid)
      .get();
  return querySnapshot.docs.map((doc) {
    return GroupModel(
      id: doc.id,
      name: doc['name'],
      detail: doc['detail'],
      leader: doc['leader'],
      members: List<String>.from(doc['members']),
      groupCreated: doc['groupCreated'],
    );
  }).toList();
}


  // Fetch the groups the user has created
  Future<List<GroupModel>> getCreatedGroups() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    QuerySnapshot querySnapshot = await _firestore
        .collection('groups')
        .where('leader', isEqualTo: uid)
        .get();
    return querySnapshot.docs.map((doc) {
      return GroupModel(
        id: doc.id,
        name: doc['name'],
        detail: doc['detail'],
        leader: doc['leader'],
        members: List<String>.from(doc['members']),
        groupCreated: doc['groupCreated'],
      );
    }).toList();
  }

/*
  // Create a new group
  Future<void> createGroup(String groupName) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid != null) {
      DocumentReference groupRef = await _firestore.collection('groups').add({
        'name': groupName,
        'leader': uid,
        'members': [uid],  // The creator is the first member
        'groupCreated': Timestamp.now(),
      });
    }
  } */
 Future<String> createGroup(String groupName, String groupDetail) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;

  if (uid != null) {
    DocumentReference groupRef = await _firestore.collection('groups').add({
      'name': groupName,
      'detail': groupDetail,
      'leader': uid,
      'members': [uid],
      'groupCreated': Timestamp.now(),
    });
    return groupRef.id; // Return the created group ID
  }
  throw Exception("User not logged in");
}


  // Join an existing group
  Future<void> joinGroup(String groupId) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid != null) {
      await _firestore.collection('groups').doc(groupId).update({
        'members': FieldValue.arrayUnion([uid])
      });
    }
  }

  // Add a user to a group (used when leader invites users)
  Future<void> addUserToGroup(String groupId, String userId) async {
    await _firestore.collection('groups').doc(groupId).update({
      'members': FieldValue.arrayUnion([userId])
    });
  }

  // Leave a group
  Future<void> leaveGroup(String groupId) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid != null) {
      await _firestore.collection('groups').doc(groupId).update({
        'members': FieldValue.arrayRemove([uid])
      });
    }
  }

  // Get all groups the user is part of
  Stream<List<GroupModel>> getUserGroups(String uid) {
    return _firestore.collection('groups')
        .where('members', arrayContains: uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return GroupModel(
          id: doc.id,
          name: doc.data()['name'],
          detail: doc.data()['detail'],
          leader: doc.data()['leader'],
          members: List<String>.from(doc.data()['members']),
          groupCreated: doc.data()['groupCreated'],
        );
      }).toList();
    });
  }

  // Create a post in a group
  Future<void> createGroupPost(String groupId, String content) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid != null) {
      await _firestore.collection('groups').doc(groupId).collection('posts').add({
        'content': content,
        'author': uid,
        'timestamp': Timestamp.now(),
      });
    }
  }

  // Delete a group
  Future<void> deleteGroup(String groupId) async {
    // First, delete all posts within the group if needed
    await _firestore.collection('groups').doc(groupId).collection('posts').get().then((snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference.delete(); // Delete each post
      }
    });

    // Now delete the group itself
    await _firestore.collection('groups').doc(groupId).delete();
  }

  

}
