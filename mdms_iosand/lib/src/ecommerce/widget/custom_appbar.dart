import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isWishList;
  final bool isCartList;
  final bool isRefresh;
  // ignore: prefer_typing_uninitialized_variables
  final onpressed;
  const CustomAppBar(
      {super.key,
      required this.title,
      this.isWishList = false,
      this.isCartList = false,
      this.isRefresh = false,
      this.onpressed});

  @override
  Widget build(BuildContext context) {
    //WishListController wlcontroller = Get.put(WishListController());
    //OrderCartController cartController = Get.put(OrderCartController());

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      actions: [
        isRefresh == true
            ? IconButton(
                icon: const Icon(
                  Icons.refresh,
                  color: tPrimaryColor,
                  size: 24,
                ),
                onPressed: onpressed)
            : const SizedBox(),
        isWishList == true
            ? IconButton(
                icon: const Icon(
                  Icons.delete_forever,
                  color: tPrimaryColor,
                  size: 24,
                ),
                onPressed: () {
                  //wlcontroller.clearWishlist();
                })
            : const SizedBox(),
        /*Obx(() {
          return cartController.lislen > 0 && isCartList == false
              ? IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: tPrimaryColor,
                    size: 24,
                  ),
                  onPressed: () {
                    Get.to(() => CartScreen());
                  })
              : cartController.lislen > 0 && isCartList == true
                  ? IconButton(
                      icon: Icon(
                        Icons.delete_forever,
                        color: tPrimaryColor,
                        size: 24,
                      ),
                      onPressed: () {
                        cartController.clearCartlist();
                      })
                  : SizedBox();
        }),*/
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
