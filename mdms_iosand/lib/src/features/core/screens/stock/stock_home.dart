// ignore_for_file: invalid_use_of_protected_member, unused_element, deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:liquid_pull_refresh/liquid_pull_refresh.dart';
import 'package:mdms_iosand/src/features/core/screens/stock/stock_controller.dart';
import 'package:mdms_iosand/src/features/core/screens/stock/stock_filter.dart';
import '../../../../../singletons/singletons.dart';
import '../../../../constants/constants.dart';
import '../../../../ecommerce/widget/imagebyte_widget.dart';
import '../../../../ecommerce/widget/imageurl_widget.dart';
import '../../../../utils/pdfview.dart';
import '../../network/exceptions/general_exception_widget.dart';
import '../../network/exceptions/internet_exception_widget.dart';
import '../../network/status.dart';
import '../allocation/controller_allocation.dart';
import '../allocation/screen_allocation.dart';
import '../dashboard/dashboard.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;
import 'package:date_format/date_format.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class StockHomeScreen extends StatefulWidget {
  const StockHomeScreen({super.key});

  @override
  State<StockHomeScreen> createState() => _StockHomeScreenState();
}

class _StockHomeScreenState extends State<StockHomeScreen> {
  final stockController = Get.put(StockController());
  final aController = Get.put(AllocationController());

  final PdfColor baseColor = PdfColors.teal;
  final PdfColor accentColor = PdfColors.blueGrey900;
  static const _darkColor = PdfColors.blueGrey800;
  static const _lightColor = PdfColors.white;
  final pw.Document pdfdoc = pw.Document(deflate: zlib.encode);
  bool showsrc = false;
  bool withimg = false;

  Future<void> _handleRefresh() async {
    stockController.applyfilters('');
    stockController.refreshListApi();
    return await Future.delayed(const Duration(seconds: 1));
  }

  @override
  void initState() {
    super.initState();
    stockController.withimg.value = withimg;
    stockController.ListApi();
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
            backgroundColor: tCardBgColor,
            title: const Text("Stock Listing"),
            actions: [
              Row(
                children: [
                  /*IconButton(
                      onPressed: () {
                        setState(() {
                          withimg = !withimg;
                          stockController.withimg.value = withimg;
                          stockController.refreshListApi();
                        });
                      },
                      icon: Icon(
                        withimg
                            ? Icons.image_outlined
                            : Icons.image_not_supported_outlined,
                        size: 28,
                      )),
                  */
                  IconButton(
                      onPressed: () {
                        setState(() {
                          showsrc = !showsrc;
                        });
                      },
                      icon: const Icon(
                        Icons.search,
                        size: 28,
                      )),
                ],
              ),
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
              switch (stockController.RxRequestStatus.value) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  if (stockController.error.value == 'No Internet') {
                    return InternetExceptionWidget(
                        onPress: () => stockController.refreshListApi());
                  } else {
                    return GeneralExceptionWidget(
                        onPress: () => stockController.refreshListApi());
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

  Widget _searchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: TextFormField(
              controller: stockController.searchtxt,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                stockController.applyfilters(value);
              },
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Obx(
          () => Text(
            stockController.lislen.toString(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
        IconButton(
            onPressed: () {
              stockController.searchtxt.text = "";
              stockController.refreshListApi();
            },
            icon: const Icon(
              Icons.refresh,
              size: 24,
            )),
        Center(child: _filter()),
        IconButton(
          icon: const Icon(
            Icons.picture_as_pdf_outlined,
            size: 24.0,
          ),
          onPressed: () {
            _generateStockPdf(context);
          },
        )
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
            Get.to(() => const StockFilter());
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
                          (appData.filtcompany.length +
                                  appData.filtcategory.length +
                                  appData.filtbrand.length)
                              .toString(),
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
        child: SizedBox(
      height: MediaQuery.of(context).size.height - 200,
      child: LiquidPullRefresh(
        onRefresh: _handleRefresh,
        height: 200,
        color: tAccentColor.withOpacity(0.3),
        backgroundColor: tCardLightColor,
        animSpeedFactor: 1,
        showChildOpacityTransition: true,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: stockController.reslist.value.length,
          itemBuilder: (context, index) {
            return _listItem(index);
          },
        ),
      ),
    ));
  }

  PopupMenuButton<String> itempopupMenuButton(int itemid) {
    return PopupMenuButton(
        icon: const Icon(
          Icons.more_vert,
          color: tPrimaryColor,
          size: 24,
        ), // add this line
        itemBuilder: (_) => <PopupMenuItem<String>>[
              const PopupMenuItem<String>(
                  value: 'allocate',
                  child: SizedBox(
                      width: 100,
                      // height: 30,
                      child: Text(
                        "Allocation",
                        style: TextStyle(color: tAccentColor),
                      ))),
            ],
        onSelected: (index) async {
          gotooptselected(index, itemid);
        });
  }

  void gotooptselected(String opt, int itemid) async {
    if (opt == 'allocate') {
      aController.onChangeGroup('Itemwise');
      aController.setprtIdstr('');
      aController.setItmIdstr(itemid.toString().trim());
      Get.to(() => const AllocateScreen());
    }
  }

  Widget _listItem(index) {
    // Image Setup
    // This is from IP file
    //String imgurl = '';
    /*if (stockController.reslist[index].show_image == true) {
      _imgurl = "http://" +
          appData.log_ip! +
          "/image/item/" +
          stockController.reslist[index].tbl_id.toString().trim() +
          ".jpg";
    }*/
    // This is for imagebyte

    String itmimgbyte =
        stockController.reslist[index].item_image.toString().trim() == 'na'
            ? ''
            : stockController.reslist[index].item_image.toString().trim();
    var coloravailable = tPrimaryColor;

    String itmmrpstk = stockController.reslist[index].qty.toString();
    if (appSecure.showitemstock == false) {
      itmmrpstk = "YES";
      if (stockController.reslist[index].qty < 0) {
        itmmrpstk = "NA";
        coloravailable = Colors.red;
      }
    }

    return Card(
      elevation: 1.0,
      color: Get.isDarkMode ? tCardDarkColor : tCardLightColor,
      child: ListTile(
        //leading: ImageByteWidget(b64: itmimgbyte),
        title: Text(
          stockController.reslist[index].item_nm,
          style:
              Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18),
          softWrap: true,
          //overflow: TextOverflow.ellipsis,
        ),
        trailing:
            itmimgbyte.isNotEmpty ? ImageByteWidget(b64: itmimgbyte) : null,
        //itempopupMenuButton(stockController.reslist[index].item_id),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 6,
                child: Text(
                  stockController.reslist[index].company_nm.toString(),
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Flexible(
                flex: 6,
                child: Text(
                  itmmrpstk,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: coloravailable, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 6,
                  child: Text(stockController.reslist[index].item_brand_nm,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                Flexible(
                  flex: 6,
                  child: Text(stockController.reslist[index].mrp_ref.toString(),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 6,
                  child: Text(stockController.reslist[index].item_cat_nm,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                Flexible(
                  flex: 6,
                  child: Text(
                      stockController.reslist[index].rate.toStringAsFixed(2),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
              ]),
        ]),
      ),
    );
  }

  _generateStockPdf(context) async {
    //dir Path
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/Stock.pdf';
    final base = await PdfGoogleFonts.robotoRegular();
    final bold = await PdfGoogleFonts.robotoRegular();
    final italic = await PdfGoogleFonts.robotoItalic();
    //final font1 = await PdfGoogleFonts.openSansRegular();
    //final font2 = await PdfGoogleFonts.openSansBold();
    final File file = File(path);
    //_font = await rootBundle.load("assets/fonts/OpenSans-Bold.ttf");
    //_ttf = Font.ttf(_font);

    //Build Doc

    //final pw.Document pdfdoc = pw.Document();
    final pdfdoc = pw.Document(pageMode: PdfPageMode.outlines);
    pdfdoc.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.letter.copyWith(
            marginBottom: 1.5 * PdfPageFormat.cm,
            marginLeft: 0.5 * PdfPageFormat.cm,
            marginRight: 0.5 * PdfPageFormat.cm),
        orientation: pw.PageOrientation.portrait,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        theme: pw.ThemeData.withFont(base: base, bold: bold, italic: italic),
        build: (pw.Context context) => <pw.Widget>[
              _buildTable(context),
              //_contentFooter(context),
            ]));

    //Save Doc
    await file.writeAsBytes(await pdfdoc.save());

    // View Pdf
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => PdfView(
        path: path,
        pdftitle: 'Stock Report',
      ),
    ));
    //Share PDF
  }

  p1() {}

  pw.Widget _buildTable(pw.Context context) {
    const tableHeaders = ['Brand', 'Item', 'Stock', 'Rate with Gst'];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
        color: baseColor,
      ),
      headerHeight: 25,
      cellHeight: 40,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.centerRight,
      },
      headerStyle: pw.TextStyle(
          color: baseColor.luminance < 0.5 ? _lightColor : _darkColor,
          fontSize: 10,
          fontWeight: pw.FontWeight.bold),
      cellStyle: const pw.TextStyle(
        color: _darkColor,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: accentColor)),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        stockController.reslist.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => getIndex(row, col),
        ),
      ),
    );
  }

  pw.Widget _contentFooter(pw.Context context) {
    return pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: [
          pw.Container(
            height: 20,
            width: 200,
            child: pw.Text('Total Count: ${stockController.reslist.length}',
                style: const pw.TextStyle(
                  fontSize: 16,
                )),
          ),
        ]);
  }

  pw.Widget _buildHeader(pw.Context context) {
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
          child: pw.Text('Brandwise Item Stock List ',
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
      ]))
    ]);
  }

  String getIndex(int rw, int cl) {
    /*
    if (cl == 0) {
      String rbnm =
          _stklistforDisplay[rw].item_brand_nm.replaceAll('-', ' ').trim();
      String rinm = _stklistforDisplay[rw].item_nm.replaceAll('-', ' ').trim();
      print(rw.toString() + '>brand.' + rbnm + '>itmnm.' + rinm);
    }
    */
    switch (cl) {
      case 0:
        String bnm = stockController.reslist[rw].item_brand_nm
            .replaceAll('-', ' ')
            .trim();
        return bnm.toString();
      case 1:
        String inm =
            stockController.reslist[rw].item_nm.replaceAll('-', ' ').trim();
        return inm.toString();
      case 2:
        String qt = '0';
        if (stockController.reslist[rw].qty.abs() > 0) {
          qt = stockController.reslist[rw].qty.toStringAsFixed(0).trim();
        }
        return qt.toString();
      case 3:
        double rt = 0;
        double gstp = (stockController.reslist[rw].cgst_tax_page +
            stockController.reslist[rw].sgst_tax_page +
            stockController.reslist[rw].addgst_tax_page);
        if (stockController.reslist[rw].rate.abs() > 0) {
          rt = stockController.reslist[rw].rate * (1 + (gstp * 0.01));
        }
        return rt.toStringAsFixed(2).trim();

      default:
        throw '';
    }
  }

  pw.Widget _buildFooter(pw.Context context) {
    String tdt = formatDate(DateTime.now(), [dd, '.', mm, '.', yyyy]);
    return pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: [
          pw.Container(
            height: 20,
            width: 200,
            child: pw.Text('Dated : $tdt',
                style: pw.TextStyle(
                    fontSize: 16, fontWeight: pw.FontWeight.normal)),
          ),
          pw.Container(
            height: 20,
            width: 100,
            child: pw.Text('Page ${context.pageNumber} / ${context.pagesCount}',
                style: pw.TextStyle(
                    fontSize: 16, fontWeight: pw.FontWeight.normal)),
          ),
        ]);
  }
}

/*class ImageUrlWidget extends StatelessWidget {
  String imgurl;
  ImageUrlWidget({super.key, required this.imgurl});

  @override
  Widget build(BuildContext context) {
    bool hasimgUrl = this.imgurl.trim().length > 0;
    double imgwid = 100;
    double imght = 100;

    return Container(
        margin: const EdgeInsets.only(right: 5, top: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: tCardLightColor,
        ),
        child: hasimgUrl
            ? Container(
                child: GestureDetector(
                  onTap: () async {
                    await showDialog(context: context, builder: (_) => zoomImage(imgurl));
                  },
                ),
                width: imgwid,
                height: imght,
                decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                    image: new DecorationImage(fit: BoxFit.cover, image: new NetworkImage(imgurl))))
            : Container(
                child: GestureDetector(
                  onTap: () async {
                    await showDialog(context: context, builder: (_) => zoomImage(imgurl));
                  },
                ),
                width: imgwid,
                height: imght,
                decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                    image:
                        new DecorationImage(fit: BoxFit.cover, image: new AssetImage(tNoImage)))));
  }

  Widget zoomImage(String imgurl) {
    return Dialog(
      child: Container(
        width: 250,
        height: 250,
        decoration:
            BoxDecoration(image: DecorationImage(image: NetworkImage(imgurl), fit: BoxFit.cover)),
      ),
    );
  }
}*/

/*
class ImageByteWidget extends StatelessWidget {
  String b64;
  ImageByteWidget({super.key, required this.b64});
  @override
  Widget build(BuildContext context) {
    DecorationImage? decorationImage;
    Uint8List bytesImage = const Base64Decoder().convert(b64);
    bool hasimgByte = this.b64.trim().length > 0;
    double imgwid = 100;
    double imght = 100;
    return Container(
        margin: const EdgeInsets.only(right: 5, top: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: tCardLightColor,
        ),
        child: hasimgByte
            ? GestureDetector(
                onTap: () async {
                  await showDialog(context: context, builder: (_) => zoomImage(bytesImage));
                },
                child: Container(child: Image.memory(bytesImage, width: imgwid, height: imght)))
            : Container(
                width: imgwid,
                height: imght,
                decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                    image:
                        new DecorationImage(fit: BoxFit.cover, image: new AssetImage(tNoImage)))));
  }

  Widget zoomImage(Uint8List bytesImage) {
    return Dialog(
      child: Container(child: Image.memory(bytesImage, width: 250, height: 250)),
    );
  }
}*/
