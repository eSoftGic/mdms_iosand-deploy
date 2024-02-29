// ignore_for_file: unused_local_variable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/constants/colors.dart';
import 'package:mdms_iosand/src/ecommerce/controller/cart_controller.dart';
import 'package:mdms_iosand/src/ecommerce/widget/custom_appbar.dart';
//import 'package:mdms_iosand/src/ecommerce/widget/hero_carousel_card.dart';
import 'package:mdms_iosand/src/ecommerce/widget/imagebyte_widget.dart';
import '../controller/wishlist_controller.dart';
import '../models/ecomm_model.dart';

class ProductScreen extends StatelessWidget {
  final ItemModel product;
  const ProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    WishListController wlcontroller = Get.put(WishListController());
    CartController cartController = Get.put(CartController());

    List<Widget> carouselItems = [
      ImageByteWidget(
          b64: product.item_image.toString(), imgwid: 1000.0, imght: 300.0),
      ImageByteWidget(
          b64: product.item_image1.toString(), imgwid: 1000.0, imght: 300.0),
      ImageByteWidget(
          b64: product.item_image2.toString(), imgwid: 1000.0, imght: 300.0),
      ImageByteWidget(
          b64: product.item_image3.toString(), imgwid: 1000.0, imght: 300.0),
      ImageByteWidget(
          b64: product.item_image4.toString(), imgwid: 1000.0, imght: 300.0),
      ImageByteWidget(
          b64: product.item_image5.toString(), imgwid: 1000.0, imght: 300.0),
    ];

    final List<String> imgList = [
      product.item_image.toString().trim(),
      product.item_image1.toString().trim(),
      product.item_image2.toString().trim(),
      product.item_image3.toString().trim(),
      product.item_image4.toString().trim(),
    ];

    return Scaffold(
        appBar: CustomAppBar(
          title: product.item_nm!,
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
                  IconButton(
                      onPressed: () {
                        wlcontroller.addtoWishlist(product);
                      },
                      icon: const Icon(Icons.favorite, color: Colors.white)),
                  ElevatedButton(
                      onPressed: () {
                        cartController.addtoCartlist(product);
                      },
                      child: Text(
                        ' ADD TO CART ',
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
        body: ListView(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 1.5,
                viewportFraction: 0.9,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                enableInfiniteScroll: false,
                initialPage: 2,
                autoPlay: true,
              ),
              items: carouselItems,
              //items: [HeroCarouselCard(product: product)],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    alignment: Alignment.bottomCenter,
                    color: Colors.black.withAlpha(50),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width - 10,
                    height: 50,
                    alignment: Alignment.bottomCenter,
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(product.item_nm!,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(color: tWhiteColor)),
                          Text('${product.rate}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(color: tWhiteColor)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ExpansionTile(
                initiallyExpanded: true,
                title: Text(
                  'Details',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                children: [
                  Card(
                    elevation: 1.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Company ${product.company_nm!}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              'Brand ${product.item_brand_nm!}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Category ${product.item_cat_nm!}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              'Item Code${product.item_code!}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mrp ${product.mrp_ref}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              'Stock ${product.stock_qty}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ExpansionTile(
                initiallyExpanded: false,
                title: Text(
                  'Features',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                children: [
                  ListTile(
                    title: Text(
                      product.ordremark!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
