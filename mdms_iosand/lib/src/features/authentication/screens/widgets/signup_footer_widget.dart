import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:mdms_iosand/src/features/authentication/controllers/signup_controller.dart';
import 'package:mdms_iosand/src/features/authentication/screens/login_screen.dart';

import '../../../../constants/text_strings.dart';

class SignUpFooterWidget extends StatelessWidget {
  const SignUpFooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /*const Text("OR"),
        const SizedBox(height: 10.0),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => SignUpController.instance.googleSignIn(),
            icon: const Image(
              image: AssetImage(tGoogleLogoImage),
              width: 20.0,
            ),
            label: Text(tSignInWithGoogle.toUpperCase()),
          ),
        ),
        */
        const SizedBox(height: 20.0),
        TextButton(
          onPressed: () => Get.off(() => const LoginScreen()),
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: tAlreadyHaveAnAccount,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextSpan(text: tLogin.toUpperCase())
          ])),
        )
      ],
    );
  }
}
