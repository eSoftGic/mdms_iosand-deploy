import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../src/common_widgets/form/form_header_widget.dart';
import '../../src/constants/image_strings.dart';
import '../../src/constants/sizes.dart';
import '../../src/features/core/screens/dashboard/dashboard.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final phoneNoOtpController = TextEditingController();
  bool isloading = false;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              children: [
                const FormHeaderWidget(
                  image: tWelcomeScreenImage,
                  title: 'OTP',
                  subTitle: 'Verification',
                ),
                const SizedBox(
                  height: tDefaultSize + 40,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: phoneNoOtpController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(LineAwesomeIcons.code),
                      labelText: '6 Digit Code',
                      hintText: 'OTP'),
                ),
                const SizedBox(
                  height: tDefaultSize + 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isloading = true;
                      });
                      final credentials = PhoneAuthProvider.credential(
                          verificationId: widget.verificationId,
                          smsCode: phoneNoOtpController.text.toString().trim());
                      try {
                        await _auth.signInWithCredential(credentials);
                        Get.offAll(() => const Dashboard());
                        setState(() {
                          isloading = false;
                        });
                      } catch (e) {
                        setState(() {
                          isloading = false;
                        });
                        Get.snackbar("Error", e.toString(),
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(seconds: 5));
                      }
                    },
                    child: isloading
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text("Verifying...")
                            ],
                          )
                        : const Text('Verify'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}