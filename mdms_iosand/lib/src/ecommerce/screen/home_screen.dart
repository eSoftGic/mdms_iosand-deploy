// ignore_for_file: avoid_unnecessary_containers, invalid_use_of_protected_member

import 'package:carousel_slider/carousel_slider.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get_core/src/get_main.dart';
import 'package:mdms_iosand/src/ecommerce/controller/item_controller.dart';
import 'package:mdms_iosand/src/ecommerce/models/ecomm_model.dart';
import 'package:mdms_iosand/src/ecommerce/widget/widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ItemController itemController = Get.put(ItemController());

    return Scaffold(
      appBar: const CustomAppBar(title: 'Dealer Name'),
      bottomNavigationBar: const CustomNavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Category Caroulsel Slider
            Container(
                child: CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 1.5,
                viewportFraction: 0.9,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                enableInfiniteScroll: false,
                //initialPage: 2,
                //autoPlay: true,
                //autoPlay: true,
              ),
              items: CategoryModel.prdcategories
                  .map((category) => HeroCarouselCard(
                        category: category,
                        product: null,
                      ))
                  .toList(),
            )),

            const SectionTitle(title: 'RECOMMENDED'),
            Obx(() {
              return ProductCarousel(
                  products: itemController.reslist.value
                      .where((element) => element.tbl_id! <= 5)
                      .toList());
            }),
            const SectionTitle(title: 'MOST POPULAR'),
            Obx(() {
              return ProductCarousel(
                  products: itemController.reslist.value
                      .where((product) => product.tbl_id! > 15 && product.tbl_id! <= 20)
                      .toList());
            }),
            const SectionTitle(title: 'PRODUCTS'),
            Obx(() {
              return ProductCarousel(
                products:
                    itemController.reslist.value.where((product) => product.tbl_id! <= 15).toList(),
                scrldirection: "VER",
              );
            })
          ],
        ),
      ),
    );
  }
}