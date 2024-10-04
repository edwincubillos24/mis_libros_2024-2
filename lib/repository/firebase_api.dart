import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/book.dart';
import '../models/user.dart' as UserApp;

class FirebaseApi {
  Future<String?> createUser(String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user?.uid;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException ${e.code}");
      return e.code;
    } on FirebaseException catch (e) {
      print("FirebaseException ${e.code}");
      return e.code;
    }
  }

  Future<String?> signInUser(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user?.uid;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException ${e.code}");
      return e.code;
    } on FirebaseException catch (e) {
      print("FirebaseException ${e.code}");
      return e.code;
    }
  }

  Future<String> addUserInDB(UserApp.User user) async {
    try {
      var db = FirebaseFirestore.instance;
      final document =
          await db.collection('users').doc(user.uid).set(user.toJson());
      return user.uid;
    } on FirebaseException catch (e) {
      print("FirebaseCFException ${e.code}");
      return e.code;
    }
  }

  Future<String> createBook(Book book, File? image) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      final document = await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("books")
          .doc();
      book.id = document.id;

      final storageRef = FirebaseStorage.instance.ref();
      final bookPictureRef = storageRef.child("books").child("${book.id}.jpg");
      await bookPictureRef.putFile(image!);
      book.urlPicture = await bookPictureRef.getDownloadURL();

      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("books")
          .doc(document.id)
          .set(book.toJson());

      await FirebaseFirestore.instance
          .collection("books")
          .doc(document.id)
          .set(book.toJson());

      return document.id;
    } on FirebaseException catch (e) {
      print("FirebaseCFException ${e.code}");
      return e.code;
    }
  }

  Future<String> deleteBook(QueryDocumentSnapshot book) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("books")
          .doc(book.id)
          .delete();

      await FirebaseFirestore.instance
          .collection("books")
          .doc(book.id)
          .delete();

      return uid!;
    } on FirebaseException catch (e) {
      print("FirebaseCFException ${e.code}");
      return e.code;
    }
  }
}
