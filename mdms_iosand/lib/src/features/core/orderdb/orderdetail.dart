// ignore_for_file: invalid_use_of_protected_member, prefer_interpolation_to_compose_strings, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/singletons/AppData.dart';
import 'package:mdms_iosand/src/constants/constants.dart';
import 'package:mdms_iosand/src/ecommerce/widget/custom_appbar.dart';
import 'package:mdms_iosand/src/features/core/screens/order/model_order.dart';
import '../screens/order/controller_order.dart';

class OrderDetailView extends StatelessWidget {
  final int ordrefno;
  const OrderDetailView({super.key, required this.ordrefno});

  @override
  Widget build(BuildContext context) {
    debugPrint(ordrefno.toString());

    final ordcontroller = Get.put(OrderController());

    ordcontroller.setSingleOrderDetail(ordrefno);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Order # ' + ordcontroller.currentOrder[0].ref_no.toString(),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: tAccentColor,
              width: 1,
            ), //Border.all
            borderRadius: BorderRadius.circular(10),
          ), //BoxDecoration
          child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: buildOrderAction(context, ordcontroller.currentOrder[0])),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height - 100,
              width: double.infinity,
              padding: const EdgeInsets.all(5.0),
              child: ListView(children: [
                buildOrderInfo(context, ordcontroller.currentOrder[0]),
                buildOrderItems(context, ordcontroller.currentOrder[0]),
                buildOrderStatus(context, ordcontroller.currentOrder[0]),
                //buildOrderAction(context, ordcontroller.currentOrder[0]),
              ]))),
    );
  }

  Padding buildOrderInfo(BuildContext context, OrderModel corder) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ExpansionTile(
          initiallyExpanded: true,
          title: Text(
            'Order Details',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          children: [
            Card(
              elevation: 2.0,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order No / Date ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          corder.tran_desc.toString() +
                              '- ' +
                              corder.ref_no.toString(),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Party ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        corder.ac_nm!,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Amount ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        corder.net_amt!.toStringAsFixed(2),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
              ]),
            )
          ]),
    );
  }

  Padding buildOrderItems(BuildContext context, OrderModel corder) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ExpansionTile(
          initiallyExpanded: false,
          title: Text(
            'Item Details',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          children: [
            Card(
              elevation: 2.0,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order No / Date ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          corder.tran_desc.toString() +
                              '- ' +
                              corder.ref_no.toString(),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Party ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        corder.ac_nm!,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Amount ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        corder.net_amt!.toStringAsFixed(2),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
              ]),
            )
          ]),
    );
  }

  Padding buildOrderStatus(BuildContext context, OrderModel corder) {
    bool billed;
    bool hasordpdf;
    String bilurl = "";
    String ordurl = "";
    var _colorapproved = Colors.green;
    var _localdirpath = "";
    String progress = "0";

    billed = corder.billed == 'Y' ? true : false;
    hasordpdf = corder.ordpdf!.trim().length > 0 ? true : false;
    if (corder.billpdf!.trim().length > 0) {
      bilurl = appData.pdfbaseurl! + corder.billpdf!.trim() + '.pdf';
    }

    if (corder.ordpdf!.trim().length > 0) {
      ordurl = appData.pdfbaseurl! + corder.ordpdf!.trim() + '.pdf';
    }

    _colorapproved = Colors.green;
    if (corder.approvalstatus!.toUpperCase().contains('REJECTED')) {
      _colorapproved = Colors.red;
      _colorapproved = Colors.red;
    }
    if (corder.approvalstatus!.toUpperCase().contains('PENDING')) {
      _colorapproved = Colors.orange;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ExpansionTile(
          initiallyExpanded: false,
          title: Text(
            'Status',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          children: [
            Card(
              elevation: 2.0,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Status ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(corder.approvalstatus!.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(color: _colorapproved)),
                      ]),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order PDF ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        ordurl,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.picture_as_pdf,
                            size: 24.0,
                            color: Colors.green,
                          ),
                          onPressed: () async {
                            (billed && bilurl.isNotEmpty) ? '' : '';
                            /*download(bilurl, corder.billpdf!.trim() + '.pdf',
                          'Invoice -' + corder.billdetails!);*/
                          })
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bill PDF ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        corder.billdetails!,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.picture_as_pdf,
                            size: 24.0,
                            color: Colors.green,
                          ),
                          onPressed: () async {
                            (billed && bilurl.isNotEmpty) ? '' : '';
                            /*download(bilurl, corder.billpdf!.trim() + '.pdf',
                          'Invoice -' + corder.billdetails!);*/
                          })
                    ],
                  ),
                ),
              ]),
            )
          ]),
    );
  }

  Padding buildOrderAction(BuildContext context, OrderModel corder) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
            height: 100,
            width: double.infinity,
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(onPressed: () {}, child: const Text('EDIT')),
                TextButton(onPressed: () {}, child: const Text('DELETE')),
                TextButton(onPressed: () {}, child: const Text('TRACK')),
              ],
            )));
  }
}
