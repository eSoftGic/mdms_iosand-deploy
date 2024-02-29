import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mdms_iosand/src/common_widgets/form/form_header_widget.dart';
import 'package:mdms_iosand/src/constants/image_strings.dart';
import 'package:mdms_iosand/src/constants/text_strings.dart';
import 'package:mdms_iosand/ztemp/login_auth_firebase/verify_code.dart';
import '../../src/constants/sizes.dart';

class LoginPhoneScreen extends StatefulWidget {
  const LoginPhoneScreen({super.key});

  @override
  State<LoginPhoneScreen> createState() => _LoginPhoneScreenState();
}

class _LoginPhoneScreenState extends State<LoginPhoneScreen> {
  final phoneNoController = TextEditingController();
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
                  title: tLoginTitle,
                  subTitle: tLoginSubTitlePhone,
                ),
                const SizedBox(
                  height: tDefaultSize + 40,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == '' || value == null) {
                      return "Enter phone no with country code ex. +91";
                    } else {
                      return null;
                    }
                  },
                  controller: phoneNoController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(LineAwesomeIcons.mobile_phone),
                      labelText: tPhoneNo,
                      hintText: '+91'),
                ),
                const SizedBox(
                  height: tDefaultSize + 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isloading = true;
                      });

                      _auth.verifyPhoneNumber(
                          phoneNumber: phoneNoController.text.trim(),
                          verificationCompleted: (_) {
                            setState(() {
                              isloading = false;
                            });
                          },
                          verificationFailed: (e) {
                            setState(() {
                              isloading = false;
                            });

                            Get.snackbar("Error", e.toString(),
                                snackPosition: SnackPosition.BOTTOM,
                                duration: const Duration(seconds: 5));
                          },
                          codeSent: (String verificationId, int? token) {
                            Get.off(() => VerifyCodeScreen(
                                  verificationId: verificationId,
                                ));
                            setState(() {
                              isloading = false;
                            });
                          },
                          codeAutoRetrievalTimeout: (e) {
                            setState(() {
                              isloading = false;
                            });
                            Get.snackbar("Error", e.toString(),
                                snackPosition: SnackPosition.BOTTOM,
                                duration: const Duration(seconds: 5));
                          });
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
                              Text("Checking..")
                            ],
                          )
                        : Text('Get OTP'.toUpperCase()),
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