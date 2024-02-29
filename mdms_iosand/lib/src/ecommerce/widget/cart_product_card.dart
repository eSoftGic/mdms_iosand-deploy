import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/ecommerce/widget/widget.dart';
import '../../constants/constants.dart';
import '../controller/cart_controller.dart';
import '../models/ecomm_model.dart';

class CartProductCard extends StatelessWidget {
  final ItemModel product;
  final int quantity;
  const CartProductCard({super.key, required this.product, required this.quantity});

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          ImageByteWidget(
            b64: product.item_image.toString().trim(),
            imgwid: 100,
            imght: 80,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.item_nm!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: tPrimaryColor)),
                Text(product.rate!.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: tPrimaryColor)),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle),
                onPressed: () {
                  cartController.removefromCartlist(product);
                },
              ),
              Text('$quantity',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: tPrimaryColor)),
              IconButton(
                icon: const Icon(Icons.add_circle),
                onPressed: () {
                  cartController.addtoCartlist(product);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}