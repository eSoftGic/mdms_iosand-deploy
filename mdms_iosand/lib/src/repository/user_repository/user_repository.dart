import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/authentication/models/user_model.dart';
import '../authentication_repository/exceptions/t_exceptions.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  /// Store user data
  Future<void> createUser(UserModel user) async {
    try {
      await recordExist(user.deviceid, 'DeviceId')
          ? throw "Record Already Exists"
          : await _db.collection("Users").add(user.toJson()).whenComplete(() =>
              Get.snackbar('Success', 'Your account has been created',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green.withOpacity(0.1),
                  colorText: Colors.green));
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw e.toString().isEmpty
          ? 'Something went wrong. Please Try Again'
          : e.toString();
    }
  }

  /// Fetch Device User Specific details
  Future<UserModel> getUserDetails(String deviceid) async {
    try {
      final snapshot = await _db
          .collection("Users")
          .where("DeviceId", isEqualTo: deviceid)
          .get();
      if (snapshot.docs.isEmpty) throw 'No such user found';
      final userData =
          snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
      return userData;
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw e.toString().isEmpty
          ? 'Something went wrong. Please Try Again'
          : e.toString();
    }
  }

  /// Fetch User Specific details
  Future<UserModel> getUserPhoneDetails(String phoneno) async {
    try {
      final snapshot = await _db
          .collection("Users")
          .where("phoneNo", isEqualTo: phoneno)
          .get();
      if (snapshot.docs.isEmpty) throw 'No such user found';
      final userData =
          snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
      return userData;
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw e.toString().isEmpty
          ? 'Something went wrong. Please Try Again'
          : e.toString();
    }
  }

  Future<UserModel> getUserEmailDetails(String email) async {
    try {
      final snapshot =
          await _db.collection("Users").where("email", isEqualTo: email).get();
      if (snapshot.docs.isEmpty) throw 'Email not found';
      final userData =
          snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
      return userData;
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw e.toString().isEmpty
          ? 'Something went wrong. Please Try Again'
          : e.toString();
    }
  }

  /// Fetch All Users
  Future<List<UserModel>> allUsers() async {
    try {
      final snapshot = await _db.collection("Users").get();
      final users =
          snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
      return users;
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (_) {
      throw 'Something went wrong. Please Try Again';
    }
  }

  /// Update User details
  Future<void> updateUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).update(user.toJson());
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (_) {
      throw 'Something went wrong. Please Try Again';
    }
  }

  /// Delete User Data
  Future<void> deleteUser(String id) async {
    try {
      await _db.collection("Users").doc(id).delete();
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (_) {
      throw 'Something went wrong. Please Try Again';
    }
  }

  /// Check if user exists with email or phoneNo
  Future<bool> recordExist(String? srcvalue, String fldname) async {
    try {
      final snapshot = await _db
          .collection("Users")
          .where(fldname, isEqualTo: srcvalue)
          .get();
      return snapshot.docs.isEmpty ? false : true;
    } catch (e) {
      throw "Error fetching record.";
    }
  }
}