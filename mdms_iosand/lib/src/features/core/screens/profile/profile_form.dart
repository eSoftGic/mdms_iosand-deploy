import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../../authentication/models/user_model.dart';
import '../../controllers/profile_controller.dart';

class ProfileFormScreen extends StatelessWidget {
  const ProfileFormScreen({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: controller.baseurl,
            decoration: const InputDecoration(
                label: Text('Api'), prefixIcon: Icon(LineAwesomeIcons.link)),
          ),
          const SizedBox(height: tFormHeight - 20),
          TextFormField(
            controller: controller.username,
            decoration: const InputDecoration(
                label: Text('User Name'),
                prefixIcon: Icon(LineAwesomeIcons.user)),
          ),
          const SizedBox(height: tFormHeight - 20),
          TextFormField(
            controller: controller.password,
            decoration: const InputDecoration(
                label: Text(tPassword),
                prefixIcon: Icon(LineAwesomeIcons.fingerprint)),
          ),
          const SizedBox(height: tFormHeight - 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                await controller.checkUser(
                    controller.baseurl.toString(),
                    controller.username.toString(),
                    controller.password.toString());
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: tAccentColor.withOpacity(0.5),
                  side: BorderSide.none,
                  shape: const StadiumBorder()),
              child:
                  const Text('Check API', style: TextStyle(color: tDarkColor)),
            ),
          ),
          const SizedBox(height: tFormHeight),
        ],
      ),
    );
  }
}