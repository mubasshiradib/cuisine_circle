import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthSevices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<String?> signIn({required String email, required String password}) async {
    try {
      UserCredential res = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      await res.user?.reload();
      if (firebaseAuth.currentUser?.emailVerified == false) {
        return 'Please verify your email first.';
      }
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'Login failed';
    } catch (e) {
      return 'Something went wrong';
    }
  }

  // Name, Email ebong PhoneNumber Firestore Database-e save korche
  Future<String?> signUp({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      UserCredential res = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      await res.user?.updateDisplayName(name);

      // Firestore 'users' collection-e user details save kora hocche
      if (res.user != null) {
        await FirebaseFirestore.instance.collection('users').doc(res.user!.uid).set({
          'uid': res.user!.uid,
          'name': name,
          'email': email,
          'phoneNumber': phoneNumber,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      await res.user?.sendEmailVerification();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'Registration failed';
    } catch (e) {
      return 'Something went wrong';
    }
  }

  Future<String?> resetPassword({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email.trim());
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'Failed to send reset email';
    } catch (e) {
      return 'Something went wrong';
    }
  }
}