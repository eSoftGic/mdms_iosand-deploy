import 'package:flutter/material.dart';
import 'package:mdms_iosand/src/common_widgets/form/form_header_widget.dart';
import 'package:mdms_iosand/src/constants/image_strings.dart';
import 'package:mdms_iosand/src/constants/text_strings.dart';
//import 'package:mdms_iosand/src/features/authentication/screens/widgets/login_form_phone_widget.dart';
import '../../../constants/sizes.dart';
import 'widgets/login_footer_widget.dart';
import 'widgets/login_form_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  title: tLoginTitle,
                  subTitle: tLoginSubTitleEmail,
                ),
                SizedBox(
                  height: tDefaultSize - 10,
                ),
                //LoginFormPhoneWidget(),
                SizedBox(
                  height: tDefaultSize - 20,
                ),
                LoginFormWidget(),
                LoginFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
