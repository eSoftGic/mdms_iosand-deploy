// ignore_for_file: invalid_use_of_protected_member, unused_local_variable, avoid_unnecessary_containers, avoid_print

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/core/neworder/controller/controller_cart.dart';
import 'package:mdms_iosand/src/features/core/neworder/controller/controller_item.dart';
import 'package:mdms_iosand/src/features/core/neworder/model/model_item.dart';

import '../../../../../constants/constants.dart';
import '../../../../../ecommerce/widget/custom_appbar.dart';
import '../../../../../ecommerce/widget/imagebyte_widget.dart';


class ItemScreen extends StatelessWidget {
  final ItemModel product;
  const ItemScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final curitmcontroller = Get.put(SingleItemController());
    final cartController = Get.put(OrderCartController());

    curitmcontroller.setcuritem(product);

    return Scaffold(
      appBar: CustomAppBar(
        title: product.item_nm!,
      ),
      bottomNavigationBar: 
      BottomAppBar(
        // CustomNavBar(),
        color: Colors.white,
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(
              color: tAccentColor,
              width: 1,
            ), //Border.all
            borderRadius: BorderRadius.circular(10),
          ), //BoxDecoration
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    if (curitmcontroller.curitem.ord_los_qty! > 0 ||
                        curitmcontroller.curitem.ord_qty! > 0) {
                      // Removing existing old order item
                      //cartController
                      //    .removefromCartlist(curitmcontroller.curitem);
                      // Adding new edited value item
                      cartController.addtoCartlist(curitmcontroller.curitem);
                      /*buildMsg(
                          'Cart Updated',
                          curitmcontroller.curitem.item_nm!,
                          Colors.green,
                          tWhiteColor);
                          */
                      Get.back();
                    } else {
                      buildMsg(
                          'Order Qty Not Set',
                          curitmcontroller.curitem.item_nm!,
                          Colors.red,
                          tWhiteColor);
                    }
                  },
                  child: Text(
                    'Add To Order',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: tPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    cartController.removefromCartlist(curitmcontroller.curitem);
                    buildMsg('Removed', curitmcontroller.curitem.item_nm!,
                        Colors.deepOrange, tWhiteColor);
                    Get.back();
                  },
                  child: Text(
                    'Delete',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: tPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      
      body: ListView(children: [
        //(curitmcontroller.prdimglist.value.isNotEmpty)
        //?
        SizedBox(
            height: 150,
            width: 100,
            child: Obx(() {
              return CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 2.0,
                    viewportFraction: 0.8,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    enableInfiniteScroll: false,
                    initialPage: 1,
                    autoPlay: false,
                  ),
                  items: curitmcontroller.prdimglist.value.map<Widget>((itm) {
                    return Builder(builder: (BuildContext context) {
                      return Container(
                        margin: const EdgeInsets.all(5),
                        child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            child: ImageByteWidget(
                              b64: itm.toString().trim(),
                              imgwid: 1000.0,
                              imght: 300.0,
                            )),
                      );
                    });
                  }).toList());
            })),
        //: const SizedBox(height: 150, width: 100, child: Text('No Image')),
        buildItemQtyDetails(context, curitmcontroller),
        buildProductInfo(context),
        buildProductFeatures(curitmcontroller, context)
      ]),
    );
  }

  Future<dynamic> buildMsg(
      String title, String mtext, Color tcolor, Color mcolor) {
    return Get.defaultDialog(
      title: title,
      middleText: mtext,
      backgroundColor: tAccentColor.withOpacity(0.5),
      titleStyle: TextStyle(color: tcolor, fontSize: 20),
      middleTextStyle: TextStyle(color: mcolor),
      radius: 15,
      barrierDismissible: true,
      textConfirm: "OK",
      buttonColor: tCardBgColor,
    );
  }

  /*List<Widget> generateSlider(SingleItemController cicontroller) {
    List<Widget> imageSliders = cicontroller.prdimglist.value.map((item) {
      return Container(
        child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: ImageByteWidget(
                  b64: item.toString(),
                  imgwid: 1000.0,
                  imght: 300.0,
                ))),
      );
    }).toList();
  }*/

  Padding buildItemQtyDetails(
      BuildContext context, SingleItemController curitmcontroller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text(
          'Order Details',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        children: [
          Card(
            elevation: 1.0,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50.0,
                          width: 175.0,
                          child: TextField(
                            decoration: InputDecoration(
                              labelText:
                                  'Stock (${curitmcontroller.getstkstr()})',
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              labelStyle: const TextStyle(
                                color: tAccentColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              alignLabelWithHint: false,
                              isDense: true,
                              hintText:
                                  'Stock (${curitmcontroller.getstkstr()})',
                            ),
                            cursorColor: tAccentColor,
                            controller: TextEditingController.fromValue(
                                TextEditingValue(
                                    text: curitmcontroller.itmmrpstk)),
                            enabled: false,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: tPrimaryColor),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        curitmcontroller.showbox == false
                            ? Expanded(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.remove_circle,
                                        size: 40,
                                      ),
                                      onPressed: () {
                                        curitmcontroller.remOrdQty();
                                      },
                                    ),
                                    Obx(() {
                                      return Text(
                                        curitmcontroller.ordqtystr.value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                color: tPrimaryColor,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                      );
                                    }),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.add_circle,
                                        size: 40,
                                      ),
                                      onPressed: () {
                                        curitmcontroller.addOrdQty();
                                      },
                                    )
                                  ]))
                            : const SizedBox()
                      ])),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50.0,
                          width: 200.0,
                          child: TextField(
                            decoration: InputDecoration(
                              labelText:
                                  'Rate (${curitmcontroller.setNetRate()})',
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              labelStyle: const TextStyle(
                                color: tAccentColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              alignLabelWithHint: false,
                              isDense: true,
                              hintText: '${curitmcontroller.setNetRate}',
                            ),
                            cursorColor: tAccentColor,
                            controller: TextEditingController.fromValue(
                                TextEditingValue(
                                    text: curitmcontroller.itmrate
                                        .toStringAsFixed(4),
                                    selection: TextSelection.collapsed(
                                        offset: curitmcontroller.itmrate
                                            .toStringAsFixed(4)
                                            .length))),
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            enabled: product.rate_editable,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: tPrimaryColor),
                            onSubmitted: (rattext) {
                              if (rattext.isEmpty) {
                                rattext = product.rate!.toStringAsFixed(4);
                              }
                              var rt = num.tryParse(rattext)?.toDouble();
                              //print(rt);
                              /*
                                setState(() {
                                  item.rate = double.parse(rattext);
                                  _itmrat = item.rate!.toStringAsFixed(4);
                                });
                                if (item.ord_qty! > 0) {
                                  getitmtotal(item);
                                }
                                */
                            },
                          ),
                        ),
                        Obx(() {
                          return Text(
                              curitmcontroller.itemnetamt.value
                                  .toStringAsFixed(2),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: tPrimaryColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                              textAlign: TextAlign.end);
                        }),
                      ])),
              curitmcontroller.showbox == true
                  ? buildBoxLooseExpansionTile(curitmcontroller)
                  : const SizedBox(),
              curitmcontroller.schp == true
                  ? buildSchemeCard(curitmcontroller, context)
                  : const SizedBox(),
              curitmcontroller.disp == true
                  ? Obx(() => buildDiscountCard(curitmcontroller, context))
                  : const SizedBox(),
            ]),
          )
        ],
      ),
    );
  }

  Padding buildDiscountCard(
      SingleItemController curitmcontroller, BuildContext context) {
    String tdiscp =
        curitmcontroller.itmdisp.value.toStringAsFixed(2).replaceAll('.00', '');
    String tdisca =
        curitmcontroller.itmdisa.value.toStringAsFixed(2).replaceAll('.00', '');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 75,
        child: Card(
          elevation: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Discount %'),
                  SizedBox(
                    width: 75,
                    height: 50,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      cursorColor: Colors.grey,
                      controller: TextEditingController.fromValue(
                          TextEditingValue(
                              text: tdiscp,
                              selection: TextSelection.collapsed(
                                  offset: tdiscp.length))),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: tPrimaryColor),
                      onChanged: (disptxt) {
                        if (disptxt.isEmpty) {
                          disptxt = '0';
                        }
                        double disp = double.parse(disptxt);
                        curitmcontroller.setDisP(disp);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text('Disc. Rs.'),
                  SizedBox(
                      width: 125,
                      height: 50,
                      child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          cursorColor: Colors.grey,
                          controller: TextEditingController.fromValue(
                              TextEditingValue(
                                  text: tdisca,
                                  selection: TextSelection.collapsed(
                                      offset: tdisca.length))),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: tPrimaryColor),
                          onChanged: (disatxt) {
                            if (disatxt.isEmpty) {
                              disatxt = '0';
                            }
                            double disa = double.parse(disatxt);
                            curitmcontroller.setDisA(disa);
                          })),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildSchemeCard(
      SingleItemController curitmcontroller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 75,
        child: Card(
          elevation: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Schm %'),
                  SizedBox(
                    width: 75,
                    height: 50,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      cursorColor: Colors.grey,
                      controller: TextEditingController.fromValue(
                          TextEditingValue(
                              text: curitmcontroller.itmschp.value
                                  .toStringAsFixed(2),
                              selection: TextSelection.collapsed(
                                  offset: curitmcontroller.itmschp.value
                                      .toStringAsFixed(2)
                                      .length))),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade900),
                      onChanged: (schptxt) {
                        if (schptxt.isEmpty) {
                          schptxt = '0';
                        }
                        double schpcn = double.parse(schptxt);
                        curitmcontroller.setSchP(schpcn);
                      },
                    ),
                  ),
                  const Text('Schm.Rs.'),
                  SizedBox(
                    width: 125,
                    height: 50,
                    child: Obx(() {
                      return TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          cursorColor: Colors.grey,
                          controller: TextEditingController.fromValue(
                              TextEditingValue(
                                  text: curitmcontroller.itmscha.value
                                      .toStringAsFixed(2),
                                  selection: TextSelection.collapsed(
                                      offset: curitmcontroller.itmscha.value
                                          .toStringAsFixed(2)
                                          .length))),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade900),
                          onChanged: (schatxt) {
                            if (schatxt.isEmpty) {
                              schatxt = '0';
                            }
                            double scha = double.parse(schatxt);
                            curitmcontroller.setSchA(scha);
                          });
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildOldSchemeCard(
      SingleItemController curitmcontroller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 75,
        child: Card(
          elevation: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Scheme %'),
                  SizedBox(
                    width: 75,
                    height: 50,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      cursorColor: tPrimaryColor,
                      controller: TextEditingController.fromValue(
                          TextEditingValue(
                              text: curitmcontroller.itmschp.value
                                  .toStringAsFixed(2),
                              selection: TextSelection.collapsed(
                                  offset: curitmcontroller.itmschp.value
                                      .toStringAsFixed(2)
                                      .length))),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: tPrimaryColor),
                      onChanged: (schptxt) {
                        double schp =
                            double.parse((schptxt.isEmpty) ? '0' : schptxt);
                        curitmcontroller.setSchP(schp);
                      },
                    ),
                  ),
                  const Text('Schm.Rs.'),
                  SizedBox(
                      child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          cursorColor: tPrimaryColor,
                          controller: TextEditingController.fromValue(
                              TextEditingValue(
                                  text: curitmcontroller.itmscha.value
                                      .toStringAsFixed(2),
                                  selection: TextSelection.collapsed(
                                      offset: curitmcontroller.itmscha.value
                                          .toStringAsFixed(2)
                                          .length))),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade900),
                          onChanged: (schatxt) {
                            if (schatxt.isEmpty) {
                              schatxt = '0';
                            }
                            double scha = double.parse(schatxt);
                            curitmcontroller.setSchA(scha);
                          }))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ExpansionTile buildBoxLooseExpansionTile(
      SingleItemController curitmcontroller) {
    return ExpansionTile(
      title: const Text('Box/Loose/Free'),
      initiallyExpanded: curitmcontroller.showbox,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Center(
                  child: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        curitmcontroller.showbox == true
                            ? SizedBox(
                                height: 50.0,
                                width: 80.0,
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText:
                                        'Box ${curitmcontroller.curitem.pkg.toString().replaceAll('.0', '')}',
                                    labelStyle: const TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    border: const OutlineInputBorder(),
                                    alignLabelWithHint: true,
                                    isDense: true,
                                  ),
                                  cursorColor: tAccentColor,
                                  enabled: curitmcontroller.showbox,
                                  controller: TextEditingController.fromValue(
                                      TextEditingValue(
                                          text: curitmcontroller.ordbox.value
                                              .toString(),
                                          selection: TextSelection.collapsed(
                                              offset: curitmcontroller
                                                  .ordbox.value
                                                  .toString()
                                                  .length))),
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: false),
                                  //textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blue.shade900),
                                  onChanged: (boxtext) {
                                    if (boxtext.isEmpty) {
                                      boxtext = '0';
                                    }
                                    int qb = int.parse(boxtext);
                                    curitmcontroller.setBoxQty(qb);
                                    /*
                                                setState(() {
                                                  item.ord_box_qty = int.parse(boxtext);
                                                  _itmbox = qb.toString();
                                                  gettotqty(item);
                                                  getitmtotal(item);
                                                });
                                                */
                                  },
                                  onSubmitted: (boxtext) {
                                    if (boxtext.isEmpty) {
                                      boxtext = '0';
                                    }
                                    int qb = int.parse(boxtext);
                                    curitmcontroller.setBoxQty(qb);
                                    /*
                                                setState(() {
                                                  item.ord_box_qty = int.parse(boxtext);
                                                  _itmbox = qb.toString();
                                                  gettotqty(item);
                                                  getitmtotal(item);
                                                  _showfiltitem = true;
                                                  getordtotal();
                                                  setfilter(_lstsrcstr);
                                                });
                                                */
                                  },
                                ),
                              )
                            : const Text(' '),
                        curitmcontroller.showinr == true
                            ? SizedBox(
                                height: 50.0,
                                width: 80.0,
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText:
                                        'Inr${curitmcontroller.curitem.inr_pkg.toString().replaceAll('.0', '')}',
                                    labelStyle: const TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    border: const OutlineInputBorder(),
                                    alignLabelWithHint: true,
                                    isDense: true,
                                  ),
                                  cursorColor: Colors.grey,
                                  controller: TextEditingController.fromValue(
                                      TextEditingValue(
                                          text: curitmcontroller.curitem.inr_pkg
                                              .toString(),
                                          selection: TextSelection.collapsed(
                                              offset: curitmcontroller
                                                  .curitem.inr_pkg
                                                  .toString()
                                                  .length))),
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: false),
                                  //textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blue.shade900),
                                  onChanged: (inrtext) {
                                    if (inrtext.isEmpty) {
                                      inrtext = '0';
                                    }
                                    int qi = int.parse(inrtext);
                                    curitmcontroller.setInrQty(qi);

                                    /*
                                                setState(() {
                                                  item.ord_inr_qty = int.parse(inrtext);
                                                  gettotqty(item);
                                                  getitmtotal(item);
                                                });
                                                */
                                  },
                                  onSubmitted: (inrtext) {
                                    if (inrtext.isEmpty) {
                                      inrtext = '0';
                                    }
                                    int qi = int.parse(inrtext);
                                    curitmcontroller.setInrQty(qi);
                                    /*setState(() {
                                                  item.ord_inr_qty = int.parse(inrtext);
                                                  gettotqty(item);
                                                  getitmtotal(item);
                                                  _showfiltitem = true;
                                                  getordtotal();
                                                });
                                                */
                                  },
                                ),
                              )
                            : const Text(' '),
                        curitmcontroller.showbox == true ||
                                curitmcontroller.showinr == true
                            ? SizedBox(
                                height: 50.0,
                                width: 80.0,
                                child: TextField(
                                  decoration: const InputDecoration(
                                    labelText: 'Loose',
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    border: OutlineInputBorder(),
                                    alignLabelWithHint: true,
                                    isDense: true,
                                  ),
                                  cursorColor: Colors.grey,
                                  enabled: (curitmcontroller.showbox == true ||
                                      curitmcontroller.showinr == true),
                                  controller: TextEditingController.fromValue(
                                      TextEditingValue(
                                          text: curitmcontroller.ordlos
                                              .toString(),
                                          selection: TextSelection.collapsed(
                                              offset: curitmcontroller.ordlos
                                                  .toString()
                                                  .length))),
                                  keyboardType: TextInputType.numberWithOptions(
                                      signed: true,
                                      decimal: curitmcontroller.hasdec),
                                  textInputAction: TextInputAction.done,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blue.shade900),
                                  /*onChanged: (lostext) {
                                              if (lostext.isEmpty || lostext == null) {
                                                  lostext = '0';
                                              }
                                            setState(() {
                                              _itmlos = lostext;
                                            });
                                          double qi = double.parse(lostext);
                                          setState(() {
                                            item.ord_los_qty =
                                                double.parse(lostext);
                                            gettotqty(item);
                                            getitmtotal(item);
                                          });

                                        },
                                        */
                                  onSubmitted: (lostext) {
                                    if (lostext.isEmpty) {
                                      lostext = '0';
                                    }
                                    double qi = double.parse(lostext.isEmpty
                                        ? "0"
                                        : lostext.toString());
                                    curitmcontroller.setLosQty(qi);
                                    /*setState(() {
                                                  item.ord_los_qty = double.parse(lostext);

                                                  gettotqty(item);
                                                  getitmtotal(item);
                                                  _showfiltitem = true;
                                                  getordtotal();
                                                  setfilter(_lstsrcstr);
                                                });
                                                */
                                  },
                                ),
                              )
                            : const Text(' '),
                        curitmcontroller.showfre == true
                            ? SizedBox(
                                height: 50.0,
                                width: 80.0,
                                child: TextField(
                                    decoration: const InputDecoration(
                                      labelText: 'Free',
                                      border: OutlineInputBorder(),
                                      labelStyle: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                      alignLabelWithHint: true,
                                      isDense: true,
                                    ),
                                    cursorColor: Colors.grey,
                                    controller: TextEditingController.fromValue(
                                        TextEditingValue(
                                            text: curitmcontroller.ordfre
                                                .toString(),
                                            selection: TextSelection.collapsed(
                                                offset: curitmcontroller.ordfre
                                                    .toString()
                                                    .length))),
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue.shade900),
                                    onChanged: (fretext) {
                                      if (fretext.isEmpty) {
                                        fretext = '0';
                                      }
                                      int qi = int.parse(fretext);
                                      curitmcontroller.setFreQty(qi);
                                      /*
                                                  setState(() {
                                                    item.ord_free_qty = double.parse(fretext);
                                                  });
                                                  */
                                    }),
                              )
                            : const Text(' '),
                      ],
                    ),
                  ),
                ),
              ],
            ))
      ],
    );
  }

  Padding buildProductFeatures(
      SingleItemController curitmcontroller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: ExpansionTile(
        initiallyExpanded: false,
        title: Text(
          'Features',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        children: [
          Text(curitmcontroller.itmfeature.value.toString(),
              maxLines: 20,
              softWrap: true,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade600)),
          /*
            product.feature.toString() != ''
            ? Marquee(
                child: Text(product.feature ?? '',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue.shade600)),
                          textDirection: TextDirection.rtl,
                          directionMarguee: DirectionMarguee.oneDirection,
                          animationDuration: Duration(seconds: 2),
                          backDuration: Duration(milliseconds: 5000),
                          //pauseDuration: Duration(milliseconds: 2500),
                          //scrollAxis: Axis.horizontal,
                        )
                  : Text('')
            */
        ],
      ),
    );
  }

  Padding buildProductInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: ExpansionTile(
          initiallyExpanded: false,
          title: Text(
            'Product Info',
            style: Theme.of(context).textTheme.bodyMedium,
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
                          'Company ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          product.company_nm!,
                          style: Theme.of(context).textTheme.bodyLarge,
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
                        'Brand ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        product.item_brand_nm!,
                        style: Theme.of(context).textTheme.bodyLarge,
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
                        'Category ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        product.item_cat_nm!,
                        style: Theme.of(context).textTheme.bodyLarge,
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
                        'Product code ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        product.item_code!,
                        style: Theme.of(context).textTheme.bodyLarge,
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
                          'Mrp Reference / Stock ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          '${product.mrp_ref} / ${product.stock_qty}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ]),
                ),
              ]),
            )
          ]),
    );
  }
  /*
  List<String> getprodimage(ItemModel prd) {
    List<String> imglst = [prd.item_image.toString().trim()];
    if (prd.item_image2.toString().trim().isNotEmpty) {
      imglst.add(prd.item_image2.toString());
    }
    if (prd.item_image3.toString().trim().isNotEmpty) {
      imglst.add(prd.item_image3.toString());
    }
    if (prd.item_image4.toString().trim().isNotEmpty) {
      imglst.add(prd.item_image4.toString());
    }
    if (prd.item_image5.toString().trim().isNotEmpty) {
      imglst.add(prd.item_image5.toString());
    }
    if (prd.item_image6.toString().trim().isNotEmpty) {
      imglst.add(prd.item_image6.toString());
    }
    if (prd.item_image7.toString().trim().isNotEmpty) {
      imglst.add(prd.item_image7.toString());
    }
    if (prd.item_image8.toString().trim().isNotEmpty) {
      imglst.add(prd.item_image8.toString());
    }
    if (prd.item_image9.toString().trim().isNotEmpty) {
      imglst.add(prd.item_image9.toString());
    }
    print('imglst len ${imglst.length}');
    return imglst;
  }
  */
}
