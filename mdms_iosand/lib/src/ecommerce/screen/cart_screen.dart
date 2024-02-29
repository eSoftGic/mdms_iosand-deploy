import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get_core/src/get_main.dart';
import 'package:mdms_iosand/src/constants/colors.dart';
import 'package:mdms_iosand/src/ecommerce/screen/checkout_screen.dart';
import 'package:mdms_iosand/src/ecommerce/screen/home_screen.dart';
//import 'package:mdms_iosand/src/ecommerce/widget/custom_appbar.dart';
import '../controller/cart_controller.dart';
//import '../models/ecomm_model.dart';
import '../widget/widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Cart Screen',
        isWishList: false,
        isCartList: true,
      ),
      bottomNavigationBar: BottomAppBar(
        // CustomNavBar(),
        color: Colors.black,
        child: SizedBox(
          height: 75,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Get.to(() => const CheckOutScreen());
                    },
                    child: Text(
                      ' CHECKOUT ',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: tWhiteColor),
                    ))
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(cartController.deliveryFeeString,
                            style: Theme.of(context).textTheme.headlineSmall),
                        ElevatedButton(
                          onPressed: () {
                            Get.to(() => const HomeScreen());
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: tAccentColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              elevation: 0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 10),
                            child: Text('Add Items..',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: tWhiteColor)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                        height: 300,
                        child: Obx(() {
                          return ListView.builder(
                              itemCount: cartController
                                  .productQuantity(cartController.cartlist)
                                  .keys
                                  .length,
                              itemBuilder: (context, index) {
                                return CartProductCard(
                                    product: cartController
                                        .productQuantity(
                                            cartController.cartlist)
                                        .keys
                                        .elementAt(index),
                                    quantity: cartController
                                        .productQuantity(
                                            cartController.cartlist)
                                        .values
                                        .elementAt(index));
                              });
                        })),
                  ],
                );
              }),
              const OrderSummary(),

              /*Obx(() {
            return Column(
              children: [
                Divider(
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          '${cartController.subtotstr.value}',
                          style: Theme.of(context).textTheme.headlineMedium,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Other Charges',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          '${cartController.deliveryFeeString}',
                          style: Theme.of(context).textTheme.headlineMedium,
                        )
                      ],
                    ),
                  ]),
                ),
                SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(50),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(5),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total ',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(color: tWhiteColor),
                            ),
                            Text(
                              '${cartController.biltotalString}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(color: tWhiteColor),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            );
          }),*/
            ]),
      ),
    );
  }
}
