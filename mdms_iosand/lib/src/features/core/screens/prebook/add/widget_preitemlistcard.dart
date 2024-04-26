import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/core/neworder/model/model_item.dart';

import 'package:mdms_iosand/src/features/core/screens/prebook/add/screen_preproduct.dart';

import '../../../../../constants/constants.dart';

class PreItemListCard extends StatelessWidget {
  final ItemModel product;
  final double widthFactor;
  final double leftPosition;
  final bool isWishlist;

  const PreItemListCard({
    super.key,
    required this.product,
    this.widthFactor = 2.2,
    this.leftPosition = 5,
    this.isWishlist = false,
  });

  @override
  Widget build(BuildContext context) {
    double available = (product.stock_qty! - product.unbilled_qty!);
    double allocAvail = (product.allocated_qty! - product.allocated_pend_qty!);
    double stkavailable = available;
    String curordqty = product.ord_qty! > 0 ? ' Ordered ${product.ord_qty!}' : '';

    if (allocAvail > 0 && allocAvail < available) {
      stkavailable = allocAvail;
    }

    return Card(
      elevation: 8,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            product.item_nm.toString(),
            softWrap: true,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(
          color: tPrimaryColor,
          thickness: 0.5,
        ),
        ExpansionTile(
          //leading: ImageByteWidget(b64: product.item_image.toString().trim()),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 10,
                child: Text(
                  '${product.mrp_ref} [Stock $stkavailable] $curordqty',
                  softWrap: true,
                  style:
                      Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              IconButton(
                  icon: const Icon(Icons.add_circle),
                  iconSize: 24.0,
                  onPressed: () {
                    Get.to(() => PreItemScreen(
                          product: product,
                        ));
                  }),
            ],
          ),
          initiallyExpanded: false,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
                  Flexible(
                    flex: 8,
                    child: Text(
                      'Stock-UnBilled ${product.stock_qty} - ${product.unbilled_qty}',
                      softWrap: true,
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: Text(
                      available.toString(),
                      softWrap: true,
                      textAlign: TextAlign.end,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 10,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
                  Flexible(
                    flex: 8,
                    child: Text(
                      'Allocated-UnBilled ${product.allocated_qty} - ${product.allocated_pend_qty}',
                      softWrap: true,
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: Text(
                      allocAvail.toString(),
                      textAlign: TextAlign.end,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Flexible(
                      flex: 4,
                      child: Text(
                        product.company_nm.toString(),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      child: Text(
                        product.item_brand_nm.toString(),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      child: Text(
                        product.item_cat_nm.toString(),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}