import 'package:flutter/material.dart';
import 'package:mdms_iosand/src/ecommerce/widget/widget.dart';
import '../models/ecomm_model.dart';

class ProductCarousel extends StatelessWidget {
  final List<ItemModel> products;
  final String scrldirection;
  const ProductCarousel({
    super.key,
    required this.products,
    this.scrldirection = "HOR",
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          scrollDirection: scrldirection == "HOR" ? Axis.horizontal : Axis.vertical,
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: ProductCard(product: products[index]),
            );
          }),
    );
  }
}