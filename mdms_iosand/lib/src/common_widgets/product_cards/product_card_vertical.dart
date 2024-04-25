import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/constants/colors.dart';
import 'package:mdms_iosand/src/constants/image_strings.dart';
import 'package:mdms_iosand/src/features/core/screens/order/add_order/model_item.dart';
import 'package:mdms_iosand/src/features/core/screens/order/add_order/screen_product.dart';
import 'package:mdms_iosand/src/features/core/screens/order/tproduct_card_vertical.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({super.key, required this.product});

  final ItemModel product;
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    bool hasimage = (product.item_image!.isNotEmpty);

    return GestureDetector(
      onTap: () {
        debugPrint('Card Clciked ${product.item_nm}');
      },
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(16),
          color: isDark ? Colors.grey : Colors.white.withOpacity(0.8),
        ),
        child: Column(children: [
          TRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(4),
              backgroundColor: isDark
                  ? Colors.grey.withOpacity(0.1)
                  : tPrimaryColor.withOpacity(0.1),
              child: Stack(
                children: [
                  TRoundedImage(
                    imageUrl: hasimage ? product.item_image! : tNoImage,
                    applyImageRadius: false,
                    isImageByByte: hasimage,
                    height: 180,
                    width: 180,
                  ),
                  // Stock on Left Top
                  Positioned(
                    bottom: 5,
                    left: 5,
                    child: TRoundedContainer(
                      radius: 4,
                      backgroundColor: tCardLightColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Text(
                        'Stock ${product.stock_qty}',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),

                  /*
                  // fav on Right top
                  const Positioned(
                    top: -5,
                    right: -3,
                    child: TCircularIcon(
                      icon: Icons.favorite_border_outlined,
                      color: Colors.red,
                    ),
                  ),
                  */
                ],
              )),
          const SizedBox(
            height: 4,
          ),
          // Details
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Column(
              children: [
                TProductTitleText(
                  title: product.item_nm,
                  smallSize: false,
                ),
                Row(
                  children: [
                    Text(
                      product.item_brand_nm!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    /*
                    const Spacer(),
                    const Icon(
                      Icons.verified,
                      color: Colors.green,
                      size: 16,
                    )
                    */
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Price
                    Text(
                      product.mst_sal_rate!.toStringAsFixed(2),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    product.ord_qty! > 0
                        ? TRoundedContainer(
                            radius: 4,
                            backgroundColor: tPrimaryColor.withOpacity(0.3),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(product.ord_qty.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(color: Colors.red)),
                          )
                        : Container(
                            decoration: const BoxDecoration(
                              color: tPrimaryColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16)),
                            ),
                            child: SizedBox(
                              width: 28 * 1.2,
                              height: 28 * 1.2,
                              child: IconButton(
                                  icon: const Icon(Icons.add),
                                  iconSize: 18.0,
                                  color: tWhiteColor,
                                  onPressed: () {
                                    Get.to(() => ItemScreen(
                                          product: product,
                                        ));
                                  }),
                            ),
                          ),
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
