// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/common_widgets/appbar/appbar.dart';
import 'package:mdms_iosand/src/common_widgets/custom_shapes/container/primary_header_container.dart';
import 'package:mdms_iosand/src/common_widgets/product_cards/product_card_vertical.dart';
import 'package:mdms_iosand/src/common_widgets/searchbar/tsearchbar.dart';
import 'package:mdms_iosand/src/constants/colors.dart';
import 'package:mdms_iosand/src/features/core/screens/order/add_order/widgets/controller_orderbasic.dart';
import 'package:mdms_iosand/src/features/core/screens/order/add_order/widgets/controller_orderitem.dart';
import 'package:mdms_iosand/src/features/core/screens/order/edit_order/controller_orderedit.dart';

class OrderitemListScreen extends StatelessWidget {
  const OrderitemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OrderBasicController controller = Get.put(OrderBasicController());
    OrderItemController itmcontroller = Get.put(OrderItemController());
    OrderEditController editcontroller = Get.put(OrderEditController());

    itmcontroller.setTrantype('ORD');
    itmcontroller.setOrdChoice(controller.ordrefno.value == 0 ? 'ADD' : 'EDIT');
    itmcontroller.setShwimg(true); //itmcontroller.shwimg.value);

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      TPrimaryHeaderContainer(
          height: 200,
          child: Column(
            children: [
              const TAppBar(
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ORDER'),
                      SizedBox(
                        height: 8,
                      ),
                      Text('Product List',
                          style: TextStyle(fontSize: 16, color: tPrimaryColor)),
                    ]),
                showBackArrow: false,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
                child: const TSearchContainer(
                  text: 'Search Products',
                  showBackground: false,
                  showBorder: true,
                ),
              ),
            ],
          )),
      Padding(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Column(children: [
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: itmcontroller.reslist.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 24,
              mainAxisExtent: 300, // play with this value
            ),
            itemBuilder: (_, index) => ProductCardVertical(
              product: itmcontroller.reslist[index],
            ),
          )
        ]),
      ),
    ])));
  }
}
