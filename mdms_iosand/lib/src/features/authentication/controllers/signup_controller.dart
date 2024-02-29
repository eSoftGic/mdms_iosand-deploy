// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/authentication/models/user_model.dart';
import 'package:mdms_iosand/src/features/core/screens/dashboard/dashboard.dart';
import 'package:mdms_iosand/src/repository/user_repository/user_repository.dart';
import 'package:unique_identifier/unique_identifier.dart';

import '../../../repository/authentication_repository/authentication_repository.dart';
import '../screens/otp_screen.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final userRepo = UserRepository
      .instance; //Call Get.put(UserRepo) if not define in AppBinding file (main.dart)

  // TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final username = TextEditingController();
  final phoneno = TextEditingController();

  /// Loader
  final isLoading = false.obs;
  RxString deviceid = "".obs;

  // As in the AuthenticationRepository we are calling _setScreen() Method
  // so, whenever there is change in the user state(), screen will be updated.
  // Therefore, when new user is authenticated, AuthenticationRepository() detects
  // the change and call _setScreen() to switch screens

  /// Register New User using either [EmailAndPassword] OR [PhoneNumber] authentication
  Future<void> createUser(UserModel user) async {
    try {
      isLoading.value = true;
      await userRepo.createUser(user); //Store Data in FireStore
      //if (user.phoneno != '') {
      //  await phoneAuthentication(user.phoneno);
      //  Get.to(() => const OTPScreen());
      //} else {
      await emailAuthentication(user.email, user.password);
      Get.to(() => const Dashboard());
      //}
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
    }
  }

  /// [PhoneNoAuthentication]
  Future<void> phoneAuthentication(String? phoneNo) async {
    try {
      await AuthenticationRepository.instance.phoneAuthentication(phoneNo!);
    } catch (e) {
      throw e.toString();
    }
  }

  /// [EmailAuthentication]
  Future<void> emailAuthentication(String? email, String? password) async {
    try {
      await AuthenticationRepository.instance
          .createUserWithEmailAndPassword(email!, password!);
    } catch (e) {
      throw e.toString();
    }
  }

/*
  /// [GoogleSignInAuthentication]
  Future<void> googleSignIn() async {
    try {
      isLoading.value = true;
      await AuthenticationRepository.instance.signInWithGoogle();
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
    }
  }
*/

  void getDeviceId() async {
    String identifier;
    try {
      identifier = (await UniqueIdentifier.serial)!;
    } on PlatformException {
      identifier = 'Failed to get Unique Identifier';
    }
    deviceid.value = identifier.toString();
  }
}
