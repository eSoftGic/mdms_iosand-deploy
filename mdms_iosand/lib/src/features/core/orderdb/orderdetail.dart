// ignore_for_file: invalid_use_of_protected_member, prefer_interpolation_to_compose_strings, prefer_is_empty, non_constant_identifier_names, prefer_const_constructors, sized_box_for_whitespace, no_leading_underscores_for_local_identifiers, unnecessary_brace_in_string_interps, avoid_print, unused_local_variable

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/singletons/AppData.dart';
import 'package:mdms_iosand/singletons/appsecure.dart';
import 'package:mdms_iosand/src/common_widgets/appbar/custom_appbar.dart';
import 'package:mdms_iosand/src/constants/constants.dart';
import 'package:mdms_iosand/src/features/core/neworder/controller/controller_order.dart';

import 'package:mdms_iosand/src/features/core/neworder/controller/controller_orderedit.dart';
import 'package:mdms_iosand/src/features/core/neworder/controller/controller_orderitem.dart';
import 'package:mdms_iosand/src/features/core/neworder/controller/model_order.dart';
import 'package:mdms_iosand/src/features/core/screens/order/edit_order/screen_order_edithome.dart';

import 'package:mdms_iosand/src/features/core/screens/track/controller_track.dart';
import 'package:mdms_iosand/src/features/core/screens/track/screen_track.dart';
import 'package:path_provider/path_provider.dart';


class OrderDetailView extends StatelessWidget {
  final int ordrefno;
  const OrderDetailView({super.key, required this.ordrefno});

  @override
  Widget build(BuildContext context) {
    final ordcontroller = Get.put(OrderController());
    final ordeditcontroller = Get.put(OrderEditController());
    final orditmcontroller = Get.put(OrderItemController());

    ordcontroller.setSingleOrderDetail(ordrefno);
    ordeditcontroller.setOrderRecord();

    ordeditcontroller.acid(ordcontroller.currentOrder[0].ac_id);
    ordeditcontroller.ordrefno(ordcontroller.currentOrder[0].ref_no);
    ordeditcontroller.bukcmpstr(ordcontroller.currentOrder[0].company_sel);
    orditmcontroller.setTrantype('ORD');
    if (ordrefno > 0) {
      orditmcontroller.setOrdChoice('EDIT');
    } else {
      orditmcontroller.setOrdChoice('ADD');
    }

    orditmcontroller.setTrantype('ORD');
    orditmcontroller.setImgcnt(0);

    orditmcontroller.refreshListApi();

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
              child: buildOrderAction(
                  context, ordcontroller.currentOrder[0], ordeditcontroller)),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height - 100,
              width: double.infinity,
              padding: const EdgeInsets.all(5.0),
              child: ListView(children: [
                buildOrderInfo(context, ordcontroller.currentOrder[0]),
                buildOrderItems(
                    context, ordcontroller.currentOrder[0], orditmcontroller),
                buildOrderStatus(context, ordcontroller.currentOrder[0]),
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
            style: Theme.of(context).textTheme.bodyLarge,
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
                          'Order No ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          corder.tran_desc.toString() +
                              '- ' +
                              corder.ref_no.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontSize: 18),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 3,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order Date ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          corder.tran_dt.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontSize: 18),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 3,
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
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 3,
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
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ]),
            )
          ]),
    );
  }

  Padding buildOrderItems(
    BuildContext context,
    OrderModel corder,
    OrderItemController orditmcontroller,
  ) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: Obx(
          () => ListView.builder(
              shrinkWrap: true,
              itemCount: orditmcontroller.lislen.value,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: ListTile(
                      dense: false,
                      title: Text(orditmcontroller.orditmlist[index].item_nm!,
                          softWrap: true,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontSize: 16)),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Qty ${orditmcontroller.orditmlist[index].ord_qty}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(fontSize: 18)),
                          Text(
                              'Rate ${orditmcontroller.orditmlist[index].rate!.toStringAsFixed(2)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(fontSize: 18)),
                        ],
                      )),
                );
              }),
        ));
  }

  Padding buildOrderStatus(BuildContext context, OrderModel corder) {
    bool billed;
    bool hasordpdf;
    String bilurl = "";
    String ordurl = "";
    var _colorapproved = Colors.green;

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

    var dio = Dio();

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
                      hasordpdf
                          ? IconButton(
                              icon: Icon(
                                Icons.file_download,
                                size: 24.0,
                                color: Colors.green,
                              ),
                              onPressed: () async {})
                          : Text('')
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
                        'Invoice ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        corder.billdetails!,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      billed
                          ? IconButton(
                              icon: Icon(
                                Icons.file_download,
                                size: 24.0,
                                color: Colors.green,
                              ),
                              onPressed: () async {
                                var tempDir = await getTemporaryDirectory();
                                String fullPath = tempDir.path +
                                    "/" +
                                    corder.billpdf!.trim() +
                                    '.pdf';
                                debugPrint('full path ${fullPath}');
                                download2(dio, bilurl, fullPath);
                              },
                            )
                          : Text('')
                    ],
                  ),
                ),
              ]),
            )
          ]),
    );
  }

  Padding buildOrderAction(BuildContext context, OrderModel corder,
      OrderEditController ordeditcontroller) {
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
                TextButton(
                    onPressed: () {
                      if (corder.billpdf.toString().trim().length > 0) {
                        Get.snackbar('Billed', 'Cannot Edit Order');
                      } else {
                        if (appSecure.editorder!) {
                          if (appData.log_type != "DMAN") {
                            ordeditcontroller.setOrderRecord();
                            Get.to(() => const EditOrderScreen());
                          }
                        } else {
                          Get.snackbar('Not Authorised', 'Edit Order');
                        }
                      }
                    },
                    child: const Text('EDIT')),
                TextButton(onPressed: () {}, child: const Text('DELETE')),
                TextButton(
                    onPressed: () {
                      final trackcontroller = Get.put(TrackController());
                      trackcontroller.ordidstr.value =
                          corder.ref_no.toString().trim();
                      trackcontroller.trantype.value = 'ORD';
                      trackcontroller.trackApi();
                      Get.to(() => const TrackScreen());
                    },
                    child: const Text('TRACK')),
              ],
            )));
  }

  Future download2(Dio dio, String url, String savePath) async {
    try {
      var response = await dio.get(
        url, onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }
}
