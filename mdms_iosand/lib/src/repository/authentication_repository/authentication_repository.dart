// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/authentication/screens/setup/login_setup.dart';
import 'package:mdms_iosand/src/features/authentication/screens/welcome_screen.dart';
import 'exceptions/t_exceptions.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  //late final GoogleSignInAccount googleUser;

  final _auth = FirebaseAuth.instance;

  late final Rx<User?> _firebaseUser;

  var verificationId = ''.obs;
  RxString deviceid = "".obs;

  /// QUICK links to get frequently used values in other classes.
  User? get firebaseUser => _firebaseUser.value;
  String get getUserID => _firebaseUser.value?.uid ?? "";
  String get getUserEmail => _firebaseUser.value?.email ?? "";
  String get getUserPhoneNo => _firebaseUser.value?.phoneNumber ?? "";

  /// When App launch, this func called.
  /// It set the firebaseUser state & remove the Splash Screen
  @override
  void onReady() async {
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.userChanges());
    print('fbauid $_firebaseUser.value?.uid');
    FlutterNativeSplash.remove();
    ever(_firebaseUser, _setInitialScreen);
  }

  /// Setting initial screen onLOAD (optional)
  _setInitialScreen(User? user) async {
    user == null ? Get.offAll(() => const WelcomeScreen()) : Get.offAll(() => const LoginSetupPage());
  }

  /// [PhoneAuthentication] - LOGIN
  loginWithPhoneNo(String phoneNumber) async {
    try {
      await _auth.signInWithPhoneNumber(phoneNumber);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-phone-number') {
        Get.snackbar("Error", "Invalid Phone No");
      }
    } catch (_) {
      Get.snackbar("Error", "Something went wrong.");
    }
  }

  /// [PhoneAuthentication] - REGISTER
  Future<void> phoneAuthentication(String phoneNo) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
        },
        codeSent: (verificationId, resendToken) {
          this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId.value = verificationId;
        },
        verificationFailed: (e) {
          if (e.code == 'invalid-phone-number') {
            Get.snackbar('Error', 'The provided phone number is not valid.');
          } else {
            Get.snackbar('Error', 'Something went wrong. Try again.');
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } catch (_) {
      const result = TExceptions();
      throw result.message;
    }
  }

  /// [PhoneAuthentication] - VERIFY PHONE NO BY OTP
  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(verificationId: verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }

  /// [EmailAuthentication] - LOGIN
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
        print('on signin $value.user?.uid');
      });
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code); // Throw custom [message] variable
      throw result.message;
    } catch (_) {
      const result = TExceptions();
      throw result.message;
    }
  }

  /// [EmailAuthentication] - REGISTER
  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebaseUser != null
          ? Get.offAll(() => const LoginSetupPage()) // AppSettingScreen());//Dashboard())
          : Get.to(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = TExceptions.fromCode(e.code);
      throw ex.message;
    } catch (_) {
      const ex = TExceptions();
      throw ex.message;
    }
  }

  /// LOGOUT USER - Valid for GOOGLE, Facebook, Phone No, & other authentications.
  Future<void> logout() async {
    //await GoogleSignIn().disconnect();
    await _auth.signOut();
  }

  /// Google Sign In & Facebook Authentication

  /* /// [GoogleAuthentication]
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      googleUser = (await GoogleSignIn().signIn())!;

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      final ex = TExceptions.fromCode(e.code);
      throw ex.message;
    } catch (e) {
      throw e.toString().isEmpty
          ? 'Unknown Error Occurred. Try again!'
          : e.toString();
    }
  }
  ///[FacebookAuthentication]
  Future<UserCredential> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult =
          await FacebookAuth.instance.login(permissions: ['email']);

      // Create a credential from the access token
      final AccessToken accessToken = loginResult.accessToken!;
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(accessToken.token);

      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      final ex = TExceptions.fromCode(e.code);
      throw ex.message;
    } catch (e) {
      throw e.toString().isEmpty
          ? 'Unknown Error Occurred. Try again!'
          : e.toString();
    }
  }
*/
}