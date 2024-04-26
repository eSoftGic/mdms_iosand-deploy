// ignore_for_file: unused_local_variable, invalid_use_of_protected_member, non_constant_identifier_names, deprecated_member_use, avoid_unnecessary_containers

import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/common_widgets/appbar/custom_appbar.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/ledger/controller_ledger.dart';
import '../../../../../../../singletons/singletons.dart';
import '../../../../../../constants/constants.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import '../../../../../../utils/pdfview.dart';

class PartyLedger extends StatelessWidget {
  const PartyLedger({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    PartyLedgerController grlController = Get.put(PartyLedgerController());
    bool soasc = false;
    final df = DateFormat('dd/MM/yyyy');
    final dfmdy = DateFormat('MM/dd/yyyy');
    DateTime tdate = DateTime.now();
    DateTime fdate = DateTime.now().subtract(const Duration(days: 30));
    DateTime inidate = DateTime.now().subtract(const Duration(days: 30));
    DateTime fstdt = DateTime.parse('2022-04-01');
    DateTime enddt = DateTime.parse('2023-03-31');
    if (appData.acstdt != null) {
      fstdt = DateTime.parse(appData.acstdt!);
      enddt = DateTime.parse(appData.acendt!);
    }
    final FocusNode myFocusfDt = FocusNode();
    final FocusNode myFocustDt = FocusNode();
    final TextEditingController fdtController = TextEditingController();
    final TextEditingController tdtController = TextEditingController();
    fdtController.text = df.format(fdate);
    tdtController.text = df.format(tdate);
    grlController.setfdt(dfmdy.format(fdate));
    grlController.settdt(dfmdy.format(tdate));
    //Pdf Config
    const PdfColor baseColor = PdfColors.blue;
    const PdfColor accentColor = PdfColors.blueGrey900;
    const PdfColor darkColor = PdfColors.blueGrey800;
    const PdfColor lightColor = PdfColors.white;
    final String Rpttitle = "Ledger Statement for ${appData.prtnm!}";
    final pw.Document pdfdoc = pw.Document(deflate: zlib.encode);

    // PDF Start
    pw.Widget buildHeader(pw.Context context) {
      return pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.center, children: [
        pw.Expanded(
            child: pw.Column(children: [
          pw.Container(
            height: 30,
            padding: const pw.EdgeInsets.only(left: 20),
            alignment: pw.Alignment.center,
            child: pw.Text(appData.log_conm!,
                style: pw.TextStyle(
                  color: baseColor,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 20,
                )),
          ),
          pw.Container(
            height: 30,
            padding: const pw.EdgeInsets.only(left: 20),
            alignment: pw.Alignment.center,
            child: pw.Text('Ledger Statement ',
                style: pw.TextStyle(
                  color: baseColor,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 20,
                )),
          ),
          pw.Divider(
            color: PdfColors.blue,
            height: 2,
          ),
          pw.Container(
            height: 30,
            padding: const pw.EdgeInsets.only(left: 20),
            alignment: pw.Alignment.center,
            child: pw.Text('Party Name :${appData.prtnm!}',
                style: pw.TextStyle(
                  color: baseColor,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 18,
                )),
          ),
          pw.Container(
            height: 30,
            padding: const pw.EdgeInsets.only(left: 20),
            alignment: pw.Alignment.center,
            child: pw.Text('Period ${df.format(fdate)}-${df.format(tdate)}',
                style: pw.TextStyle(
                  color: baseColor,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 18,
                )),
          ),
        ]))
      ]);
    }

    pw.Widget buildFooter(pw.Context context) {
      String tdt = formatDate(DateTime.now(), [dd, '-', mm, '-', yyyy]);
      return pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Container(
              height: 20,
              width: 200,
              child: pw.Text('Dated : $tdt',
                  style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            ),
            pw.Container(
              height: 20,
              width: 100,
              child: pw.Text('Page ${context.pageNumber} / ${context.pagesCount}',
                  style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            ),
          ]);
    }

    String? getIndex(int rw, int cl) {
      switch (cl) {
        case 0:
          return grlController.grllist[rw].trandt!.toString();
        case 1:
          return grlController.grllist[rw].trantype!.toString() +
              grlController.grllist[rw].tranno!.toString().trim();
        case 2:
          return grlController.grllist[rw].dbamt!.toStringAsFixed(2);
        case 3:
          return grlController.grllist[rw].cramt!.toStringAsFixed(2);
        case 4:
          return grlController.grllist[rw].balamt!.toStringAsFixed(2) +
              grlController.grllist[rw].balcrdb!.toString();
        case 5:
          return grlController.grllist[rw].descrem!.toString().trim();
      }
      return null;
    }

    pw.Widget buildTable(pw.Context context) {
      const tableHeaders = [
        'Date',
        'Document Refno.',
        'Debit Rs.',
        'Credit Rs.',
        'Balance Rs.',
        'Details'
      ];

      return pw.Table.fromTextArray(
        border: null,
        cellAlignment: pw.Alignment.centerLeft,
        headerDecoration: const pw.BoxDecoration(
            borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)), color: baseColor),
        headerHeight: 25,
        cellHeight: 40,
        columnWidths: {
          0: const pw.FixedColumnWidth(55),
          1: const pw.FixedColumnWidth(65),
          2: const pw.FixedColumnWidth(65),
          3: const pw.FixedColumnWidth(65),
          4: const pw.FixedColumnWidth(65),
          5: const pw.FlexColumnWidth(),
        },
        //defaultColumnWidth: pw.FlexColumnWidth(),
        cellAlignments: {
          0: pw.Alignment.centerLeft,
          1: pw.Alignment.centerLeft,
          2: pw.Alignment.centerRight,
          3: pw.Alignment.centerRight,
          4: pw.Alignment.centerRight,
          5: pw.Alignment.centerLeft,
        },
        headerStyle: pw.TextStyle(
            color: baseColor.luminance < 0.5 ? lightColor : darkColor,
            fontSize: 10,
            fontWeight: pw.FontWeight.bold),
        cellStyle: pw.TextStyle(color: darkColor, fontSize: 9, fontWeight: pw.FontWeight.normal),
        rowDecoration: const pw.BoxDecoration(
            /*border: pw.BoxBorder(
          bottom: true,
          color: accentColor,
          width: .5,
        ),*/
            ),
        headers: List<String>.generate(
          tableHeaders.length,
          (col) => tableHeaders[col],
        ),
        data: List<List<String>>.generate(
          grlController.grllen.value,
          (row) =>
              List<String>.generate(tableHeaders.length, (col) => getIndex(row, col) as String),
          growable: true,
        ),
      );
    }

    pw.Widget contentFooter(pw.Context context) {
      return pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Container(
              height: 20,
              width: 200,
              child: pw.Text('Debit: ${grlController.dbtot.value}',
                  style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            ),
            pw.Container(
              height: 20,
              width: 200,
              child: pw.Text('Credit: ${grlController.crtot.value}',
                  style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            ),
          ]);
    }

    generatePdf(context) async {
      //dir Path
      final String dir = (await getApplicationDocumentsDirectory()).path;
      final String path = '$dir/Grl.pdf';
      final File file = File(path);
      //Build Doc
      final pdfdoc = pw.Document(pageMode: PdfPageMode.outlines);
      pdfdoc.addPage(pw.MultiPage(
          pageFormat: PdfPageFormat.letter.copyWith(
              marginBottom: 1.5 * PdfPageFormat.cm,
              marginLeft: 0.5 * PdfPageFormat.cm,
              marginRight: 0.5 * PdfPageFormat.cm),
          orientation: pw.PageOrientation.portrait,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          header: buildHeader,
          footer: buildFooter,
          build: (pw.Context context) => <pw.Widget>[
                buildTable(context),
                contentFooter(context),
              ]));
      //Save Doc
      await file.writeAsBytes(await pdfdoc.save());
      // View Pdf
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => PdfView(
          path: path,
          pdftitle: 'Party Ledger',
        ),
      ));
    }
    // PDF End

    Future<Null> selectFDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: inidate,
          firstDate: DateTime(fstdt.year, fstdt.month, fstdt.day),
          lastDate: DateTime(enddt.year, enddt.month, enddt.day));
      if (picked != null) {
        fdate = picked;
        grlController.setfdt(dfmdy.format(fdate));
        fdtController.text = df.format(fdate);
      }
    }

    Future<Null> selectTDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: tdate,
          firstDate: DateTime(fstdt.year, fstdt.month, fstdt.day),
          lastDate: DateTime(enddt.year, enddt.month, enddt.day));
      if (picked != null && picked != tdate) {
        tdate = picked;
        grlController.setfdt(dfmdy.format(tdate));
        tdtController.text = df.format(tdate);
      }
    }

    showgrl() async {
      grlController.setfdt(dfmdy.format(fdate));
      grlController.settdt(dfmdy.format(tdate));
      //grlController.setsordad(grlController.setsordad(_soasc);
      grlController.prtGrlApi();
    }

    ShowButton() {
      return IconButton(
        icon: const Icon(Icons.remove_red_eye_outlined),
        color: tAccentColor,
        iconSize: 30.0,
        disabledColor: Colors.grey,
        highlightColor: tPrimaryColor,
        onPressed: () {
          showgrl();
        },
      );
    }

    ExpButton(BuildContext context) {
      return IconButton(
          icon: const Icon(
            Icons.picture_as_pdf,
            color: tAccentColor,
          ),
          iconSize: 30.0,
          onPressed: !appSecure.sharegrl!
              ? null
              : () async {
                  generatePdf(context);
                });
    }

    Card buildledgeroption(BuildContext context) {
      return Card(
          color: Colors.blueGrey.shade50,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
                      SizedBox(
                          width: 90.0,
                          child: InkWell(
                            onTap: () {
                              selectFDate(context);
                            },
                            child: IgnorePointer(
                              child: TextField(
                                focusNode: myFocusfDt,
                                controller: fdtController,
                                style: const TextStyle(fontSize: 14.0),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(1.0),
                                  border: InputBorder.none,
                                  labelText: "From Dt.",
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        width: 90.0,
                        child: InkWell(
                            onTap: () {
                              selectTDate(context);
                            },
                            child: IgnorePointer(
                              child: TextField(
                                focusNode: myFocustDt,
                                controller: tdtController,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(2.0),
                                  border: InputBorder.none,
                                  labelText: "To Dt.",
                                ),
                              ),
                            )),
                      ),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(() {
                              return Switch(
                                value: grlController.srtdesc.value,
                                onChanged: (value) {
                                  soasc = value;
                                  grlController.setsordad(value);
                                },
                                activeColor: tAccentColor,
                              );
                            }),
                            ShowButton(),
                            ExpButton(context),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ],
              )));
    }

    Column buildGrlColumn(PartyLedgerController grlController) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
            Text(
              'Date     ',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              'Debit',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              'Credit',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              'Balance',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
            const Text(
              'Details',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              grlController.dbtot.value.toString(),
              style:
                  TextStyle(fontSize: 14, color: Colors.blue.shade900, fontWeight: FontWeight.bold),
            ),
            Text(
              grlController.crtot.value.toString(),
              style:
                  TextStyle(fontSize: 14, color: Colors.blue.shade900, fontWeight: FontWeight.bold),
            ),
            Text(
              grlController.clbal.value.toString(),
              style:
                  TextStyle(fontSize: 14, color: Colors.blue.shade900, fontWeight: FontWeight.bold),
            ),
          ]),
          const Divider(
            color: tPrimaryColor,
          ),
          Obx(() {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: grlController.grllen.value,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  grlController.grllist[index].trandt!.toString(),
                                  style: const TextStyle(fontSize: 14, color: Colors.black),
                                ),
                                Text(
                                  grlController.grllist[index].dbamt! > 0
                                      ? grlController.grllist[index].dbamt!.toStringAsFixed(2)
                                      : '',
                                  style: TextStyle(fontSize: 14, color: Colors.red.shade900),
                                ),
                                Text(
                                  grlController.grllist[index].cramt! > 0
                                      ? grlController.grllist[index].cramt!.toStringAsFixed(2)
                                      : '',
                                  style: TextStyle(fontSize: 14, color: Colors.blue.shade900),
                                ),
                                Text(
                                  grlController.grllist[index].balamt!.toStringAsFixed(2) +
                                      grlController.grllist[index].balcrdb!,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: grlController.grllist[index].balamt! < 0
                                          ? Colors.red.shade900
                                          : Colors.blue.shade900),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "${grlController.grllist[index].trantype!} ${grlController.grllist[index].tranno!}",
                                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                                ),
                              ],
                            ),
                            Container(
                              child: Text(
                                grlController.grllist[index].descrem!.toString(),
                                style: const TextStyle(fontSize: 12, color: Colors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {});
                });
          }),
        ],
      );
    }

    Widget showpartyledger(BuildContext context, PartyLedgerController controller) {
      return grlController.grllist.value.isNotEmpty
          ? buildGrlColumn(grlController)
          : const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
        appBar: CustomAppBar(
          title: ('${appData.prtnm!} Ledger'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildledgeroption(context),
                Obx(() {
                  return showpartyledger(context, grlController);
                }),
                //OrderSummary(),
              ],
            ),
          ),
        ));
  }
}