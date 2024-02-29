import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/authentication_repository/authentication_repository.dart';
import '../screens/otp_screen.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final phoneno = TextEditingController();

  /// Loader
  final isLoading = false.obs;

  /// Call this Function from Design & it will perform the LOGIN Op.
  Future<void> loginUser(String email, String password, String phoneno) async {
    try {
      isLoading.value = true;
      if (email.isEmpty && password.isEmpty && phoneno.isNotEmpty) {
        await AuthenticationRepository.instance.phoneAuthentication(phoneno);
        Get.to(() => const OTPScreen());
      } else {
        await AuthenticationRepository.instance
            .loginWithEmailAndPassword(email, password);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
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
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 5));
    }
  }

  /// [FacebookSignInAuthentication]
  Future<void> facebookSignIn() async {
    try {
      isLoading.value = true;
      await AuthenticationRepository.instance.signInWithFacebook();
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 5));
    }
  }
*/
}