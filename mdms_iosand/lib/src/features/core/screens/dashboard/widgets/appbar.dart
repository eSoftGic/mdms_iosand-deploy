import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/constants/constants.dart';
//import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../../../../../singletons/AppData.dart';
//import '../../../../../constants/colors.dart';
//import '../../../../../constants/image_strings.dart';
//import '../../../../../constants/text_strings.dart';
//import '../../../../../repository/authentication_repository/authentication_repository.dart';
import '../../profile/profile_screen.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({
    super.key,
    this.isDark = false,
  });
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    String? dbtitle = appData.log_type == 'PRT' ? appData.prtnm : tAppName;
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leading: InkWell(
        onTap: () {
          Get.to(() => const ProfileScreen());
        },
        child: Icon(
          Icons.menu,
          color: isDark ? tWhiteColor : tDarkColor,
          size: 24,
        ),
      ),
      title: Text(dbtitle!, //tAppName + '\n' +
          style: Theme.of(context).textTheme.headlineSmall),
      /*
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20, top: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isDark
                  ? tCardLightColor.withOpacity(0.5)
                  : tCardBgColor.withOpacity(0.5),
            ),
            child: IconButton(
              onPressed: () => Get.to(() => const ProfileScreen()),
              icon: const Image(
                image: AssetImage(tUserProfileImage),
              ),
            ),
          ),
        ]*/
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
