// ignore_for_file: unused_local_variable, invalid_use_of_protected_member, non_constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/common_widgets/appbar/custom_appbar.dart';
import '../../../../../../constants/colors.dart';
import '../../../../network/exceptions/general_exception_widget.dart';
import '../../../../network/exceptions/internet_exception_widget.dart';
import '../../../../network/status.dart';
import 'controller_os.dart';
import 'dart:core';
import 'dart:io';
import '../../../../../../../singletons/singletons.dart';
import 'package:date_format/date_format.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import '../../../../../../utils/pdfview.dart';

class PartyOSScreen extends StatelessWidget {
  const PartyOSScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PartyOsController osController = Get.put(PartyOsController());

    //Pdf Config
    const PdfColor baseColor = PdfColors.blue;
    const PdfColor accentColor = PdfColors.blueGrey900;
    const PdfColor darkColor = PdfColors.blueGrey800;
    const PdfColor lightColor = PdfColors.white;
    final String Rpttitle = "O/S Statement for ${appData.prtnm!}";
    final pw.Document pdfdoc = pw.Document(deflate: zlib.encode);
    // PDF Start
    String? getIndex(int rw, int cl) {
      switch (cl) {
        case 0:
          return osController.oslist[rw].trandt!;
        case 1:
          return osController.oslist[rw].tranno!;
        case 2:
          return osController.oslist[rw].trandesc!;
        case 3:
          return osController.oslist[rw].netamt!.toStringAsFixed(2);
        case 4:
          return osController.oslist[rw].duedt!;
        case 5:
          return osController.oslist[rw].pendday == null
              ? '0'
              : osController.oslist[rw].pendday!.toStringAsFixed(0);
        case 6:
          return osController.oslist[rw].rcvdamt == null
              ? '0'
              : osController.oslist[rw].rcvdamt!.toStringAsFixed(2);
        case 7:
          return osController.oslist[rw].rcvdamt == null
              ? osController.oslist[rw].netamt!.toStringAsFixed(2)
              : (osController.oslist[rw].netamt! - osController.oslist[rw].rcvdamt!)
                  .toStringAsFixed(2);
      }
      return null;
    }

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
                  fontSize: 18,
                )),
          ),
          pw.Container(
            height: 30,
            padding: const pw.EdgeInsets.only(left: 20),
            alignment: pw.Alignment.center,
            child: pw.Text('Outstanding Statement',
                style: pw.TextStyle(
                  color: baseColor,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 18,
                )),
          ),
          pw.Divider(
            color: PdfColors.blue,
            height: 2,
          ),
          pw.Container(
            height: 30,
            padding: const pw.EdgeInsets.only(left: 20),
            alignment: pw.Alignment.centerLeft,
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
            child: pw.Text('O/S Rs. :${osController.ostot.value}',
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

    pw.Widget buildTable(pw.Context context) {
      const tableHeaders = [
        'Bill Dt.   ',
        'Bill No.   ',
        'Bill Type  ',
        'Bill Amt.  ',
        'Due Dt.    ',
        'Due Days   ',
        'Amt. Rcvd. ',
        'Pending Amt'
      ];

      return pw.Table.fromTextArray(
        border: null,
        cellAlignment: pw.Alignment.centerLeft,
        headerDecoration: const pw.BoxDecoration(
            borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)), color: baseColor),
        headerHeight: 25,
        cellHeight: 40,
        cellAlignments: {
          0: pw.Alignment.centerLeft,
          1: pw.Alignment.centerLeft,
          2: pw.Alignment.centerLeft,
          3: pw.Alignment.centerRight,
          4: pw.Alignment.centerLeft,
          5: pw.Alignment.centerLeft,
          6: pw.Alignment.centerRight,
          7: pw.Alignment.centerRight,
        },
        headerStyle: pw.TextStyle(
            color: baseColor.luminance < 0.5 ? lightColor : darkColor,
            fontSize: 10,
            fontWeight: pw.FontWeight.bold),
        cellStyle: const pw.TextStyle(
          color: darkColor,
          fontSize: 10,
        ),
        /*
      rowDecoration: pw.BoxDecoration(
        border: pw.BoxBorder(bottom:, color: accentColor, width: .5,
        ),
      ),*/
        headers: List<String>.generate(
          tableHeaders.length,
          (col) => tableHeaders[col],
        ),
        data: List<List<String>>.generate(
          osController.oslen.value,
          (row) => List<String>.generate(
            tableHeaders.length,
            (col) => getIndex(row, col)!,
          ),
        ),
      );
    }

    generatePdf(context) async {
      //dir Path
      final String dir = (await getApplicationDocumentsDirectory()).path;
      final String path = '$dir/Os.pdf';
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
              ]));

      //Save Doc
      await file.writeAsBytes(await pdfdoc.save());
      //file.writeAsBytesSync(pdfdoc.save() as Uint8List);

      // View Pdf
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => PdfView(
          path: path,
          pdftitle: 'Party O/S',
        ),
      ));
    }

    // PDF End
    ExpButton(BuildContext context) {
      return IconButton(
          icon: const Icon(Icons.picture_as_pdf),
          color: Colors.blue,
          iconSize: 30.0,
          onPressed: !appSecure.shareos!
              ? null
              : () async {
                  generatePdf(context);
                });
    }

    Widget showos(BuildContext context, PartyOsController controller) {
      return osController.oslist.value.isNotEmpty
          ? buildColumn(osController, ExpButton, context)
          : const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
        appBar: CustomAppBar(
          title: ('${appData.prtnm!} O/S'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Obx(() {
                  switch (osController.RxRequestStatus.value) {
                    case Status.LOADING:
                      return const Center(child: CircularProgressIndicator());
                    case Status.ERROR:
                      if (osController.error.value == 'No Internet') {
                        return InternetExceptionWidget(onPress: () => osController.prtOsApi());
                      } else {
                        return GeneralExceptionWidget(onPress: () => osController.prtOsApi());
                      }
                    case Status.COMPLETED:
                      return showos(context, osController);
                  }
                }),
              ],
            ),
          ),
        ));
  }

  Column buildColumn(PartyOsController osController, IconButton Function(BuildContext context) ExpButton,
      BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
          Text(
            'Bill Date  ',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          Text(
            'Bill No ',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          Text(
            'Bill Amt ',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          Text(
            'Rcvd Amt',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ]),
        const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
          Text(
            'Due  Date  ',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          Text(
            'Type    ',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          Text(
            'Due Days ',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          Text(
            'Pend.Amt',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'O/S Rs. ${osController.ostot.value}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.red.shade900,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ExpButton(context),
                    ],
                  )),
            ]),
        const Divider(
          color: tPrimaryColor,
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: osController.oslen.value,
            itemBuilder: (context, index) {
              String pamt = "";
              pamt = (osController.oslist[index].netamt! - osController.oslist[index].rcvdamt!)
                  .toStringAsFixed(2);

              return ListTile(
                  title: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                osController.oslist[index].trandt!,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: tPrimaryColor),
                              ),
                            ),
                            Text(
                              osController.oslist[index].tranno.toString(),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold, color: tPrimaryColor),
                            ),
                            Text(
                              osController.oslist[index].netamt!.toDouble().toString(),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold, color: tPrimaryColor),
                            ),
                            Text(
                              osController.oslist[index].rcvdamt.toString(),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold, color: tPrimaryColor),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              osController.oslist[index].duedt!,
                              style: TextStyle(fontSize: 14, color: Colors.blueGrey.shade600),
                            ),
                            Text(
                              osController.oslist[index].trandesc!,
                              style: TextStyle(fontSize: 12, color: Colors.blueGrey.shade600),
                            ),
                            Text(
                              osController.oslist[index].pendday.toString(),
                              style: TextStyle(fontSize: 12, color: Colors.blueGrey.shade600),
                            ),
                            Text(
                              pamt,
                              style: TextStyle(fontSize: 14, color: Colors.red.shade900),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    /*
            showDialog(
                barrierDismissible: false,
                context: context,
                child: CupertinoAlertDialog(
                  title: Column(
                    children: <Widget>[
                      Icon(
                        Icons.person_outline,
                        color: Colors.lightBlue,
                      )
                    ],
                  ),
                  content: Text(_prtoslist[index].billchqch),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Bill Details'),
                    )
                  ],
                ));
            */
                  });
            }),
      ],
    );
  }
}