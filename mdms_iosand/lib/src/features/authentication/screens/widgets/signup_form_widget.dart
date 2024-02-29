import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mdms_iosand/src/constants/colors.dart';
import 'package:mdms_iosand/src/features/authentication/models/user_model.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../../../repository/authentication_repository/authentication_repository.dart';
import '../../controllers/signup_controller.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final formKey = GlobalKey<FormState>();

    controller.getDeviceId();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.username,
              decoration: const InputDecoration(
                  label: Text(tFullName),
                  prefixIcon: Icon(LineAwesomeIcons.user)),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                  label: Text(tEmail),
                  prefixIcon: Icon(LineAwesomeIcons.envelope)),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: controller.phoneno,
              decoration: const InputDecoration(
                  label: Text(tPhoneNo),
                  prefixIcon: Icon(LineAwesomeIcons.phone)),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: controller.password,
              decoration: const InputDecoration(
                  label: Text(tPassword), prefixIcon: Icon(Icons.fingerprint)),
            ),
            const SizedBox(height: tFormHeight - 10),
            Obx(
              () => Center(
                child: Text(
                  controller.deviceid.toString(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: tPrimaryColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: tFormHeight - 10),
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      /// Phone Authentication
                      /*if (controller.email.text.toString().trim().length == 0 &&
                          controller.phoneNo.text.toString().trim().length >
                              0) {
                        SignUpController.instance.phoneAuthentication(
                            controller.phoneNo.text.trim());
                        Get.to(() => const OTPScreen());
                      } else {
                        /// Email & Password Authentication
                        SignUpController.instance.emailAuthentication(
                            controller.email.text.trim(),
                            controller.password.text.trim());*/
                      /*
                       =========
                       Todo:Step - 3 [Get User and Pass it to Controller]
                       =========
                      */

                      final user = UserModel(
                          deviceid: controller.deviceid.toString(),
                          username: controller.username.text.trim(),
                          phoneno: controller.phoneno.text.trim(),
                          email: controller.email.text.trim(),
                          password: controller.password.text.trim(),
                          fbauid: AuthenticationRepository.instance.getUserID
                              .toString()
                              .trim());

                      SignUpController.instance.createUser(user);
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
                            Text("Loading...")
                          ],
                        )
                      : Text(tSignup.toUpperCase()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}