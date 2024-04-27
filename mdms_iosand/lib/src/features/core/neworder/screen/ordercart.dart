// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/common_widgets/appbar/appbar.dart';
import 'package:mdms_iosand/src/common_widgets/custom_shapes/container/primary_header_container.dart';
import 'package:mdms_iosand/src/constants/colors.dart';
import 'package:mdms_iosand/src/constants/image_strings.dart';
import 'package:mdms_iosand/src/features/core/neworder/controller/controller_orderbasic.dart';
import 'package:mdms_iosand/src/features/core/orderdb/orderhome.dart';
import 'package:mdms_iosand/src/features/core/neworder/controller/controller_cart.dart';
import 'package:mdms_iosand/src/features/core/screens/order/tproduct_card_vertical.dart';

class OrdercartScreen extends StatelessWidget {
  const OrdercartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OrderCartController cartController = Get.put(OrderCartController());
    OrderBasicController controller = Get.put(OrderBasicController());

    bool isDark = Theme.of(context).brightness == Brightness.dark;
    String ordprtnm = controller.acnm.value.toString();
    String ordbuk = '# ${controller.buknm.value}  ${controller.ordrefno.value}';

    return Scaffold(
        bottomNavigationBar: CartBottomBar(isDark, cartController, context),
        body: SingleChildScrollView(
          child: Column(children: [
            const TPrimaryHeaderContainer(
                height: 150,
                child: TAppBar(
                  title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ORDER SUMMARY'),
                        SizedBox(
                          height: 8,
                        ),
                        Text('Cart List',
                            style:
                                TextStyle(fontSize: 16, color: tPrimaryColor)),
                      ]),
                  showBackArrow: true,
                )),
            Text(ordprtnm,
                style: const TextStyle(fontSize: 16, color: tPrimaryColor)),
            const SizedBox(height: 4),
            Text(ordbuk,
                style: const TextStyle(fontSize: 16, color: tPrimaryColor)),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, __) => const SizedBox(
                  height: 8,
                ),
                itemCount: cartController.lislen.value,
                itemBuilder: (context, index) =>
                    CartItem(context, index, cartController),
              ),
            ),
          ]),
        ));
  }

  CartItem(
      BuildContext context, int index, OrderCartController cartcontroller) {
    bool hasimage = false;
    if (cartcontroller.cartlist[index].item_image!
        .toString()
        .trim()
        .isNotEmpty) {
      if (cartcontroller.cartlist[index].item_image!.toString().trim() !=
          'na') {
        hasimage = true;
      }
    }
    String imgurl = hasimage
        ? cartcontroller.cartlist[index].item_image!.toString().trim()
        : tNoImage;
    //debugPrint(cartcontroller.cartlist[index].item_nm);
    //debugPrint(imgurl);
    //debugPrint(hasimage.toString());

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 4,
                child: TRoundedImage(
                  imageUrl: imgurl,
                  isNetWorkImage: false,
                  backgroundColor: tCardDarkColor,
                  applyImageRadius: true,
                  isImageByByte: hasimage,
                  height: 80,
                  width: 80,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(cartcontroller.cartlist[index].item_nm!,
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyLarge),
                    Text(cartcontroller.cartlist[index].item_brand_nm!,
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodySmall),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Qty ${cartcontroller.cartlist[index].ord_qty}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                        Text(
                            'Rs. ${cartcontroller.cartlist[index].itemnet!.toStringAsFixed(2)}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                        IconButton(
                            icon: const Icon(Icons.delete_forever,
                                size: 24, color: tPrimaryColor),
                            onPressed: () {
                              cartcontroller.removefromCartlist(
                                  cartcontroller.cartlist[index]);
                            })
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container CartBottomBar(
      bool isDark, OrderCartController cartcontroller, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: isDark ? tCardDarkColor : tCardLightColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          TextButton(
            onPressed: () async {
              if (cartcontroller.cartlist.isEmpty) {
                buildMsg('No Products to Save', '', Colors.red, tWhiteColor);
              } else {
                //debugPrint('Saving Cart ');

                cartcontroller.saveOrder();

                //debugPrint('Card Saved');

                Get.delete<OrderBasicController>(force: true);
                Get.delete<OrderCartController>(force: true);
                Get.to(() => const OrderHomeView());
              }
            },
            child: Text(
              'Save Order',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: tPrimaryColor, fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () async {
              Get.delete<OrderBasicController>(force: true);
              Get.delete<OrderCartController>(force: true);
              Get.to(() => const OrderHomeView());
            },
            child: Text(
              'Cancel',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: tPrimaryColor, fontWeight: FontWeight.bold),
            ),
          ),
        ]),
      ),
    );
  }

  Future<dynamic> buildMsg(
      String title, String mtext, Color tcolor, Color mcolor) {
    return Get.defaultDialog(
      title: title,
      middleText: mtext,
      backgroundColor: tAccentColor.withOpacity(0.5),
      titleStyle: TextStyle(color: tcolor, fontSize: 20),
      middleTextStyle: TextStyle(color: mcolor),
      radius: 15,
      barrierDismissible: true,
      textConfirm: "OK",
      buttonColor: tCardBgColor,
    );
  }
}
