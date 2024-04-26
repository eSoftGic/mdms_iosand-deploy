// ignore_for_file: unused_local_variable, non_constant_identifier_names, unused_import, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/common_widgets/appbar/appbar.dart';
import 'package:mdms_iosand/src/common_widgets/custom_shapes/curved_edge/curved_edges_widget.dart';
import 'package:mdms_iosand/src/constants/colors.dart';
import 'package:mdms_iosand/src/constants/image_strings.dart';
import 'package:mdms_iosand/src/features/core/neworder/controller/controller_cart.dart';
import 'package:mdms_iosand/src/features/core/neworder/controller/controller_item.dart';
import 'package:mdms_iosand/src/features/core/neworder/model/model_item.dart';
import 'package:mdms_iosand/src/features/core/screens/order/tproduct_card_vertical.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ItemModel product;

  @override
  Widget build(BuildContext context) {
    final curitmcontroller = Get.put(SingleItemController());
    final cartController = Get.put(OrderCartController());
    curitmcontroller.setcuritem(product);
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    bool hasimage = (product.item_image!.isNotEmpty);
    final String imageUrl = hasimage ? product.item_image! : tNoImage;

    return Scaffold(
      bottomNavigationBar:
          ProductBottomBar(isDark, curitmcontroller, cartController, context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TProductImageSlider(isDark: isDark),
            Padding(
              padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
              child: Column(children: [
                Text(
                  product.item_nm!,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: tPrimaryColor, fontWeight: FontWeight.w500),
                  softWrap: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                buildItemQtyDetails(context, curitmcontroller),
                buildProductInfo(context),
                buildProductFeatures(curitmcontroller, context)
              ]),
            )
          ],
        ),
      ),
    );
  }

  Container ProductBottomBar(bool isDark, SingleItemController curitmcontroller,
      OrderCartController cartController, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: isDark ? tCardDarkColor : tCardLightColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        TextButton(
          onPressed: () {
            if (curitmcontroller.curitem.ord_los_qty! > 0 ||
                curitmcontroller.curitem.ord_qty! > 0) {
              cartController.addtoCartlist(curitmcontroller.curitem);
              Get.back();
            } else {
              buildMsg('Order Qty Not Set', curitmcontroller.curitem.item_nm!,
                  Colors.red, tWhiteColor);
            }
          },
          child: Text(
            'Add To Order',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: tPrimaryColor, fontWeight: FontWeight.bold),
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
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: tPrimaryColor, fontWeight: FontWeight.bold),
          ),
        ),
      ]),
    );
  }

  Padding buildItemQtyDetails(
      BuildContext context, SingleItemController curitmcontroller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text(
          'Order Details',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        children: [
          Card(
            elevation: 0,
            borderOnForeground: false,
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
                                  'MRP - ${curitmcontroller.getstkstr()}',
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
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          children: [
            Card(
              elevation: 0.0,
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
}

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return CurvedEdgesWidget(
        child: Container(
      color: isDark ? tCardDarkColor : tCardLightColor,
      child: Stack(
        children: [
          // Main Image Large
          const SizedBox(
              height: 300,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: Image(image: AssetImage(tProfileImage))),
              )),
          // Image Slidder
          Positioned(
            right: 0,
            bottom: 30,
            left: 16,
            child: SizedBox(
              height: 75,
              child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemCount: 8,
                  itemBuilder: (_, __) => TRoundedImage(
                        width: 75,
                        backgroundColor:
                            isDark ? tCardDarkColor : tCardLightColor,
                        border: Border.all(
                            color: isDark ? tWhiteColor : tPrimaryColor),
                        padding: const EdgeInsets.all(4),
                        imageUrl: tNoImage,
                      )),
            ),
          ),
          TAppBar(
            showBackArrow: true,
            actions: [
              TCircularIcon(
                width: 32,
                height: 32,
                icon: Icons.shopping_basket_outlined,
                color: isDark ? tWhiteColor : tPrimaryColor,
              )
            ],
          )
        ],
      ),
    ));
  }
}
