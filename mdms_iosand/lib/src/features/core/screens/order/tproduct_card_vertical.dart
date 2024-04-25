// ignore_for_file: avoid_unnecessary_containers, prefer_if_null_operators, unnecessary_cast

import 'package:flutter/material.dart';
import 'package:mdms_iosand/src/constants/colors.dart';
import 'package:mdms_iosand/src/ecommerce/widget/imagebyte_widget.dart';
import '../../../../constants/image_strings.dart';
import 'add_order/model_item.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key, required this.product});

  final ItemModel product;
  @override
  Widget build(BuildContext context) {
    debugPrint(product.item_nm);
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(
            boxShadow: [TShadowStyle.verticalProductShadow],
            borderRadius: BorderRadius.circular(16.0),
            color: tWhiteColor),
        child: Column(
          children: [
            /// Thumbnail, Wishlist Button, Discount Tag
            TRoundedContainer(
              width: 100,
              height: 100,
              padding: const EdgeInsets.all(8),
              backgroundColor: tCardLightColor,
              child: Stack(
                children: [
                  Center(
                    child: TRoundedImage(
                      imageUrl: product.item_image.toString(),
                      applyImageRadius: true,
                    ),
                  ),
                  // sale tag
                  Positioned(
                    top: 12,
                    child: TRoundedContainer(
                      radius: 8,
                      backgroundColor: Colors.yellow.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Text(product.stock_qty.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .apply(color: tPrimaryColor)),
                    ),
                  ),
                  /*
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: TCircularIcon(
                      icon: Icons.favorite_outline,
                      color: Colors.grey,
                    ),
                  )*/
                ],
              ),
            ),

            const SizedBox(
              height: 4,
            ),

            /// Details
            Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TProductTitleText(
                      title: product.item_nm.toString(),
                      smallSize: true,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          product.item_brand_nm.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        /*
                        const SizedBox(
                          width: 4,
                        ),
                        const Icon(
                          Icons.verified,
                          color: Colors.green,
                          size: 16,
                        )
                        */
                      ],
                    ),
                    //Spacer(),
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
                        Container(
                          decoration: const BoxDecoration(
                            color: tPrimaryColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16)),
                          ),
                          child: const SizedBox(
                            width: 28 * 1.2,
                            height: 28 * 1.2,
                            child: Icon(
                              Icons.add,
                              color: tWhiteColor,
                              size: 18,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class TProductTitleText extends StatelessWidget {
  const TProductTitleText({
    super.key,
    required this.title,
    this.smallSize = false,
    this.maxLines = 2,
    this.textAlign = TextAlign.left,
  });

  final String? title;
  final bool smallSize;
  final int maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toString(),
      style: smallSize
          ? Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: tPrimaryColor)
          : Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: tPrimaryColor),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}

class TCircularIcon extends StatelessWidget {
  const TCircularIcon({
    super.key,
    this.width,
    this.height,
    this.size = 16,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onPressed,
  });

  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor != null
            ? backgroundColor
            : tWhiteColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
          onPressed: onPressed, icon: Icon(icon, color: color, size: size)),
    );
  }
}

class TShadowStyle {
  static final verticalProductShadow = BoxShadow(
      color: tCardLightColor.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));

  static final horizontalProductShadow = BoxShadow(
      color: tCardDarkColor.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));
}

class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer({
    super.key,
    this.width,
    this.height,
    this.radius = 16,
    required this.child,
    this.showBorder = true,
    this.borderColor = tCardLightColor,
    this.backgroundColor = tWhiteColor,
    this.padding,
    this.margin,
  });

  final double? width;
  final double? height;
  final double radius;
  final Widget child;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}

class TRoundedImage extends StatelessWidget {
  const TRoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor = tWhiteColor,
    this.fit,
    this.padding,
    this.isNetWorkImage = false,
    this.isImageByByte = false,
    this.onPressed,
    this.borderRadius = 16,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetWorkImage;
  final bool isImageByByte;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
            borderRadius: applyImageRadius
                ? BorderRadius.circular(borderRadius)
                : BorderRadius.zero,
            child: isImageByByte == true
                ? imageUrl != 'na'
                    ? ImageByteWidget(
                        b64: imageUrl,
                        imgwid: width,
                        imght: height,
                      )
                    : Image(
                        width: width,
                        height: height,
                        fit: fit,
                        image: AssetImage(imageUrl) as ImageProvider)
                : isNetWorkImage == false
                    ? Image(fit: fit, image: AssetImage(imageUrl))
                    : Image(
                        // here add network image
                        fit: fit,
                        width: width,
                        height: height,
                        image: AssetImage(imageUrl) as ImageProvider)),
      ),
    );
  }
}
