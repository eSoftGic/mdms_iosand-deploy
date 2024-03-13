import 'package:flutter/material.dart';
import 'package:mdms_iosand/singletons/AppData.dart';

class DashboardCategoriesModel {
  final String menuname;
  final IconData icon;
  final int color;
  final bool enbl;
  final String heading;
  final String subHeading;
  final VoidCallback? onPress;

  DashboardCategoriesModel(
    this.menuname,
    this.heading,
    this.subHeading,
    this.icon,
    this.color,
    this.enbl,
    this.onPress,
  );

  static List<DashboardCategoriesModel> list = [
    DashboardCategoriesModel(
        "PRT", "Party", "", Icons.people, 0xff3399fe, true, null),
    DashboardCategoriesModel(
        "ORD", "Order", "", Icons.shopping_cart, 0xff622f74, true, null),
    DashboardCategoriesModel(
        "APR", "Approval", "", Icons.approval, 0xff622f74, true, null),
    DashboardCategoriesModel(
        "TRK", "Order Track", "", Icons.track_changes, 0xff5B8076, true, null),
    DashboardCategoriesModel(
        "STK", "Stock Listing", "", Icons.category, 0xffff3266, true, null),
    DashboardCategoriesModel("ALO", "Stock Allocation", "", Icons.assignment,
        0xff622f74, true, null),
    DashboardCategoriesModel(
        "PRB", "Pre Booking", "", Icons.star_border, 0xff26cb3c, true, null),
    DashboardCategoriesModel("OS", "OutStanding", "",
        Icons.pending_actions_outlined, 0xff26cb3c, true, null),

    /*
      DashboardCategoriesModel(
        "TRG", "Targets", "", Icons.show_chart, 0xffff5829, true, null),
    DashboardCategoriesModel(
        "DWN", "Download", "", Icons.download, 0xff5B8076, true, null),
    DashboardCategoriesModel(
        "GEO", "Geo Map", "", Icons.location_on_sharp, 0xff5B8076, true, null),
    DashboardCategoriesModel("SHP", "Track Shipment", "", Icons.local_shipping_outlined,0xff5B8076, true, null),
    DashboardCategoriesModel("ECO", "eComm", "", Icons.book_online, 0xff622f74, true, null),
    DashboardCategoriesModel("RCP", "Receipts", "", Icons.payment, 0xffff5829, true, null),
    DashboardCategoriesModel("QOT", "Qotation", "", Icons.request_quote, 0xff5B8076, true, null),
    DashboardCategoriesModel("DLV", "Delivery", "", Icons.airport_shuttle, 0xffeab676, true, null),
    */
  ];

  static List<DashboardCategoriesModel> prtlist = [
    DashboardCategoriesModel("PRT", appData.prtnm.toString().toUpperCase(), "",
        Icons.people, 0xff3399fe, true, null),
    DashboardCategoriesModel(
        "STK", "Stock Listing", "", Icons.category, 0xffff3266, true, null),
    DashboardCategoriesModel("ALO", "Stock Allocation", "", Icons.assignment,
        0xff622f74, true, null),
    DashboardCategoriesModel(
        "ORD", "Order", "", Icons.shopping_cart, 0xff622f74, true, null),
    DashboardCategoriesModel(
        "APR", "Approval", "", Icons.approval, 0xff622f74, true, null),
    DashboardCategoriesModel(
        "TRK", "Order Track", "", Icons.track_changes, 0xff5B8076, true, null),
    DashboardCategoriesModel(
        "PRB", "Pre Booking", "", Icons.star_border, 0xff26cb3c, true, null),
    DashboardCategoriesModel(
        "DWN", "Download", "", Icons.download, 0xff5B8076, true, null),
    DashboardCategoriesModel("OS", "OutStanding", "",
        Icons.pending_actions_outlined, 0xff26cb3c, true, null),

    /*
    DashboardCategoriesModel(
        "TRG", "Targets", "", Icons.show_chart, 0xffff5829, true, null),
    DashboardCategoriesModel(
        "GEO", "Geo Map", "", Icons.location_on_sharp, 0xff5B8076, true, null),
    DashboardCategoriesModel("SHP", "Track Shipment", "", Icons.local_shipping_outlined,0xff5B8076, true, null),
    DashboardCategoriesModel("ECO", "eComm", "", Icons.book_online, 0xff622f74, true, null),
    DashboardCategoriesModel("RCP", "Receipts", "", Icons.payment, 0xffff5829, true, null),
    DashboardCategoriesModel("QOT", "Qotation", "", Icons.request_quote, 0xff5B8076, true, null),
    DashboardCategoriesModel("DLV", "Delivery", "", Icons.airport_shuttle, 0xffeab676, true, null),
    */
  ];

  static List<DashboardCategoriesModel> prtmenulist = [
    /*DashboardCategoriesModel(
        "PDET", "Details", "", Icons.details, 0xff3399fe, true, null),*/
    DashboardCategoriesModel("PORD", "Order", "", Icons.shopping_bag_outlined,
        0xff3399fe, true, null),
    DashboardCategoriesModel(
        "PHIS", "History", "", Icons.history, 0xff3399fe, true, null),
    DashboardCategoriesModel(
        "POS", "O/S", "", Icons.list_alt_outlined, 0xff3399fe, true, null),
    DashboardCategoriesModel(
        "PGRL", "Ledger", "", Icons.category, 0xff3399fe, true, null),
    DashboardCategoriesModel("PALO", "Stock Allocation", "",
        Icons.assignment_ind_outlined, 0xff3399fe, true, null),
    DashboardCategoriesModel(
        "PRCP", "Receipts", "", Icons.receipt_outlined, 0xff3399fe, true, null),
    DashboardCategoriesModel("PUNCRN", "UnAdjusted CRN", "",
        Icons.pending_actions_outlined, 0xff3399fe, true, null),
  ];
}
