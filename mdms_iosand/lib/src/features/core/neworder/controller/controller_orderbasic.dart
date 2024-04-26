// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, prefer_is_empty, avoid_function_literals_in_foreach_calls, dead_code, invalid_use_of_protected_member, avoid_print

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/singletons/singletons.dart';
import 'package:mdms_iosand/src/features/core/models/company_model.dart';







import 'package:mdms_iosand/src/features/core/models/party/party_model.dart';
import 'package:mdms_iosand/src/features/core/network/status.dart';
import 'package:mdms_iosand/src/features/core/neworder/controller/repository_order.dart';
import 'package:mdms_iosand/src/features/core/neworder/model/model_book.dart';
import 'package:mdms_iosand/src/features/core/neworder/model/model_chain.dart';
import 'package:mdms_iosand/src/features/core/neworder/model/model_quot.dart';
import 'package:mdms_iosand/src/features/core/screens/party/home_list/party_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class OrderBasicController extends GetxController {
  final RxRequestStatus = Status.LOADING.obs;
  RxString error = ''.obs;
  RxInt lislen = 0.obs;
  RxDouble ordlat = 0.0.obs;
  RxDouble ordlon = 0.0.obs;
  RxBool ordlimitvalid = false.obs;
  RxString buknm = ''.obs;
  RxString bukid = ''.obs;
  RxString bukcmpstr = ''.obs;
  RxDouble ordmaxlimit = 0.0.obs;
  RxString acnm = ''.obs;
  RxInt acid = 0.obs;
  RxBool todayorder = true.obs;
  RxBool iscrdlimitover = false.obs;
  RxInt chainid = 0.obs;
  RxString searchtext = "".obs;
  RxString chainareanm = "".obs;

  final _api = OrderRepository();
  final _prtapi = PartyRepository();

  final buklist = <BookModel>[].obs;
  final coslist = <ChainModel>[].obs;
  final cmplist = <CompanyModel>[].obs;
  final qotlist = <QotData>[].obs;
  final prtlist = <PartyModel>[].obs;

  List<String> company = <String>[];

  late Position currentLocation;

  double cdistance = 0.0;
  RxBool invaliddist = false.obs;
  double plat = 0.0;
  double plon = 0.0;

  late RxInt ordrefno = 0.obs;
  late String ordqottype = '';
  late bool istelephonicorder = false;
  var billdetails = '';
  var chainnm = '';
  var ordbilled = '';
  var approvalstatus = '';

  String curbk = '';
  double OrdLimit = 0.0;
  int bukosday = 0;
  int bukcrday = 0;
  String bukstday = '';
  int bukosbil = 0;
  int bukcrbil = 0;
  String bukstbil = '';
  double bukosrs = 0;
  double bukcrrs = 0;
  String bukstrs = '';
  bool bukhasord = false;
  String todayorddet = '';

  bool costore = false;
  String saletype = '';
  RxBool hascostores = false.obs;

  @override
  void onInit() async {
    super.onInit();
    OrdPartyListApi();
  }

  void getPermission() async {
    await Permission.location.request();
  }

  Future<Position> locateUser() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void setError(String _value) => error.value = _value;
  void setRxRequestStatus(Status _value) => RxRequestStatus.value = _value;
  void setAcid(int _value) => acid.value = _value;
  void setAcnm(String _value) => acnm.value = _value;
  void setBukid(String _value) => bukid.value = _value;
  void setBuknm(String _value) => buknm.value = _value;
  void setOrdrefno(int _value) => ordrefno.value = _value;
  void setSaleType(String _value) => saletype = _value;

  void setParty(String nm) async {
    setAcnm(nm);
    var selectprt = prtlist.where((prt) {
      return prt.ac_nm!.toLowerCase().trim() == nm.toLowerCase().trim();
    }).toList()[0];
    setAcid(selectprt.ac_id!.toInt());
    setSaleType(selectprt.sale_type.toString().trim());

    plat = double.tryParse(selectprt.prt_lat.toString()) ?? 0.0;
    plon = double.tryParse(selectprt.prt_lon.toString()) ?? 0.0;

    //getPermission();
    currentLocation = await locateUser();
    ordlat.value = currentLocation.latitude;
    ordlon.value = currentLocation.longitude;
    invaliddist.value = _checkforDistance();
    initorder(acid.value);
  }

  void initorder(int acid) async {
    ordrefno.value = 0;
    ordqottype = "ORD";
    istelephonicorder = false;
    setAcid(acid);
    setOrdrefno(0);
    BookListApi(acid);
    if (hascostores.value == true) {
      ChainOfStoresListApi();
    }
  }

  void setBookList(List<BookModel> _value) {
    buklist.value = _value.toList();
    if (buklist.length == 1) {
      setbukcmp(buklist[0].trandesc!.trim().toLowerCase());
    } else {
      setbukcmp("");
    }
    if (appData.chainofstores == true) {
      ChainOfStoresListApi();
    }
  }

  void BookListApi(int acid) async {
    await _api.bookListApi(acid).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setBookList(value);
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void setbukcmp(String bknm) async {
    if (buknm.toString().isEmpty && buklist.value.length > 0) {
      ordlimitvalid.value = true;
      buknm.value = buklist[0].trandesc!;
      bukid.value = buklist[0].trantypeid.toString();
      bukcmpstr.value = buklist[0].companysel!.toString();
      ordmaxlimit.value = buklist[0].maxordamt ?? 0.0;
    } else {
      buklist.forEach((f) {
        if (bknm.trim().toLowerCase() ==
            f.trandesc.toString().trim().toLowerCase()) {
          ordlimitvalid.value = true;
          buknm.value = f.trandesc!.toString();
          bukid.value = f.trantypeid.toString();
          bukcmpstr.value = f.companysel.toString().trim();
          ordmaxlimit.value = f.maxordamt!.toDouble();
          //print('selected ' + bknm + ' - ' + bukcmpstr.value.toString());
        }
      });
    }

    if (bukcmpstr.value.toString().trim().length > 0) {
      CompanyListApi();
      //fetchbrand
      //fetchcate
    }

    if (buknm.value.isNotEmpty && acid.value > 0) {
      loadcredit(buknm.value);
    }
  }

  void setCOSList(List<ChainModel> _value) {
    coslist.value = _value.toList();
  }

  void ChainOfStoresListApi() async {
    await _api.cosListApi(acid.value).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setCOSList(value);
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void setCompanyList(List<CompanyModel> _value) {
    cmplist.value = _value.toList();
  }

  void CompanyListApi() async {
    await _api.cmpListApi().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setCompanyList(value);
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void loadcredit(String bknm) async {
    //print('load credit ' + bknm);
    iscrdlimitover.value = false;
    OrdLimit = 0.0;
    bukosday = 0;
    bukcrday = 0;
    bukstday = '';
    bukosbil = 0;
    bukcrbil = 0;
    bukstbil = '';
    bukosrs = 0;
    bukcrrs = 0;
    bukstrs = '';
    iscrdlimitover.value = false;
    bukhasord = false;
    if (ordqottype == 'ORD') {
      buklist.forEach((f) {
        curbk = f.trandesc ?? "";
        if (curbk == bknm) {
          //appData.ordlimitvalid = true;
          //appData.ordmaxlimit = f.maxordamt ?? 0.0;
          //appData.ordlimitvalid = true;
          ordlimitvalid.value = true;
          ordmaxlimit.value = f.maxordamt ?? 0.0;
          ordlimitvalid.value = true;
          iscrdlimitover.value = false;
          OrdLimit = f.maxordamt ?? 0.0;
          bukosday = f.osdays!;
          bukcrday = f.crdays!;
          bukstday = f.osdays! - (f.crdays! > 0 ? f.crdays! : f.osdays!) > 0
              ? 'Over'
              : '';
          bukosbil = f.osbill!;
          bukcrbil = f.crbills!;
          bukstbil = f.osbill! - (f.crbills! > 0 ? f.crbills! : f.osbill!) > 0
              ? 'Over'
              : '';
          bukosrs = f.osamt!;
          bukcrrs = f.crrs!;
          bukstrs =
              f.osamt! - (f.crrs! > 0 ? f.crrs! : f.osamt!) > 0 ? 'Over' : '';
          if (bukstday.isNotEmpty ||
              bukstbil.length > 0 ||
              bukstrs.length > 0) {
            ordlimitvalid.value = false;
            iscrdlimitover.value = true;
          }
          bukhasord = false;
          todayorddet = f.todayorddet ?? '';
          if (todayorddet.isNotEmpty) {
            bukhasord = true;
          }
        }
      });
    }
  }

  void setTodayorder(bool _value) {
    todayorder.value = _value;
  }

  Future<void> OrdPartyListApi() async {
    if (appData.log_type == 'PARTY') {}
    await _prtapi.partyListApi(acid.value).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setOrdPartyList(value);
    }).onError((error, stackTrace) {
      print(error.toString());
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void setOrdPartyList(List<PartyModel> _value) {
    prtlist.value = _value.toList();
  }

  void setqotlist(List<QotData> _value) {
    qotlist.value = _value.toList();
  }

  void QotListApi() async {
    await _api.qotdatalist().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setqotlist(value);
    }).onError((error, stackTrace) {
      print(error.toString());
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  bool _checkforDistance() {
    cdistance = 0.0;
    if (appSecure.chklocation == true) {
      if (plat != 0.0 && plon != 0.0) {
        cdistance =
            Geolocator.distanceBetween(plat, plon, ordlat.value, ordlon.value);
      }
    }
    //print('curr distance :' + cdistance.toString());
    if (appSecure.chklocation == false) {
      return true;
    }
    if (cdistance == 0.0) {
      return true;
    }
    if (appSecure.allowdistance! == 0) {
      return true;
    }
    if (appData.prtlat == '0.0') {
      return true;
    }
    if (appData.prtlon == '0.0') {
      return true;
    }
    if (appData.prtlat == '0.0' && cdistance > 0) {
      return true;
    }
    if (cdistance > appSecure.allowdistance!) {
      return false;
      invaliddist.value = true;
    } else {
      return true;
    }
    update();
  }
}
