import 'package:flutter/material.dart';
import '../../../../../../ecommerce/widget/imagebyte_widget.dart';
import '../model_item.dart';

class ItemCarasoulCard extends StatelessWidget {
  final ItemModel? product;
  const ItemCarasoulCard({
    super.key,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 20),
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(50.0)),
          child: Stack(
            children: <Widget>[
              ImageByteWidget(
                b64: product!.item_image.toString(),
                imgwid: 1000.0,
                imght: 300.0,
              ),
              /*
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    product!.item_nm.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              )
              */
            ],
          )),
    );
  }
}