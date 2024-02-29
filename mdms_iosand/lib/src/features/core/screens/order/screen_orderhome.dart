// ignore_for_file: depend_on_referenced_packages, unused_field, prefer_final_fields, sized_box_for_whitespace, unused_element, invalid_use_of_protected_member, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_is_empty, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mdms_iosand/src/features/core/screens/order/add_order/widgets/controller_cart.dart';
import 'package:mdms_iosand/src/features/core/screens/order/add_order/widgets/controller_orderitem.dart';
import 'package:mdms_iosand/src/features/core/screens/order/model_order.dart';
import 'package:mdms_iosand/src/features/core/screens/track/screen_track.dart';

import '../../../../../singletons/AppData.dart';
import '../../../../../singletons/appsecure.dart';
import '../../../../constants/colors.dart';
import '../../../../utils/pdfview.dart';
import '../../network/exceptions/general_exception_widget.dart';
import '../../network/exceptions/internet_exception_widget.dart';
import '../../network/status.dart';
import '../dashboard/dashboard.dart';
import '../track/controller_track.dart';
import 'add_order/screen_order_addedithome.dart';
import 'controller_order.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

import 'edit_order/controller_orderedit.dart';
import 'edit_order/screen_order_edithome.dart';

class OrderHomeScreen extends StatefulWidget {
  const OrderHomeScreen({super.key});
  @override
  State<OrderHomeScreen> createState() => _OrderHomeScreenState();
}

class _OrderHomeScreenState extends State<OrderHomeScreen> {
  final ordcontroller = Get.put(OrderController());
  final editcontroller = Get.put(OrderEditController());
  final trackcontroller = Get.put(TrackController());

  bool _billed = false;
  bool _hasordpdf = false;
  String _bilurl = '';
  String _ordurl = '';
  String ordrs = "";
  var _colorapproved = Colors.green;
  var _localdirpath = "";
  final Dio dio = Dio();
  String progress = "0";
  bool showsrc = false;

  @override
  void initState() {
    super.initState();
    ordcontroller.setPartyOrderList(0);
    Get.delete<OrderCartController>();
    Get.delete<OrderItemController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55.0), // here the desired height
          child: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.to(() => const Dashboard());
                },
                icon: const Icon(
                  LineAwesomeIcons.angle_left,
                  size: 24,
                )),
            title: Text("Order",
                style: Theme.of(context).textTheme.headlineMedium),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      showsrc = !showsrc;
                    });
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 24,
                  )),
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
                    Get.to(() => const AddOrderHomeScreen());
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 24,
                  )),
              IconButton(
                  onPressed: () {
                    ordcontroller.refreshListApi();
                  },
                  icon: const Icon(
                    Icons.refresh_outlined,
                    size: 24,
                  )),
              orderpopupMenuButton()
            ],
          )),
      body: Container(
        height: MediaQuery.of(context).size.height - 5,
        width: double.infinity,
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            if (showsrc) _searchBar(),
            Obx(() {
              switch (ordcontroller.RxRequestStatus.value) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  if (ordcontroller.error.value == 'No Internet') {
                    return InternetExceptionWidget(
                        onPress: () => ordcontroller.refreshListApi());
                  } else {
                    return GeneralExceptionWidget(
                        onPress: () => ordcontroller.refreshListApi());
                  }
                case Status.COMPLETED:
                  return _showList();
              }
            }),
          ],
        ),
      ),
    );
  }

  void gotoselected(String opt) async {
    if (opt == 'billed') {
      ordcontroller.setOrdBillList('Y');
    }
    if (opt == 'billpend') {
      ordcontroller.setOrdBillList('N');
    }
    if (opt == 'noorder') {}
    if (opt == 'apprvpend') {
      ordcontroller.setApprovalStatus('PENDING');
    }
    if (opt == 'apprvreject') {
      ordcontroller.setApprovalStatus('REJECTED');
    }
  }

  PopupMenuButton<String> orderpopupMenuButton() {
    return PopupMenuButton(
        color: Get.isDarkMode ? tCardDarkColor : tCardLightColor,
        icon: Icon(
          Icons.more_vert,
          size: 24,
          color: Get.isDarkMode ? tWhiteColor : tDarkColor,
        ),
        elevation: 10, // add this line
        itemBuilder: (_) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                value: 'billed',
                child: Container(
                    width: 100,
                    // height: 30,
                    child: const Text(
                      "Billed",
                    )),
              ),
              PopupMenuItem<String>(
                value: 'billpend',
                child: Container(
                    width: 100,
                    // height: 30,
                    child: const Text(
                      "Bill Pending",
                    )),
              ),
              PopupMenuItem<String>(
                  value: 'apprvpend',
                  child: Container(
                      width: 100,
                      // height: 30,
                      child: const Text(
                        "Approval Pending",
                      ))),
              PopupMenuItem<String>(
                value: 'apprvreject',
                child: Container(
                    width: 100,
                    // height: 30,
                    child: const Text(
                      "Approval Rejected",
                    )),
              ),
            ],
        onSelected: (index) async {
          gotoselected(index);
        });
  }

  Widget _searchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            height: 50.0,
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
        /*Center(child: _filter()),*/
      ],
    );
  }

  Widget _filter() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
                    color: tPrimaryColor,
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
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: ordcontroller.reslist.value.length,
        itemBuilder: (context, index) {
          return _listItem(index);
        },
      ),
    );
  }

  Widget _listItem(index) {
    String _bilurl = "";
    String _ordurl = "";
    _billed = ordcontroller.reslist[index].billed == 'Y' ? true : false;
    _hasordpdf =
        ordcontroller.reslist[index].ordpdf!.trim().length > 0 ? true : false;
    if (ordcontroller.reslist[index].billpdf!.trim().length > 0) {
      _bilurl = appData.pdfbaseurl! +
          ordcontroller.reslist[index].billpdf!.trim() +
          '.pdf';
    }
    if (ordcontroller.reslist[index].ordpdf!.trim().length > 0) {
      _ordurl = appData.pdfbaseurl! +
          ordcontroller.reslist[index].ordpdf!.trim() +
          '.pdf';
    }
    _colorapproved = Colors.green;
    if (ordcontroller.reslist[index].approvalstatus!
        .toUpperCase()
        .contains('REJECTED')) {
      _colorapproved = Colors.red;
      _colorapproved = Colors.red;
    }
    if (ordcontroller.reslist[index].approvalstatus!
        .toUpperCase()
        .contains('PENDING')) {
      _colorapproved = Colors.orange;
    }
    return Card(
      color: Get.isDarkMode ? tCardDarkColor : tCardLightColor,
      child: ListTile(
        trailing: orderindexpopupMenuButton(ordcontroller.reslist[index]),
        title: Text(
          ordcontroller.reslist[index].ac_nm.toString(),
          style: Theme.of(context).textTheme.bodyLarge,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 4,
                child: Text(
                  ordcontroller.reslist[index].tran_dt.toString(),
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Flexible(
                flex: 4,
                child: Text(
                    ordcontroller.reslist[index].tran_desc.toString().trim() +
                        " - " +
                        ordcontroller.reslist[index].tran_no.toString(),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
              Flexible(
                flex: 4,
                child: Text(
                  ordcontroller.reslist[index].net_amt.toString(),
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                    flex: 6,
                    child: Text(
                        'Approval ' +
                            ordcontroller.reslist[index].approvalstatus!
                                .toString(),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: _colorapproved))),
                Flexible(
                  flex: 6,
                  child: _billed
                      ? Text(
                          '' +
                              ordcontroller.reslist[index].billdetails!
                                  .toString(),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: Theme.of(context).textTheme.bodyLarge)
                      : Text('Bill Not Generated',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.red)),
                ),
                /* Flexible(
              flex: 4,
              child: (_billed && controller.reslist[index].billpdf!.isNotEmpty)
                  ? IconButton(
                      icon: Icon(
                        Icons.picture_as_pdf,
                        size: 40.0,
                        color: Colors.green,
                      ),
                      onPressed: () async {
                        download(_bilurl, controller.reslist[index].billpdf!.trim() + '.pdf',
                            'Invoice -' + controller.reslist[index].billdetails!);
                      })
                  : Text(' '),
            ),*/
              ]),
        ]),
      ),
    );
  }

  PopupMenuButton<String> orderindexpopupMenuButton(OrderModel currorder) {
    bool cancancel =
        currorder.approvalstatus!.toUpperCase().contains('PENDING');
    bool billed = currorder.billed == 'Y' ? true : false;
    bool hasordpdf = currorder.ordpdf!.trim().length > 0 ? true : false;

    return PopupMenuButton(
        color: Get.isDarkMode ? tCardDarkColor : tCardLightColor,
        icon: Icon(
          Icons.more_vert,
          color: Get.isDarkMode ? tWhiteColor : tDarkColor,
        ), // add this line
        itemBuilder: (_) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                value: 'edit',
                enabled: !billed,
                child: Container(
                    width: 125,
                    // height: 30,
                    child: Text(
                      "Edit Order",
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
              ),
              PopupMenuItem<String>(
                value: 'ordpdf',
                enabled: hasordpdf,
                child: Container(
                    width: 125,
                    // height: 30,
                    child: Text(
                      "Order PDF",
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
              ),
              PopupMenuItem<String>(
                value: 'bilpdf',
                enabled: billed,
                child: Container(
                    width: 125,
                    // height: 30,
                    child: Text(
                      "Invoice PDF",
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
              ),
              PopupMenuItem<String>(
                value: 'trkord',
                child: Container(
                    width: 125,
                    child: Text(
                      "Track Order",
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
              ),
              PopupMenuItem<String>(
                value: 'trkbil',
                enabled: billed,
                child: Container(
                    width: 125,
                    child: Text(
                      "Track Bill",
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
              ),
              PopupMenuItem<String>(
                value: 'cancel',
                enabled: cancancel,
                child: Container(
                    width: 125,
                    child: Text(
                      "Cancel Order",
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
              ),
            ],
        onSelected: (index) async {
          ordindexselected(index, currorder);
        });
  }

  void ordindexselected(String opt, OrderModel currorder) async {
    if (opt == 'edit') {
      if (currorder.billpdf.toString().trim().length > 0) {
        Get.snackbar('Billed', 'Cannot Edit Order');
      } else {
        if (appSecure.editorder!) {
          if (appData.log_type != "DMAN") {
            setState(() {
              appData.prtid = int.parse(currorder.ac_id.toString());
              appData.prtnm = currorder.ac_nm!.trim();
              appData.ordrefno = currorder.ref_no;
              appData.bukid = currorder.tran_type_id ?? 0;
              appData.bukcmpstr = currorder.company_sel ?? "";
              appData.buknm = currorder.tran_desc;
              appData.billdetails = currorder.billdetails;
              appData.chainid = currorder.chainid ?? 0;
              appData.chainnm = currorder.chainareanm ?? "";
              appData.ordmaxlimit = 0.0;
              appData.ordlimitvalid = true;
              appData.saletype = currorder.saletype;
              appData.ordbilled = currorder.billed;
              appData.approvalstatus = currorder.approvalstatus ?? '';
              appData.ordqottype = 'ORD';
            });
            editcontroller.setOrderRecord();
            Get.to(() => const EditOrderScreen());
          }
        } else {
          Get.snackbar('Not Authorised', 'Edit Order');
        }
      }
    }
    if (opt == 'ordpdf') {
      if (currorder.ordpdf.toString().trim().length == 0) {
        Get.snackbar('Order', 'PDF Not Generated on Server..');
      } else {
        String _ordurl =
            appData.pdfbaseurl! + currorder.ordpdf!.trim() + '.pdf';
        download(_ordurl, currorder.ordpdf!.trim() + '.pdf',
            'Order -' + currorder.tran_no.toString());
      }
    }
    if (opt == 'bilpdf') {
      if (kDebugMode) {
        print(currorder.billpdf!.toString());
      }
      if (currorder.billpdf!.isEmpty == true) {
        Get.snackbar('Order', 'PDF Not Generated on Server..');
      } else {
        String _bilurl =
            appData.pdfbaseurl! + currorder.billpdf!.trim() + '.pdf';
        download(_bilurl, currorder.billpdf!.trim() + '.pdf',
            'Invoice -' + currorder.billdetails!);
      }
    }
    if (opt == 'cancel') {}
    if (opt == 'trkord') {
      trackcontroller.ordidstr.value = currorder.ref_no.toString().trim();
      trackcontroller.trantype.value = 'ORD';
      trackcontroller.trackApi();
      Get.to(() => const TrackScreen());
    }
    if (opt == 'trkbil') {
      //trackcontroller.setordIdstr(currorder.bill_ref_no.toString().trim());
      //trackcontroller.settrantype('SAL');
      //trackcontroller.trackApi();
      //Get.to(() => TrackScreen());
    }
  }

  Future download(String fileUrl, String fileName, String ptitle) async {
    getPermission();
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final permissionStatus = await Permission.storage.isGranted;
    if (permissionStatus == true) {
      final savePath = path.join(dir, fileName);
      await startDownload(savePath, fileUrl);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => PdfView(
          path: savePath,
          pdftitle: ptitle,
        ),
      ));
    } else {
      Get.snackbar('Permission', 'denied for download to ' + dir.toString());
    }
  }

  Future getLocaldirectory() async {
    final String dir = (await getApplicationDocumentsDirectory()).path;
    setState(() {
      _localdirpath = dir.toString();
      if (kDebugMode) {
        print(_localdirpath);
      }
    });
  }

  void getPermission() async {
    if (kDebugMode) {
      print("getPermission");
    }
    //await Permission..manageExternalStorage.request();
    await Permission.storage.request();
  }

  Future startDownload(String savePath, String urlPath) async {
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
      setState(() {
        progress = (receive / total * 100).toStringAsFixed(0) + '%';
      });
    }
  }

  _sharelink(String shrlink) async {
    String msg = shrlink;
    //String msg = '<a href="whatsapp://send?text='+shrlink + '">Open Link</a>';
    ShareExtend.share(msg, "text");
  }
}
