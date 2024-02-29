// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../../authentication/models/user_model.dart';
import '../../controllers/profile_controller.dart';

class ProfileFormSetupScreen extends StatelessWidget {
  const ProfileFormSetupScreen({
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
          const SizedBox(height: tFormHeight),

          /// -- Form Submit Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                /*final userData = UserModel(
                    id: user.id,
                    email: email.text.trim(),
                    password: password.text.trim(),
                    username: username.text.trim(),
                    phoneno: phoneNo.text.trim(),

                    fbauid: AuthenticationRepository.instance.getUserID
                        .toString()
                        .trim());*/

                //await controller.updateRecord(userData);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: tAccentColor.withOpacity(0.5),
                  side: BorderSide.none,
                  shape: const StadiumBorder()),
              child:
                  const Text(tEditProfile, style: TextStyle(color: tDarkColor)),
            ),
          ),
          const SizedBox(height: tFormHeight),

          /// -- Created Date and Delete Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text.rich(
                TextSpan(
                  text: tJoined,
                  style: TextStyle(fontSize: 12),
                  children: [
                    TextSpan(
                        text: tJoinedAt,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12))
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent.withOpacity(0.1),
                    elevation: 0,
                    foregroundColor: Colors.red.shade900,
                    shape: const StadiumBorder(),
                    side: BorderSide.none),
                child: const Text(tDelete),
              ),
            ],
          )
        ],
      ),
    );
  }
}