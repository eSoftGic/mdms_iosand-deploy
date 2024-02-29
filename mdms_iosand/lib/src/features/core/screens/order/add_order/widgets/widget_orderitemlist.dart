// ignore_for_file: must_be_immutable, unused_local_variable, invalid_use_of_protected_member, unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/core/screens/order/add_order/widgets/widget_itemlistcard.dart';
import '../../../../network/exceptions/general_exception_widget.dart';
import '../../../../network/exceptions/internet_exception_widget.dart';
import '../../../../network/status.dart';
import '../../edit_order/controller_orderedit.dart';
import 'controller_orderitem.dart';

class OrderItemList extends StatelessWidget {
  final String ordch;
  OrderItemList({super.key, required this.ordch});

  final orditmcontroller = Get.put(OrderItemController());
  final editcontroller = Get.put(OrderEditController());
  bool showsrc = true;
  bool shwimg = false;

  @override
  Widget build(BuildContext context) {
    orditmcontroller.setTrantype('ORD');

    orditmcontroller.setOrdChoice(ordch);
    orditmcontroller.setShwimg(shwimg);

    return SizedBox(
      height: MediaQuery.of(context).size.height - 400,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          if (showsrc) _searchBar(context),
          Obx(() {
            switch (orditmcontroller.RxRequestStatus.value) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.ERROR:
                if (orditmcontroller.error.value == 'No Internet') {
                  return InternetExceptionWidget(
                      onPress: () => orditmcontroller.refreshListApi());
                } else {
                  return GeneralExceptionWidget(
                      onPress: () => orditmcontroller.refreshListApi());
                }
              case Status.COMPLETED:
                return _showList();
            }
          }),
        ],
      ),
    );
  }

  Widget _searchBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            height: 40.0,
            margin: const EdgeInsets.fromLTRB(5, 0, 2, 5),
            child: TextFormField(
              controller: orditmcontroller.searchtxt,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                orditmcontroller.applyfilters(value.toLowerCase());
              },
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Obx(
          () => Text(
            orditmcontroller.lislen.value.toString(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
            onPressed: () {
              orditmcontroller.setShwimg(!orditmcontroller.shwimg.value);
              debugPrint(orditmcontroller.shwimg.value.toString());
            },
            icon: Icon(
              orditmcontroller.shwimg.value == true
                  ? Icons.image_outlined
                  : Icons.image_not_supported_outlined,
              size: 24,
            )),
        IconButton(
            onPressed: () {
              orditmcontroller.refreshListApi();
            },
            icon: const Icon(
              Icons.refresh,
              size: 24,
            )),

        /*Center(child: _filter()),*/
      ],
    );
  }

  Widget _filter() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 30.0,
        width: 30.0,
        child: GestureDetector(
          onTap: () {
            //Get.to(() => OrderFilter());
          },
          child: Stack(
            children: <Widget>[
              IconButton(
                  icon: const Icon(
                    Icons.filter_list,
                    size: 24,
                  ),
                  onPressed: () {}),
              Positioned(
                child: Stack(
                  children: <Widget>[
                    Icon(Icons.brightness_1,
                        size: 20.0, color: Colors.deepOrangeAccent.shade100),
                    Positioned(
                      top: 2.0,
                      right: 5.5,
                      child: Center(
                        child: Text(
                          "1",
                          style: TextStyle(
                              color: Colors.green.shade900,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showList() {
    TextEditingController tqty;
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: orditmcontroller.reslist.value.length,
        itemBuilder: (context, index) {
          return ItemListCard(
            product: orditmcontroller.reslist[index],
            widthFactor: 0.01,
            leftPosition: 50,
          );
        },
      ),
    );
  }
}
