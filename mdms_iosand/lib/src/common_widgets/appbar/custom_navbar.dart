import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/core/screens/dashboard/dashboard.dart';
import '../../../src/constants/colors.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: tWhiteColor,
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                icon: const Icon(
                  Icons.home,
                  color: tPrimaryColor,
                ),
                onPressed: () {
                  Get.to(() => const Dashboard());
                }),
            /*IconButton(
                icon: const Icon(Icons.shopping_cart, color: tPrimaryColor),
                onPressed: () {
                  Get.to(() => const CartScreen());
                }),
            IconButton(
                icon: const Icon(Icons.favorite, color: tPrimaryColor),
                onPressed: () {
                  Get.to(() => const WishListScreen());
                }),*/
          ],
        ),
      ),
    );
  }
}
