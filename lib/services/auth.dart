//TOREAD: This is to authenticate the user
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:uniten_alumni_app/models/user.dart";

class AuthService { 
  final FirebaseAuth auth = FirebaseAuth.instance;

  //to display back user's profile from firebase
  UserModel? _userFromFirebaseUser(User? user) { 
    return user != null ? UserModel(id: user.uid, bannerImageUrl: '', profileImageUrl: '', name: '', email: '') : null;
  }

  //to keep track is the user is logged in or logged out
  Stream<UserModel?> get user {
    return auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //To tell Firebase to store these user's information
  Future<UserModel?> signUp(String email, String password) async { 
    try {
      UserCredential user = (await auth.createUserWithEmailAndPassword(
        email: email, 
        password: password,
      ));
      
      await FirebaseFirestore.instance
      .collection('users')
      .doc(user.user!.uid)
      .set({'name': email, 'email': email});
       _userFromFirebaseUser(user.user); 
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  //To authenticate the user and if the credentials are correct then logged in
  Future<UserModel?> signIn(String email, String password) async { 
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email, 
        password: password,
      );
      return _userFromFirebaseUser(userCredential.user); 
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return null;
  }
  //To logout
  Future<void> signOut() async {
    try {
      return await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
