// ignore_for_file: non_constant_identifier_names, file_names

class AppData {
  static final AppData _appData = AppData._internal();
  // For Version check
  final String wdmsver = ''; //"""01/01/2024";
  final String mdmsver = ''; //01/01/2024";
  final String mdmsverno =
      '24.03.13'; // 24 is constant - only change mm.dd for year 2024
  String? log_ip;
  String? log_name;
  int? log_id;
  String? log_coid;
  String? log_conm;
  String? log_coyr;
  String? log_dbnm;
  String? log_branch;
  int? log_branchid;
  String? log_deviceid;
  String? log_type;
  int? log_smanid;
  int? log_prtid;
  int? log_dlrid;
  String? log_prtqry;
  String? log_smnbeat;
  String? baseurl;
  String? deliveryurl;
  String? edmsport;
  String? edmsurl;
  bool? demover;
  String? demoupto;
  String? log_pwd;
  int? log_dmanid;
  String? log_smncomp;
  String? log_forbuk;
  String? pdfbaseurl;
  String? cologo = "";
  String? announcemsg = "";

  // For Target
  bool? ispartytrgt = false;
  int? partytrgtid = 0;
  String? trgtsubtit = "";

  // For Order
  int? prtid;
  String? prtnm;
  int? ordrefno;
  String? saletype; // IntraState / InterState
  int? bukid;
  String? buknm;
  String? bukcmpstr = '';
  String? billdetails;
  String? ordbilled;
  String? ordlat;
  String? ordlon;
  bool? chainofstores;
  bool? commonorder;
  String? approvalstatus;
  int? chainid;
  String? chainnm;
  double? ordmaxlimit;
  bool? ordlimitvalid;
  String? orddt;
  String? ordnet;
  // For Quotation
  String? qotprtnm;
  String? qotprtadd;
  String? qotprtcity;
  String? qotprtmob;
  String? qotprtgst;
  String? qotprtemail;
  int? qotprtmstid;
  int? qotno;
  String? ordqottype; // Order / Quot

  // For Delivery
  int? dlvref_no;
  int? dlvtran_type_id;
  String? dlvtran_desc;
  String? dlvtran_no;
  String? dlvtran_dt;
  String? dlvord_dt;
  double? dlvnet_amt;
  int? dlvac_id;
  String? dlvac_nm;
  int? dlvchain_id;
  String? dlvchain_area_nm;
  String? dlvdelivered;
  String? dlvitem_detail;
  String? dlvsale_type;

  // For Receipts
  String? prtbnknm;
  String? prtbrnnm;
  int? prtbnkid;
  int? prtbrnid;
  int? prtrcpno;
  int? prtrcpref;
  String? prtrcpchqdt;
  String? prtrcpmode;
  String? prtrcpchqno;
  double? prtrcpamt;

  // For Location
  String? currgeolat;
  String? currgeolon;
  String? prtlat;
  String? prtlon;
  String? cuurgeoaddress;
  String? newDb = "N";
  String? livlat;
  String? livlon;

  //  For Telephonic Order
  bool? allowteleorder = true;
  bool? istelephonicorder = false;
  String teleordefrom = '08:00PM';
  String teleorderupto = '11:00PM';

  //Ac Dates;
  String? acstdt;
  String? acendt;
  String? acmxdt;

  // Bill Issue Collection
  int? billissno = 0;

  // Acmaster AddEdit
  int? acmstid = 0;
  String? acmstnm = '';

  // Stock filter
  bool? applystkfilter = false;

  // Order Filters
  List<String> company = <String>[];
  List<String> allcompany = <String>[];

  /*
  IEnumerable<String> allcomp;
  IEnumerable<String> allbrand;
  IEnumerable<String> allcategory;
  IEnumerable<String> allbeat;
  IEnumerable<String> allclass;
  IEnumerable<String> alltype;
  */

  List<String> allcomp = <String>[];
  List<String> allbrand = <String>[];
  List<String> allcategory = <String>[];
  List<String> allbeat = <String>[];
  List<String> allclass = <String>[];
  List<String> alltype = <String>[];
  List<String> filtcompany = <String>[];
  List<String> filtbrand = <String>[];
  List<String> filtcategory = <String>[];
  List<String> filtbeat = <String>[];
  List<String> filtclass = <String>[];
  List<String> filttype = <String>[];
  List<String> filtord = <String>['ALL', 'ORDER', 'PENDING', 'NO ORDER'];
  String? filtordnm = 'ALL';
  bool sortbyroute = false;

  factory AppData() {
    return _appData;
  }
  AppData._internal();
}

final appData = AppData();
