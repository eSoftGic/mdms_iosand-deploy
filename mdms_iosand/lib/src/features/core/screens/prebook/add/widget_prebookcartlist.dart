import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/common_widgets/image/imagebyte_widget.dart';
import 'package:mdms_iosand/src/features/core/screens/prebook/add/controller_prebookcart.dart';



class PreBookCartScreen extends StatelessWidget {
  const PreBookCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(PreBookCartController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 350,
                      child: ListView.builder(
                          itemCount: cartController.lislen.value,
                          itemBuilder: (context, index) {
                            return ListTile(
                                leading: ImageByteWidget(
                                  b64: cartController.cartlist[index].item_image.toString().trim(),
                                  imgwid: 50,
                                  imght: 50,
                                ),
                                title: Text(cartController.cartlist[index].item_nm!,
                                    softWrap: true, style: Theme.of(context).textTheme.bodyMedium),
                                subtitle: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            'Qty ${cartController.cartlist[index].ord_qty}',
                                            style: Theme.of(context).textTheme.headlineSmall),
                                        Text(
                                            'Rs. ${cartController.cartlist[index].itemnet!
                                                    .toStringAsFixed(2)}',
                                            style: Theme.of(context).textTheme.headlineSmall),
                                        IconButton(
                                            icon: const Icon(
                                              Icons.delete_forever,
                                              size: 24,
                                            ),
                                            onPressed: () {
                                              cartController.removefromCartlist(
                                                  cartController.cartlist[index]);
                                            })
                                      ],
                                    ),
                                  ],
                                ));
                            //ItemListCard(product: cartController.cartlist[index]);
                          }),
                    )
                  ],
                ),
              );
            }),
          ]),
    );
  }
}