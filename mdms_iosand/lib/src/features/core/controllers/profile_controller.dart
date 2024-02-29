import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/authentication/models/user_model.dart';
import 'package:mdms_iosand/src/repository/authentication_repository/authentication_repository.dart';
import 'package:mdms_iosand/src/repository/user_repository/user_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  /// Repositories
  final _authRepo = AuthenticationRepository.instance;
  final _userRepo = UserRepository.instance;

  /// TextField Controllers to get data from TextFields
  final baseurl = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();

  /// Loader
  final isLoading = false.obs;

  checkUser(String baseurl, String username, String password) {}

  /// Get User MobileNo and pass to UserRepository to fetch user record.
  getUserData() {
    try {
      //String _fbauid = _authRepo.getUserID;
      String fbaemail = _authRepo.getUserEmail;
      //String _fbaphone = _authRepo.getUserPhoneNo;
      if (fbaemail.isEmpty) {
        Get.snackbar("Error", "Email not found!",
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3));
        return;
      } else {
        return _userRepo.getUserEmailDetails(fbaemail);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3));
    }
  }

  /// Fetch List of user records.
  Future<List<UserModel>> getAllUsers() async => await _userRepo.allUsers();

  /// Update User Data
  updateRecord(UserModel user) async {
    await _userRepo.updateUserRecord(user);
    //Show some message or redirect to other screen here...
  }

  Future<void> deleteUser() async {
    String uID = _authRepo.getUserID;
    if (uID.isEmpty) {
      Get.snackbar("Error", "User cannot be deleted.");
    } else {
      await _userRepo.deleteUser(uID);
      Get.snackbar("Success", "Account has been deleted.");
      // You can call your redirection to other screen here...
      // OR call the LOGOUT() function.
    }
  }
}