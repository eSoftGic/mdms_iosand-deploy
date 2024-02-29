// ignore_for_file: invalid_use_of_protected_member, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mdms_iosand/src/features/core/screens/prebook/home/model_prebook.dart';
import '../../../../../../singletons/AppData.dart';
import '../../../../../../singletons/appsecure.dart';
import '../../../../../constants/colors.dart';
import '../../../network/exceptions/general_exception_widget.dart';
import '../../../network/exceptions/internet_exception_widget.dart';
import '../../../network/status.dart';
import '../../dashboard/dashboard.dart';
import '../add/screen_prebookadd.dart';
import 'controller_prebook.dart';

class PrebookHomeScreen extends StatefulWidget {
  const PrebookHomeScreen({super.key});

  @override
  State<PrebookHomeScreen> createState() => _PrebookHomeScreenState();
}

class _PrebookHomeScreenState extends State<PrebookHomeScreen> {
  final preordcontroller = Get.put(PrebookController());
  bool _billed = false;
  String ordrs = "";
  bool showsrc = false;

  @override
  void initState() {
    super.initState();
    preordcontroller.ListApi();
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
            title: Text("Pre-Booking", style: Theme.of(context).textTheme.headlineMedium),
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
                    appData.ordqottype = "PREBK";
                    Get.to(() => const PreBookAddScreen());
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 24,
                  )),
              IconButton(
                  onPressed: () {
                    preordcontroller.refreshListApi();
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
              switch (preordcontroller.RxRequestStatus.value) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  if (preordcontroller.error.value == 'No Internet') {
                    return InternetExceptionWidget(
                        onPress: () => preordcontroller.refreshListApi());
                  } else {
                    return GeneralExceptionWidget(onPress: () => preordcontroller.refreshListApi());
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
    if (opt == 'order') {
      preordcontroller.setOrdBillList('Y');
    }
    if (opt == 'apprvpend') {
      preordcontroller.setApprovalStatus('PENDING');
    }
    if (opt == 'apprvreject') {
      preordcontroller.setApprovalStatus('REJECTED');
    }
  }

  PopupMenuButton<String> orderpopupMenuButton() {
    return PopupMenuButton(
        icon: const Icon(
          Icons.more_vert,
          color: tPrimaryColor,
          size: 24,
        ), // add this line
        itemBuilder: (_) => <PopupMenuItem<String>>[
              const PopupMenuItem<String>(
                  value: 'order',
                  child: SizedBox(
                      width: 100,
                      // height: 30,
                      child: Text(
                        "Order Prepared",
                        style: TextStyle(color: tAccentColor),
                      ))),
              const PopupMenuItem<String>(
                  value: 'apprvpend',
                  child: SizedBox(
                      width: 100,
                      // height: 30,
                      child: Text(
                        "Approval Pending",
                        style: TextStyle(color: tAccentColor),
                      ))),
              const PopupMenuItem<String>(
                  value: 'apprvreject',
                  child: SizedBox(
                      width: 100,
                      // height: 30,
                      child: Text(
                        "Approval Rejected",
                        style: TextStyle(color: tAccentColor),
                      ))),
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
              controller: preordcontroller.searchtxt,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                preordcontroller.applyfilters(value);
              },
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Obx(
          () => Text(
            preordcontroller.lislen.toString(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
            onPressed: () {
              preordcontroller.searchtxt.text = "";
              preordcontroller.refreshListApi();
            },
            icon: const Icon(
              Icons.refresh,
              size: 24,
            )),
        /*Center(child: _filter()),*/
      ],
    );
  }

  Widget _showList() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: preordcontroller.reslist.value.length,
        itemBuilder: (context, index) {
          return _listItem(index);
        },
      ),
    );
  }

  Widget _listItem(index) {
    _billed = preordcontroller.reslist[index].billed == 'Y' ? true : false;

    return Card(
      color: Get.isDarkMode ? tCardDarkColor : tCardLightColor,
      child: ListTile(
        trailing: orderindexpopupMenuButton(preordcontroller.reslist[index]),
        title: Text(
          preordcontroller.reslist[index].ac_nm.toString(),
          style: Theme.of(context).textTheme.bodyLarge,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 4,
                child: Text(
                  preordcontroller.reslist[index].tran_dt.toString(),
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Flexible(
                flex: 4,
                child: Text(
                  "${preordcontroller.reslist[index].tran_desc.toString().trim()} - ${preordcontroller.reslist[index].tran_no}",
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Flexible(
                flex: 4,
                child: Text(
                  preordcontroller.reslist[index].net_amt.toString(),
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
            Flexible(
                flex: 6,
                child: Text(
                    'Approval ${preordcontroller.reslist[index].approvalstatus!}',
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyMedium)),
            Flexible(
              flex: 6,
              child: _billed
                  ? Text(preordcontroller.reslist[index].billdetails!,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodyMedium)
                  : Text('Not Converted to Order',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red)),
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

  PopupMenuButton<String> orderindexpopupMenuButton(PreBookModel currorder) {
    bool cancancel = currorder.approvalstatus!.toUpperCase().contains('PENDING');
    bool billed = currorder.billed == 'Y' ? true : false;
    return PopupMenuButton(
        color: Get.isDarkMode ? tCardDarkColor : tCardLightColor,
        icon: Icon(
          Icons.more_vert,
          color: Get.isDarkMode ? tWhiteColor : tDarkColor,
          size: 24,
        ), // add this line
        itemBuilder: (_) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                value: 'edit',
                enabled: !billed,
                child: SizedBox(
                    width: 125,
                    // height: 30,
                    child: Text(
                      "Edit PreBook",
                      style: Theme.of(context).textTheme.headlineSmall,
                    )),
              ),
            ],
        onSelected: (index) async {
          ordindexselected(index, currorder);
        });
  }

  void ordindexselected(String opt, PreBookModel currorder) async {
    if (opt == 'edit') {
      if (currorder.billpdf.toString().trim().isNotEmpty) {
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
            Get.snackbar('Prebook', 'Edit');
            //editcontroller.setOrderRecord();
            //Get.to(() => const EditOrderScreen());
          }
        } else {
          Get.snackbar('Not Authorised', 'Edit Order');
        }
      }
    }
  }
}