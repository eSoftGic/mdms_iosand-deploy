import 'package:flutter/material.dart';
import 'package:mdms_iosand/src/constants/image_strings.dart';
import 'package:mdms_iosand/src/constants/text_strings.dart';
import 'package:mdms_iosand/src/features/authentication/screens/widgets/signup_footer_widget.dart';
import 'package:mdms_iosand/src/features/authentication/screens/widgets/signup_form_widget.dart';
import '../../../common_widgets/form/form_header_widget.dart';
import '../../../constants/sizes.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: const Column(
              children: [
                FormHeaderWidget(
                  image: tWelcomeScreenImage,
                  title: tSignUpTitle,
                  subTitle: tSignUpSubTitle,
                  imageHeight: 0.1,
                ),
                SignUpFormWidget(),
                SignUpFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}