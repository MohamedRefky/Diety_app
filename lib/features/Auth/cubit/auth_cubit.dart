import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_state.dart';

// Cubit
class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthCubit() : super(AuthInitial());

  // Email validation helper
  bool _isValidGmail(String email) {
    return email.trim().toLowerCase().endsWith('@gmail.com');
  }

  // 1. Email and Password Login
  Future<void> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    emit(AuthLoading());
    try {
      if (!_isValidGmail(email)) {
        emit(AuthFailure('Only @gmail.com emails are allowed.'));
        return;
      }

      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      if (credential.user != null) {
        emit(AuthSuccess(credential.user!));
      } else {
        emit(AuthFailure('Failed to sign in. Please try again.'));
      }
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred. Please try again.';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is badly formatted.';
      } else if (e.message != null) {
        message = e.message!;
      }
      emit(AuthFailure(message));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // 2. Email and Password SignUp
  Future<void> signUpWithEmailAndPassword({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      if (!_isValidGmail(email)) {
        emit(AuthFailure('Only @gmail.com emails are allowed.'));
        return;
      }

      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      if (credential.user != null) {
        // Save user data to Firestore
        await _firestore.collection('users').doc(credential.user!.uid).set({
          'firstName': firstName.trim(),
          'lastName': lastName.trim(),
          'email': email.trim(),
        });

        emit(AuthSuccess(credential.user!));
      } else {
        emit(AuthFailure('Registration failed. Please try again.'));
      }
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred. Please try again.';
      if (e.code == 'invalid-email') {
        message = 'The email address is badly formatted.';
      } else if (e.code == 'weak-password') {
        message = 'The password is too weak. Must be at least 6 characters.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else if (e.message != null) {
        message = e.message!;
      }
      emit(AuthFailure(message));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // 3. Google Sign-In
  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        emit(AuthInitial()); // User cancelled the sign-in
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        // Create user document in firestore if not exists
        final userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        if (!userDoc.exists) {
          String displayName = user.displayName ?? "User";
          List<String> parts = displayName.split(" ");
          String firstName = parts.isNotEmpty ? parts.first : "User";
          String lastName = parts.length > 1 ? parts.last : "";
          await _firestore.collection('users').doc(user.uid).set({
            'firstName': firstName,
            'lastName': lastName,
            'email': user.email ?? "",
          });
        }
        emit(AuthSuccess(user));
      } else {
        emit(AuthFailure('Failed to sign in with Google.'));
      }
    } catch (e) {
      emit(AuthFailure('Google Sign-In failed: ${e.toString()}'));
    }
  }

  // 4. Facebook Sign-In
  Future<void> signInWithFacebook() async {
    emit(AuthLoading());
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(
                loginResult.accessToken!.tokenString);

        UserCredential userCredential =
            await _auth.signInWithCredential(facebookAuthCredential);
        User? user = userCredential.user;

        if (user != null) {
          // Create user document in firestore if not exists
          final userDoc =
              await _firestore.collection('users').doc(user.uid).get();
          if (!userDoc.exists) {
            String displayName = user.displayName ?? "User";
            List<String> parts = displayName.split(" ");
            String firstName = parts.isNotEmpty ? parts.first : "User";
            String lastName = parts.length > 1 ? parts.last : "";
            await _firestore.collection('users').doc(user.uid).set({
              'firstName': firstName,
              'lastName': lastName,
              'email': user.email ?? "",
            });
          }
          emit(AuthSuccess(user));
        } else {
          emit(AuthFailure('Failed to sign in with Facebook.'));
        }
      } else if (loginResult.status == LoginStatus.cancelled) {
        emit(AuthInitial());
      } else {
        emit(AuthFailure('Facebook Sign-In failed: ${loginResult.message}'));
      }
    } catch (e) {
      emit(AuthFailure('Facebook Sign-In failed: ${e.toString()}'));
    }
  }

  // 5. Send Password Reset Email
  Future<void> sendPasswordResetEmail(String email) async {
    emit(AuthLoading());
    try {
      if (!_isValidGmail(email)) {
        emit(AuthFailure('Only @gmail.com emails are allowed.'));
        return;
      }
      await _auth.sendPasswordResetEmail(email: email.trim());
      emit(AuthInitial()); // Back to initial after successful email sent
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred. Please try again.';
      if (e.code == 'invalid-email') {
        message = 'The email address is badly formatted.';
      } else if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.message != null) {
        message = e.message!;
      }
      emit(AuthFailure(message));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
