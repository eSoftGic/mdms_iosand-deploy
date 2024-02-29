import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/authentication/screens/welcome_screen.dart';
import 'package:unique_identifier/unique_identifier.dart';

class FadeInAnimationController extends GetxController {
  static FadeInAnimationController get find => Get.find();

  RxBool animateTwoWay = false.obs;
  RxBool animateSingle = false.obs;
  RxString deviceId = ''.obs;

  void getDeviceId() async {
    String identifier;
    try {
      identifier = (await UniqueIdentifier.serial)!;
    } on PlatformException {
      identifier = 'Failed to get Unique Identifier';
    }
    deviceId.value = identifier.toString();
  }

  Future startSplashAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animateTwoWay.value = true;
    await Future.delayed(const Duration(milliseconds: 3000));
    animateTwoWay.value = false;
    await Future.delayed(const Duration(milliseconds: 2000));
    Get.off(
      // Get.off Instead of Get.offAll()
      () => const WelcomeScreen(),
      duration: const Duration(milliseconds: 1000), //Transition Time
      transition: Transition.fadeIn, //Screen Switch Transition
    );
  }

  //Can be used to animate In after calling the next screen.
  Future animationIn() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animateSingle.value = true;
  }

  //Can be used to animate Out before calling the next screen.
  Future animationOut() async {
    animateSingle.value = false;
    await Future.delayed(const Duration(milliseconds: 100));
  }
}