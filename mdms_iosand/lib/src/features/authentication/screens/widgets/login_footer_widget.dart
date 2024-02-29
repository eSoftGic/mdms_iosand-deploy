import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/authentication/screens/signup_screen.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: tFormHeight - 20),
        /*SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: const Image(image: AssetImage(tGoogleLogoImage), width: 20.0),
            onPressed: () => LoginController.instance.googleSignIn(),
            label: const Text(tSignInWithGoogle),
          ),
        ),*/
        /*const SizedBox(height: tFormHeight - 20),*/
        /*
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: const Icon(LineAwesomeIcons.facebook),
            onPressed: () => LoginController.instance.facebookSignIn(),
            label: const Text("Sign In With Facebook"),
          ),
        ),
        */
        const SizedBox(height: tFormHeight - 20),
        TextButton(
          onPressed: () => Get.off(() => const SignUpScreen()),
          child: Text.rich(
            TextSpan(
                text: tDontHaveAnAccount,
                style: Theme.of(context).textTheme.bodyLarge,
                children: const [
                  TextSpan(text: tSignup, style: TextStyle(color: Colors.blue))
                ]),
          ),
        ),
      ],
    );
  }
}