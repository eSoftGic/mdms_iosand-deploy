import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/constants.dart';
import '../controller/cart_controller.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());

    return Obx(() {
      return Column(
        children: [
          const Divider(
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
                    cartController.subtotstr.value,
                    style: Theme.of(context).textTheme.headlineMedium,
                  )
                ],
              ),
              const SizedBox(
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
                    cartController.deliveryFeeString,
                    style: Theme.of(context).textTheme.headlineMedium,
                  )
                ],
              ),
            ]),
          ),
          const SizedBox(
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
                margin: const EdgeInsets.all(5),
                height: 50,
                decoration: const BoxDecoration(
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
                        cartController.biltotalString,
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
    });
  }
}