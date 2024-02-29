import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/ecommerce/controller/cart_controller.dart';
import 'package:mdms_iosand/src/ecommerce/controller/wishlist_controller.dart';
import '../../constants/constants.dart';
import '../models/ecomm_model.dart';
import '../screen/product_screen.dart';
import 'imagebyte_widget.dart';

class ProductCard extends StatelessWidget {
  final ItemModel product;
  final double widthFactor;
  final double leftPosition;
  final bool isWishlist;
  const ProductCard({
    super.key,
    required this.product,
    this.widthFactor = 2.2,
    this.leftPosition = 5,
    this.isWishlist = false,
  });

  @override
  Widget build(BuildContext context) {
    final double widthValue = MediaQuery.of(context).size.width / widthFactor;
    WishListController wishListController = Get.put(WishListController());
    CartController cartController = Get.put(CartController());

    return InkWell(
      onTap: () {
        Get.to(() => ProductScreen(product: product));
      },
      child: Stack(
        children: [
          SizedBox(
            width: widthValue,
            height: 150,
            child: ImageByteWidget(b64: product.item_image.toString().trim()),
          ),
          Positioned(
            top: 60,
            left: leftPosition,
            child: Container(
              width: widthValue - leftPosition - 10,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(50),
              ),
            ),
          ),
          Positioned(
            top: 65,
            left: leftPosition + 5,
            child: Container(
              width: widthValue - leftPosition - 15,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(50),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.item_nm!,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: tWhiteColor,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Text(
                            product.rate!.toStringAsFixed(2),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: tWhiteColor),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: IconButton(
                            onPressed: () {
                              cartController.addtoCartlist(product);
                            },
                            icon: const Icon(
                              Icons.add_circle,
                              color: tWhiteColor,
                            ))),
                    isWishlist
                        ? Expanded(
                            child: IconButton(
                                onPressed: () {
                                  wishListController.removefromWishlist(product);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: tWhiteColor,
                                )))
                        : Expanded(
                            child: IconButton(
                                onPressed: () {
                                  wishListController.addtoWishlist(product);
                                },
                                icon: const Icon(
                                  Icons.favorite_border_outlined,
                                  color: tWhiteColor,
                                ))),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}