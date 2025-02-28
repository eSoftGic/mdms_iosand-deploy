import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mdms_iosand/src/features/authentication/controllers/login_controller.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final formKey = GlobalKey<FormState>();

    return Form(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == '' || value == null) {
                    return "Add your Email";
                  } else if (!GetUtils.isEmail(value)) {
                    return "Invalid Email Address";
                  } else {
                    return null;
                  }
                },
                controller: controller.email,
                decoration: const InputDecoration(
                    prefixIcon: Icon(LineAwesomeIcons.user),
                    labelText: tEmail,
                    hintText: tEmail),
              ),
              const SizedBox(height: tFormHeight - 20),
              TextFormField(
                obscureText: true,
                controller: controller.password,
                validator: (value) {
                  if (value == '' || value == null) {
                    return "Enter your Password";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.fingerprint),
                    labelText: tPassword,
                    hintText: tPassword,
                    suffixIcon: Icon(LineAwesomeIcons.eye_slash)),
              ),
              const SizedBox(height: tFormHeight - 20),
              /*/// -- FORGET PASSWORD BTN
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () =>
                      ForgetPasswordScreen.buildShowModalBottomSheet(context),
                  child: const Text(tForgetPassword),
                ),
              ),*/

              /// -- LOGIN BTN
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
                            if (formKey.currentState!.validate()) {
                              LoginController.instance.loginUser(
                                  controller.email.text.trim(),
                                  controller.password.text.trim(),
                                  '');
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
                              Text("Validating User")
                            ],
                          )
                        : Text(tEmailLogin.toUpperCase()),
                  ),
                ),
              ),
              const SizedBox(height: tFormHeight - 10),
            ],
          ),
        ),
      ),
    );
  }
}