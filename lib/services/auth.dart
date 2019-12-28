import 'dart:ffi';
import 'dart:math';

import 'package:bloc_firebase_validation/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null && user.isEmailVerified? User(uid: user.uid) : User(uid: "null");
  }



  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _auth.currentUser();
    return currentUser != null;
  }

  Future<bool> isVerified() async{
    final currentUser = await _auth.currentUser();
    return currentUser.isEmailVerified?true:false;

  }

  Future<void> sendEmailVerification() async {
    final currentUser = await _auth.currentUser();
    await currentUser.sendEmailVerification();


  }

  Future sighInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      throw new Exception(e.toString());
    }
  }

  Future signIn(String email, String password) async {

    AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email, password: password).catchError((result) {
      switch (result.toString()) {
        case "PlatformException(ERROR_INVALID_EMAIL, The email address is badly formatted., null)":
          {
            throw new Exception("INVALID EMAIL");
          }
          break;
        case "PlatformException(ERROR_USER_NOT_FOUND, There is no user record corresponding to this identifier. The user may have been deleted., null)":
          {
            throw new Exception("UNABLE TO FIND USER");
          }
          break;
        case "ERROR_USER_DISABLED":
          {
            throw new Exception("USER HAS BEEN DELETED");
          }
          break;

        case "PlatformException(ERROR_TOO_MANY_REQUESTS, We have blocked all requests from this device due to unusual activity. Try again later. [ Too many unsuccessful login attempts.  Please include reCaptcha verification or try again later ], null)":
          {
            throw new Exception(
                "TOO MANY REQUEST TO SIGN IN WITH THIS USER HAVE BEEN ATTEMPTED");
          }
          break;
        case "PlatformException(ERROR_WRONG_PASSWORD, The password is invalid or the user does not have a password., null)":
          {
            throw new Exception("INCORRECT PASSWORD");
          }
          break;
      }
    });
    FirebaseUser user = result.user;
    return _userFromFirebaseUser(user);
  }

  Future signUp(String email, String password) async {
    AuthResult result = await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .catchError((result) {
      switch (result.toString()) {
        case "PlatformException(ERROR_EMAIL_ALREADY_IN_USE, The email address is already in use by another account., null)":
          {
            throw new Exception("EMAIL IS ALREADY IN USE");
          }
          break;
        case "PlatformException(ERROR_INVALID_EMAIL, The email address is badly formatted., null)":
          {
            throw new Exception("INVALID EMAIL");
          }
          break;
        case "PlatformException(ERROR_WEAK_PASSWORD, The given password is invalid. [ Password should be at least 6 characters ], null)":
          {
            throw new Exception("WEAK PASSWORD");
          }
          break;
      }
    });

    FirebaseUser user = result.user;
    return _userFromFirebaseUser(user);
  }

}
class ValidationError extends Error {
  String message;
  ValidationError({this.message});
}
