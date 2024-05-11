// ignore_for_file: invalid_use_of_protected_member, prefer_interpolation_to_compose_strings, prefer_const_constructors, non_constant_identifier_names, unused_local_variable

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:liquid_pull_refresh/liquid_pull_refresh.dart';
import 'package:mdms_iosand/singletons/AppData.dart';
import 'package:mdms_iosand/src/constants/colors.dart';
import 'package:mdms_iosand/src/features/core/network/exceptions/general_exception_widget.dart';
import 'package:mdms_iosand/src/features/core/network/exceptions/internet_exception_widget.dart';
import 'package:mdms_iosand/src/features/core/network/status.dart';
import 'package:mdms_iosand/src/features/core/neworder/controller/controller_order.dart';
import 'package:mdms_iosand/src/features/core/neworder/screen/ordernavigation.dart';
import 'package:mdms_iosand/src/features/core/screens/dashboard/dashboard.dart';
import 'package:mdms_iosand/src/features/core/screens/track/controller_track.dart';
import 'package:mdms_iosand/src/features/core/screens/track/screen_track.dart';
import 'package:mdms_iosand/src/utils/pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as pth;

class OrderHomeView extends StatefulWidget {
  const OrderHomeView({super.key});

  @override
  State<OrderHomeView> createState() => _OrderHomeViewState();
}

class _OrderHomeViewState extends State<OrderHomeView> {
  final ordcontroller = Get.put(OrderController());
  String ordrs = "";
  Color colorapproved = Colors.blue;
  final Dio dio = Dio();
  String progress = "0";

  Future<void> _handleRefresh() async {
    ordcontroller.setPartyOrderList(ordcontroller.ordforacid);
    return await Future.delayed(const Duration(seconds: 2));
  }

  @override
  void initState() {
    super.initState();
    ordcontroller.setPartyOrderList(ordcontroller.ordforacid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                const Size.fromHeight(55.0), // here the desired height
            child: AppBar(
              automaticallyImplyLeading: false,
              title: const Text("ORDER"),
              backgroundColor: tPrimaryColor.withOpacity(0.3),
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        appData.ordqottype = "ORD";
                        appData.prtid = 0;
                        appData.prtnm = '';
                        appData.ordrefno = 0;
                        appData.ordmaxlimit = 0.0;
                        appData.ordlimitvalid = true;
                      });
                      ordcontroller.setOrdrefno(0);
                      Get.to(() => const OrderNavigationScreen());
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 24,
                    )),
                IconButton(
                    onPressed: () {
                      Get.to(const Dashboard());
                    },
                    icon: const Icon(
                      Icons.home,
                      size: 24,
                    )),
              ],
            )),
        body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height - 50,
              width: double.infinity,
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: () {
                            gotoselected('all');
                          },
                          child: Text(
                            'ALL',
                            style: Theme.of(context).textTheme.labelSmall,
                          )),
                      TextButton(
                          onPressed: () {
                            gotoselected('apprvpend');
                          },
                          child: Text(
                            'PENDING',
                            style: Theme.of(context).textTheme.labelSmall,
                          )),
                      TextButton(
                          onPressed: () {
                            gotoselected('billpend');
                          },
                          child: Text(
                            'APPROVED',
                            style: Theme.of(context).textTheme.labelSmall,
                          )),
                      TextButton(
                          onPressed: () {
                            gotoselected('billed');
                          },
                          child: Text(
                            'BILLED',
                            style: Theme.of(context).textTheme.labelSmall,
                          )),
                      TextButton(
                          onPressed: () {
                            gotoselected('apprvreject');
                          },
                          child: Text(
                            'REJECTED',
                            style: Theme.of(context).textTheme.labelSmall,
                          )),
                      /*TextButton(
                          onPressed: () {
                            gotoselected('noorder');
                          },
                          child: Text(
                            'NO-ORDER',
                            style: Theme.of(context).textTheme.labelSmall,
                          )),
                          */
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _searchBar(),
                  ),
                  const Divider(
                    height: 5,
                    color: tPrimaryColor,
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height - 200,
                      width: double.infinity,
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: <Widget>[
                          Obx(() {
                            switch (ordcontroller.RxRequestStatus.value) {
                              case Status.LOADING:
                                return const Center(
                                    child: CircularProgressIndicator());
                              case Status.ERROR:
                                if (ordcontroller.error.value ==
                                    'No Internet') {
                                  return InternetExceptionWidget(
                                      onPress: () =>
                                          ordcontroller.refreshListApi());
                                } else {
                                  return GeneralExceptionWidget(
                                      onPress: () =>
                                          ordcontroller.refreshListApi());
                                }
                              case Status.COMPLETED:
                                return _showList(context);
                            }
                          }),
                        ],
                      )),
                ],
              )),
        ));
  }

  Widget _searchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            height: 35.0,
            margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: TextFormField(
              controller: ordcontroller.searchtxt,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                ordcontroller.applyfilters(value);
              },
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Obx(
          () => Text(
            ordcontroller.lislen.toString(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
            onPressed: () {
              ordcontroller.searchtxt.text = "";
              ordcontroller.refreshListApi();
            },
            icon: const Icon(
              Icons.refresh,
              size: 24,
            )),
      ],
    );
  }

  Widget _showList(BuildContext context) {
    return LiquidPullRefresh(
      onRefresh: _handleRefresh,
      color: tAccentColor.withOpacity(0.3),
      height: 200,
      backgroundColor: tCardLightColor,
      animSpeedFactor: 2,
      showChildOpacityTransition: true,
      child: Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: ordcontroller.reslist.value.length,
          itemBuilder: (context, index) {
            return _listItem(index);
          },
        ),
      ),
    );
  }

  Widget _listItem(index) {
    String ordstatus = '';
    if (ordcontroller.reslist[index].billed == 'Y') {
      ordstatus = 'Billed';
      colorapproved = Colors.green;
    }
    if (ordcontroller.reslist[index].approvalstatus!
        .toUpperCase()
        .contains('REJECTED')) {
      ordstatus = 'Rejected';
      colorapproved = Colors.purple;
    }
    if (ordcontroller.reslist[index].approvalstatus!
        .toUpperCase()
        .contains('PENDING')) {
      ordstatus = 'Approval Pending';
      colorapproved = Colors.red;
    }
    if (ordcontroller.reslist[index].approvalstatus!
        .toUpperCase()
        .contains('APPROVED')) {
      ordstatus = 'Approved';
      colorapproved = Colors.green;
    }

    return Card(
      color: Get.isDarkMode ? tCardDarkColor : tCardLightColor,
      child: ListTile(
        trailing: IconButton(
            onPressed: () {
              setState(() {
                appData.prtid =
                    int.parse(ordcontroller.reslist[index].ac_id.toString());
                appData.prtnm = ordcontroller.reslist[index].ac_nm!.trim();
                appData.ordrefno = ordcontroller.reslist[index].ref_no;
                appData.bukid = ordcontroller.reslist[index].tran_type_id ?? 0;
                appData.bukcmpstr =
                    ordcontroller.reslist[index].company_sel ?? "";
                appData.buknm = ordcontroller.reslist[index].tran_desc;
                appData.billdetails = ordcontroller.reslist[index].billdetails;
                appData.chainid = ordcontroller.reslist[index].chainid ?? 0;
                appData.chainnm =
                    ordcontroller.reslist[index].chainareanm ?? "";
                appData.ordmaxlimit = 0.0;
                appData.ordlimitvalid = true;
                appData.saletype = ordcontroller.reslist[index].saletype;
                appData.ordbilled = ordcontroller.reslist[index].billed;
                appData.approvalstatus =
                    ordcontroller.reslist[index].approvalstatus ?? '';
                appData.ordqottype = 'ORD';
              });
              if (ordcontroller.reslist[index].ref_no! > 0) {
                ordcontroller.setOrdrefno(ordcontroller.reslist[index].ref_no!);
                Get.to(() => OrderNavigationScreen());
              }
            },
            icon: Icon(
              LineAwesomeIcons.angle_double_right,
              size: 28,
              color: tAccentColor,
            )),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
          child: Text(
            ordcontroller.reslist[index].ac_nm.toString(),
            style: Theme.of(context).textTheme.bodyMedium,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 4,
                  child: Text(ordcontroller.reslist[index].tran_dt.toString(),
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                Flexible(
                  flex: 5,
                  child: Text(
                      ordcontroller.reslist[index].ref_no.toString() +
                          '-' +
                          ordcontroller.reslist[index].tran_desc
                              .toString()
                              .trim(),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                Flexible(
                  flex: 3,
                  child: Text(
                    ordcontroller.reslist[index].net_amt.toString(),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Approval :'),
                  Text(
                    ordcontroller.reslist[index].approvalstatus.toString(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ordcontroller.reslist[index].approvalstatus
                                    .toString()
                                    .toLowerCase()
                                    .contains('approved') ==
                                true
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            OrderStatus(context, ordcontroller, index),
          ]),
        ),
      ),
    );
  }

  void gotoselected(String opt) async {
    ordcontroller.setOrdBillList(opt);
  }

  Widget OrderStatus(
      BuildContext context, OrderController ordcontroller, int index) {
    TrackController trackcontroller = Get.put(TrackController());
    bool hasordpdf =
        ordcontroller.reslist[index].ordpdf!.trim().isNotEmpty ? true : false;
    String ordurl = hasordpdf
        ? appData.pdfbaseurl! + ordcontroller.reslist[0].ordpdf!.trim() + '.pdf'
        : '';

    bool hasbilpdf =
        ordcontroller.reslist[index].billpdf!.trim().isNotEmpty ? true : false;
    String bilurl = hasbilpdf
        ? appData.pdfbaseurl! +
            ordcontroller.reslist[index].billpdf!.trim() +
            '.pdf'
        : "";

    return ExpansionTile(
        iconColor: tPrimaryColor,
        childrenPadding: EdgeInsets.symmetric(horizontal: 4),
        initiallyExpanded: false,
        title: Text(
          'Options..',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: tPrimaryColor),
        ),
        children: [
          Card(
              color: tCardLightColor,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order ${ordcontroller.reslist[index].ordpdf.toString().trim()}',
                              style: Theme.of(context).textTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                            IconButton(
                                onPressed: hasordpdf
                                    ? () async {
                                        download(
                                            ordurl,
                                            ordcontroller.reslist[index].ordpdf!
                                                    .trim() +
                                                '.pdf',
                                            'Order-${ordcontroller.reslist[index].ref_no.toString()}');
                                      }
                                    : null,
                                icon: const Icon(
                                  Icons.download,
                                  color: tPrimaryColor,
                                )),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Track Order '),
                            IconButton(
                                onPressed: () {
                                  trackcontroller.ordidstr.value = ordcontroller
                                      .reslist[index].ref_no
                                      .toString()
                                      .trim();
                                  trackcontroller.trantype.value = 'ORD';
                                  trackcontroller.trackApi();
                                  Get.to(() => const TrackScreen());
                                },
                                icon: const Icon(
                                  Icons.timeline,
                                  size: 18,
                                  color: tAccentColor,
                                )),
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Bill Details'),
                          Text(
                            ordcontroller.reslist[0].billdetails.toString(),
                            style: const TextStyle(
                                fontSize: 16, color: tPrimaryColor),
                          ),
                          IconButton(
                              onPressed: hasbilpdf
                                  ? () async {
                                      download(
                                          bilurl,
                                          ordcontroller.reslist[index].billpdf!
                                                  .trim() +
                                              '.pdf',
                                          'Invoice - ${ordcontroller.reslist[index].billdetails!}');
                                    }
                                  : null,
                              icon: const Icon(
                                Icons.download,
                                color: tPrimaryColor,
                              )),
                        ],
                      ),
                    ]),
              ))
        ]);
  }

  Future download(String fileUrl, String fileName, String ptitle) async {
    getPermission();
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final permissionStatus = await Permission.storage.isGranted;
    if (permissionStatus == true) {
      final savePath = pth.join(dir, fileName);
      await startDownload(savePath, fileUrl);
      Get.to(() => PdfView(
            path: savePath,
            pdftitle: ptitle,
          ));
    } else {
      Get.snackbar('Permission', 'denied for download to ' + dir.toString());
    }
  }

  void getPermission() async {
    //await Permission..manageExternalStorage.request();
    await Permission.storage.request();
  }

  Future startDownload(String savePath, String urlPath) async {
    Dio dio = Dio();
    Map<String, dynamic> result = {
      "isSuccess": false,
      "filePath": null,
      "error": null
    };
    try {
      var response = await dio.download(
        urlPath,
        savePath,
        onReceiveProgress: _onReceiveProgress,
      );
      result['isSuccess'] = response.statusCode == 200;
      result['filePath'] = savePath;
    } catch (e) {
      result['error'] = e.toString();
    } finally {
      //_showNotification(result);
    }
  }

  _onReceiveProgress(int receive, int total) {
    if (total != -1) {
      //setState(() {
      //  progress = (receive / total * 100).toStringAsFixed(0) + '%';
      //});
    }
  }
}
