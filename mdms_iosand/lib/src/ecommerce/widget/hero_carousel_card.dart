import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/ecommerce/widget/widget.dart';
import '../models/ecomm_model.dart';
import '../screen/catelog_screen.dart';

class HeroCarouselCard extends StatelessWidget {
  final CategoryModel? category;
  final ItemModel? product;

  const HeroCarouselCard({
    super.key,
    this.category,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (product == null) {
          Get.to(() => CatelogScreen(category: category!));
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 20),
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                product == null
                    ? ImageUrlWidget(
                        imgurl: category!.catimage.toString(),
                        imgwid: 1000.0,
                        imght: 300.0,
                      )
                    : ImageByteWidget(
                        b64: product == null
                            ? category!.catimage.toString()
                            : product!.item_image.toString(),
                        imgwid: 1000.0,
                        imght: 300.0,
                      ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      product == null ? category!.catnm : '',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
