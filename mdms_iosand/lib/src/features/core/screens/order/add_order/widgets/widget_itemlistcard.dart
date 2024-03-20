// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/ecommerce/widget/imagebyte_widget.dart';
import 'package:mdms_iosand/src/ecommerce/widget/imageurl_widget.dart';
import 'package:mdms_iosand/src/features/core/screens/order/add_order/model_item.dart';
import '../../../../../../constants/constants.dart';
import '../screen_product.dart';

class ItemListCard extends StatelessWidget {
  final ItemModel product;
  final double widthFactor;
  final double leftPosition;
  final bool isWishlist;

  const ItemListCard({
    super.key,
    required this.product,
    this.widthFactor = 2.5,
    this.leftPosition = 5,
    this.isWishlist = false,
  });

  @override
  Widget build(BuildContext context) {
    String imgurl = '';
    /*if (product.show_image == true) {
      _imgurl = "http://" +
          appData.log_ip! +
          "/image/item/" +
          product.tbl_id.toString().trim() +
          ".jpg";
    }*/
    // This is for imagebyte
    String itmimgbyte =
        product.item_image.toString().toLowerCase().trim() == 'na'
            ? ''
            : product.item_image.toString().trim();

    double available = (product.stock_qty! - product.unbilled_qty!);
    double alloc_avail = (product.allocated_qty! - product.allocated_pend_qty!);
    double stkavailable = available;
    String curordqty =
        product.ord_qty! > 0 ? 'Ordered ' + product.ord_qty!.toString() : '';

    if (alloc_avail > 0 && alloc_avail < available) {
      stkavailable = alloc_avail;
    }

    return Card(
      color: Get.isDarkMode ? tCardDarkColor : tCardLightColor,
      elevation: 4,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            product.item_nm.toString(),
            softWrap: true,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600, color: tAccentColor),
          ),
        ),
        const Divider(
          color: tAccentColor,
          thickness: 0.5,
        ),
        ExpansionTile(
          leading: itmimgbyte.isNotEmpty
              ? ImageByteWidget(b64: itmimgbyte)
              : imgurl.isNotEmpty
                  ? ImageUrlWidget(imgurl: imgurl)
                  : null,
          //leading: ImageByteWidget(b64: product.item_image.toString().trim()),

          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 10,
                child: product.ord_qty! > 0
                    ? Text(
                        curordqty,
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold, color: tCardDarkColor),
                        textAlign: TextAlign.start,
                      )
                    : Text(
                        product.mrp_ref.toString() +
                            ' [Stock ' +
                            stkavailable.toString() +
                            '] ',
                        softWrap: true,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
              ),
              IconButton(
                  icon: Icon(
                      product.ord_qty! == 0 ? Icons.add_circle : Icons.edit),
                  iconSize: 24.0,
                  onPressed: () {
                    Get.to(() => ItemScreen(
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
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Flexible(
                        flex: 4,
                        child: Text(
                          'Stock ${product.stock_qty.toString()}',
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        child: Text(
                          'UnBilled ${product.unbilled_qty.toString()}',
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
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
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Flexible(
                        flex: 4,
                        child: Text(
                          'Allocated ${product.allocated_qty.toString()}',
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        child: Text(
                          'UnBilled ${product.allocated_pend_qty.toString()}',
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        child: Text(
                          alloc_avail.toString(),
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
