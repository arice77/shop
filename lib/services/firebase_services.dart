import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop/pages/homepage.dart';
import 'package:shop/pages/signup.dart';

class FirebaseServices {
  Future<UserCredential?> emailSignUp(
      String email, String password, BuildContext context) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return result;
      // User created successfully
    } catch (e) {
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'invalid-email':
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Email is not valid')));
            break;
          case 'weak-password':
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('The password is too weak')));
            break;
          case 'email-already-in-use':
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('The email is already in use')));
            break;
          default:
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('An unknown error occurred')));
            break;
        }
      }
      return null;
    }
  }

  Future<UserCredential?> emailSignIn(
      String email, String password, BuildContext context) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return result;
      // User signed in successfully
    } catch (e) {
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'invalid-email':
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('The email is invalid')));
            break;
          case 'wrong-password':
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('The password is wrong')));
            break;
          case 'user-not-found':
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('The user was not found')));
            break;
          default:
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('An unknown error occurred')));
            break;
        }
      }
      return null;
    }
  }

  Future<void> sendVerificationEmailAndNavigate(BuildContext context) async {
    User user = await FirebaseAuth.instance.currentUser!;
    try {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Verification email sent. Please check your email.'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('An error occurred while trying to send the email.'),
      ));
      Navigator.of(context).pushReplacementNamed(SignUpPage.routeName);
    }
    Timer.periodic(const Duration(seconds: 3), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Navigator.of(context).pushReplacementNamed(HomePage.routeName);
      }
    });
  }
}
