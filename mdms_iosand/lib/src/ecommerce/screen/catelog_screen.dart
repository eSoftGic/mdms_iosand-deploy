import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/item_controller.dart';
import '../models/ecomm_model.dart';
import '../widget/widget.dart';

class CatelogScreen extends StatelessWidget {
  final CategoryModel category;
  const CatelogScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final itemController = Get.put(ItemController());
    itemController.ItemListApi();

    final List<ItemModel> categoryProducts =
        itemController.reslist.where((product) => product.item_cat_nm == category.catnm).toList();
    return Scaffold(
        appBar: CustomAppBar(title: category.catnm),
        bottomNavigationBar: const CustomNavBar(),
        body: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.15,
            ),
            itemCount: categoryProducts.length,
            itemBuilder: (BuildContext context, int index) {
              return Center(
                  child: ProductCard(
                product: categoryProducts[index],
                widthFactor: 2.2,
              ));
            }));
  }
}