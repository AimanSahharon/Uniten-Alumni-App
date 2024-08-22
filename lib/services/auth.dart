import "package:firebase_auth/firebase_auth.dart";
import "package:uniten_alumni_app/models/user.dart";

class AuthService { //class to handle all the authentication
FirebaseAuth auth = FirebaseAuth.instance;

  UserModel? _userFromFirebaseUser(User? user) {
    return user != null ? UserModel(id: user.uid) : null; //
  }

  Stream<UserModel?> get user{
    return auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future singUp(email, password) async { //to make user sign up new account
    try {
      User user = (await auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
        )) as User;


      _userFromFirebaseUser(user); //if user is not null then return user model if not return null
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future singIn(email, password) async { //to make user sign up new account
    try {
      User user = (await auth.signInWithEmailAndPassword(
        email: email, 
        password: password
        )) as User;


      _userFromFirebaseUser(user); //if user is not null then return user model if not return null
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }


  Future signOut() async {
    try {
      return await auth.signOut();

    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}