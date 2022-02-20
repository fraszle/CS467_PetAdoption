import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plentyofpets/main.dart';
import 'package:plentyofpets/utils/user_model.dart';

class FirebaseAuthUtil {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  /// Returns the curerently signed in user or null if no user is signed in.
  static User? getCurrentlySignedInUser() {
    return auth.currentUser;
  }

  /// Returns true if the currently logged in user is an admin, else false.
  static Future<bool> isUserAdmin() async {
    var user = FirebaseAuthUtil.getCurrentlySignedInUser();
    if (user == null) {
      throw Exception('No user is logged in.');
    }
    DocumentSnapshot doc = await usersCollection.doc(user.uid).get();
    if (!doc.exists) {
      throw Exception('Failed to find doc for logged in user.');
    }
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return data['isAdmin'];
  }

  /// Signs in the user with the given email and password
  static Future<bool> signIn(
      BuildContext context, String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      String msg;
      switch (e.code) {
        case "user-not-found":
        case "wrong-password":
        case "invalid-email":
          msg = 'Invalid email address or password provided.';
          break;
        default:
          msg = 'An unknown error occured. Please try again.';
      }
      _showAuthErrorDialog(context, 'Error Logging In', msg);
      return false;
    }
  }

  /// Signs out the currently logged in user
  static void signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      _showAuthErrorDialog(context, 'Error Logging Out',
          'Error while logging out. Please try again in a few minutes.');
      return;
    }
    Navigator.pushNamedAndRemoveUntil(
        context, MyApp.loginRoute, (route) => false);
  }

  /// Registers and signs in the given NewUser
  static Future<bool> register(BuildContext context, NewUser newUser) async {
    // Create user in Firebase Auth
    UserCredential userCredential;
    try {
      // User is signed in automatically if registration succeeds
      userCredential = await auth.createUserWithEmailAndPassword(
          email: newUser.email, password: newUser.password);
    } on FirebaseAuthException catch (e) {
      String msg;
      switch (e.code) {
        case 'email-already-in-use':
          msg = 'There is already an account registered with that email.';
          break;
        case 'invalid-email':
          msg = 'Please enter a valid email address.';
          break;
        default:
          msg = 'An unexpected error occured. Please try again.';
      }
      _showAuthErrorDialog(context, 'Error Registering', msg);
      return false;
    }

    // Create User document in Firestore
    return createUserDocument(context, newUser, userCredential);
  }

  /// Creates document for new user in users collection
  static Future<bool> createUserDocument(BuildContext context, NewUser newUser,
      UserCredential userCredential) async {
    bool result = true;
    await usersCollection
        .doc(userCredential.user!.uid)
        .set(newUser.toMap())
        .catchError((error) {
      // Roll back user registration since document creation failed.
      userCredential.user!.delete();
      _showAuthErrorDialog(context, 'Error Registering',
          'Unexpected error occured while registering. Please try again.');
      result = false;
    });
    return result;
  }

  /// Shows an error dialog if some part of authentication fails
  static void _showAuthErrorDialog(
      BuildContext context, String title, String errorMsg) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                title,
                textAlign: TextAlign.center,
              ),
              content: Text(errorMsg),
            ));
  }
}
