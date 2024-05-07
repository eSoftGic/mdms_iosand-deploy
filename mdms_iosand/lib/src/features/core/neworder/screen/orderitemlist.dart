// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/common_widgets/appbar/appbar.dart';
import 'package:mdms_iosand/src/common_widgets/custom_shapes/container/primary_header_container.dart';
import 'package:mdms_iosand/src/common_widgets/product_cards/product_card_vertical.dart';
import 'package:mdms_iosand/src/constants/colors.dart';
import 'package:mdms_iosand/src/features/core/network/exceptions/general_exception_widget.dart';
import 'package:mdms_iosand/src/features/core/network/exceptions/internet_exception_widget.dart';
import 'package:mdms_iosand/src/features/core/network/status.dart';
import 'package:mdms_iosand/src/features/core/neworder/controller/controller_order.dart';
//import 'package:mdms_iosand/src/features/core/neworder/controller/controller_orderbasic.dart';
import 'package:mdms_iosand/src/features/core/neworder/controller/controller_orderitem.dart';

class OrderitemListScreen extends StatelessWidget {
  const OrderitemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OrderController ordcontroller = Get.put(OrderController());
    int ordno = ordcontroller.ordrefno.value;
    OrderItemController itmcontroller = Get.put(OrderItemController());

    itmcontroller.setTrantype('ORD');
    itmcontroller.setOrdChoice(ordno == 0 ? 'ADD' : 'EDIT');
    itmcontroller.setShwimg(itmcontroller.shwimg.value);

    double grdwidth = MediaQuery.of(context).size.width - 50;

    itmcontroller.refreshListApi();

    return Scaffold(
      body: Column(children: [
        TPrimaryHeaderContainer(
            height: 130,
            child: TAppBar(
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ordno > 0 ? 'EDIT ORDER' : 'ADD ORDER'),
                    SizedBox(
                      height: 8,
                    ),
                    Text('Product List',
                        style: TextStyle(fontSize: 16, color: tPrimaryColor)),
                  ]),
              showBackArrow: false,
            )),
        Obx(() {
          switch (itmcontroller.RxRequestStatus.value) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
              if (itmcontroller.error.value == 'No Internet') {
                return InternetExceptionWidget(
                    onPress: () => itmcontroller.refreshListApi());
              } else {
                return GeneralExceptionWidget(
                    onPress: () => itmcontroller.refreshListApi());
              }
            case Status.COMPLETED:
              return showgrid(context, itmcontroller, grdwidth);
          }
        }),
      ]),
    );
  }

  SingleChildScrollView showgrid(BuildContext context,
      OrderItemController itmcontroller, double grdwidth) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
            child: searchBarWidget(context, itmcontroller),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 500,
              width: grdwidth,
              child: Obx(() => GridView.builder(
                    shrinkWrap: true,
                    itemCount: itmcontroller.reslist.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 16,
                      mainAxisExtent: 288, // play with this value
                    ),
                    itemBuilder: (_, index) => ProductCardVertical(
                      product: itmcontroller.reslist[index],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  searchBarWidget(BuildContext context, OrderItemController itmcontroller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            height: 40.0,
            margin: const EdgeInsets.fromLTRB(5, 0, 2, 5),
            child: TextFormField(
              controller: itmcontroller.searchtxt,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                itmcontroller.applyfilters(value.toLowerCase());
              },
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Obx(
          () => Text(
            itmcontroller.lislen.value.toString(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Obx(
          () => IconButton(
              onPressed: () {
                itmcontroller.setShwimg(!itmcontroller.shwimg.value);
              },
              icon: Icon(
                itmcontroller.shwimg.value == true
                    ? Icons.image_outlined
                    : Icons.image_not_supported_outlined,
                size: 24,
              )),
        ),
        IconButton(
            onPressed: () {
              itmcontroller.refreshListApi();
            },
            icon: const Icon(
              Icons.refresh,
              size: 24,
            )),

        /*Center(child: _filter()),*/
      ],
    );
  }
}
