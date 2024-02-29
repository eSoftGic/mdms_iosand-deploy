// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mdms_iosand/src/constants/sizes.dart';
import 'package:mdms_iosand/src/constants/text_strings.dart';
import 'package:mdms_iosand/src/features/authentication/screens/setup/login_setup.dart';
import 'package:mdms_iosand/src/features/authentication/screens/setup/mdms_setting.dart';
import 'package:mdms_iosand/src/features/core/screens/profile/widgets/image_with_icon.dart';
import 'package:mdms_iosand/src/features/core/screens/profile/widgets/profile_menu.dart';
import 'package:mdms_iosand/src/utils/theme/theme.dart';

import '../../../../repository/authentication_repository/authentication_repository.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              LineAwesomeIcons.angle_left,
              size: 24,
            )),
        title: Text(tAppName, style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          IconButton(
            onPressed: () {
              Get.changeTheme(Get.isDarkMode ? TAppTheme.lightTheme : TAppTheme.darkTheme);
            },
            iconSize: 28,
            icon: Icon(Get.isDarkMode ? LineAwesomeIcons.sun : LineAwesomeIcons.moon),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              /// -- IMAGE with ICON
              const ImageWithIcon(),
              const SizedBox(height: 10),
              Text('Setup', style: Theme.of(context).textTheme.headlineMedium),
              /*Text(tProfileSubHeading,
                  style: Theme.of(context).textTheme.bodyMedium),*/
              const SizedBox(height: 20),

              /// -- BUTTON
              /*SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => UpdateProfileScreen()),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: tAccentColor.withOpacity(0.5),
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text(tEditProfile,
                      style: TextStyle(color: tDarkColor)),
                ),
              ),*/
              const Divider(color: Colors.blueGrey),
              const SizedBox(height: 10),

              /// -- MENU
              ProfileMenuWidget(
                  title: "Firm/Branch Selection",
                  icon: LineAwesomeIcons.server,
                  onPress: () => Get.to(const LoginSetupPage())),
              ProfileMenuWidget(
                  title: "User Rights",
                  icon: LineAwesomeIcons.user_check,
                  onPress: () => Get.to(const SettingPage())),
              /*ProfileMenuWidget(
                  title: "User Details",
                  icon: LineAwesomeIcons.user_check,
                  onPress: () => Get.to(AllUsers())),*/
              const Divider(color: Colors.blueGrey),
              const SizedBox(height: 10),
              /*ProfileMenuWidget(title: "Information", icon: LineAwesomeIcons.info, onPress: () {}),*/
              ProfileMenuWidget(
                  title: "Logout",
                  icon: LineAwesomeIcons.alternate_sign_out,
                  textColor: Colors.blueGrey,
                  endIcon: false,
                  onPress: () {
                    AuthenticationRepository.instance.logout();  
                    /*
                    Get.defaultDialog(
                      title: "LOGOUT",
                      titleStyle: const TextStyle(fontSize: 18),
                      content: const SizedBox(
                        height: 75,
                        width: 200,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          child: Text("Logout? "),
                        ),
                      ),
                      confirm: Expanded(
                        child: TextButton(
                          onPressed: () => AuthenticationRepository.instance.logout(),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.white, side: BorderSide.none),
                          child: const Text(
                            "Yes",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                      cancel: TextButton(
                        onPressed: () => Get.back(),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white, side: BorderSide.none),
                        child: const Text(
                          "Back",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                    */
                  }
                  ),
            ],
          ),
        ),
      ),
    );
  }
}