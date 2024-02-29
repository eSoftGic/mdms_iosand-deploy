import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/ecommerce/controller/wishlist_controller.dart';
import '../widget/widget.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WishListController wlcontroller = Get.put(WishListController());

    return Scaffold(
        appBar: const CustomAppBar(
          title: 'WishList',
          isWishList: true,
        ),
        bottomNavigationBar: const CustomNavBar(),
        body: Obx(() {
          return GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 2.2,
              ),
              itemCount: wlcontroller.lislen.value,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                    child: ProductCard(
                  product: wlcontroller.wishlist[index],
                  widthFactor: 1.1,
                  leftPosition: 100,
                  isWishlist: true,
                ));
              });
        }));
  }
}