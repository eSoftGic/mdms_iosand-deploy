import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get_core/src/get_main.dart';
import 'package:mdms_iosand/src/constants/colors.dart';
import 'package:mdms_iosand/src/constants/text_strings.dart';

import '../../../../constants/sizes.dart';
import '../../controllers/login_controller.dart';

class LoginFormPhoneWidget extends StatelessWidget {
  const LoginFormPhoneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final formPhoneKey = GlobalKey<FormState>();

    return Form(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
        child: Form(
          key: formPhoneKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: controller.phoneno,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == '' || value == null) {
                    return "Enter your phone no. with country code";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.mobile_friendly),
                  labelText: tPhoneNo,
                  hintText: tPhoneNo,
                ),
              ),
              const SizedBox(height: tFormHeight - 20),
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(tPrimaryColor)),
                    onPressed: controller.isLoading.value
                        ? () {}
                        : () {
                            if (formPhoneKey.currentState!.validate()) {
                              LoginController.instance.loginUser(
                                  '', '', controller.phoneno.text.trim());
                            }
                          },
                    child: controller.isLoading.value
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
                              Text("Generating OTP")
                            ],
                          )
                        : Text(tPhoneLogin.toUpperCase()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}