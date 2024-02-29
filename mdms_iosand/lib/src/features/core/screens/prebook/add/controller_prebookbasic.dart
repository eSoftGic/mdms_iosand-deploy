// ignore_for_file: unused_local_variable, invalid_use_of_protected_member, dead_code, non_constant_identifier_names, avoid_print

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/core/models/party/party_model.dart';
import 'package:mdms_iosand/src/features/core/screens/prebook/home/repository_prebook.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../singletons/AppData.dart';
import '../../../../../../singletons/appsecure.dart';
import '../../../models/company_model.dart';
import '../../../network/status.dart';
import '../../order/add_order/model_book.dart';
import '../../order/add_order/model_chain.dart';
import '../../party/home_list/party_repository.dart';

class PreBookBasicController extends GetxController {
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

  final _api = PreBookRepository();
  final _prtapi = PartyRepository();

  final buklist = <BookModel>[].obs;
  final coslist = <ChainModel>[].obs;
  final cmplist = <CompanyModel>[].obs;
  final prtlist = <PartyModel>[].obs;
  List<String> company = <String>[];

  late Position currentLocation;

  double cdistance = 0.0;
  RxBool invaliddist = false.obs;
  double plat = 0.0;
  double plon = 0.0;

  late RxInt ordrefno = 0.obs;
  String ordqottype = 'PREBK';
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
  String chainareanm = '';
  bool costore = false;
  String saletype = '';
  bool hascostores = false;

  @override
  void onInit() async {
    super.onInit();
    OrdPartyListApi();
  }

  void getPermission() async {
    await Permission.location.request();
  }

  Future<Position> locateUser() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
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
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  void setError(String value) => error.value = value;
  void setRxRequestStatus(Status value) => RxRequestStatus.value = value;
  void setAcid(int value) => acid.value = value;
  void setAcnm(String value) => acnm.value = value;
  void setBukid(String value) => bukid.value = value;
  void setBuknm(String value) => buknm.value = value;
  void setOrdrefno(int value) => ordrefno.value = value;
  void setSaleType(String value) => saletype = value;

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
    BookListApi(acid);
    if (hascostores == true) {
      ChainOfStoresListApi();
    }
  }

  void setBookList(List<BookModel> value) {
    buklist.value = value.toList();
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
      print(error.toString());
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void setbukcmp(String bknm) async {
    if (buknm.toString().isEmpty && buklist.value.isNotEmpty) {
      ordlimitvalid.value = true;
      buknm.value = buklist[0].trandesc!;
      bukid.value = buklist[0].trantypeid.toString();
      bukcmpstr.value = buklist[0].companysel!.toString();
      ordmaxlimit.value = buklist[0].maxordamt ?? 0.0;
    } else {
      for (var f in buklist) {
        if (bknm.trim().toLowerCase() == f.trandesc.toString().trim().toLowerCase()) {
          ordlimitvalid.value = true;
          buknm.value = f.trandesc!.toString();
          bukid.value = f.trantypeid.toString();
          bukcmpstr.value = f.companysel.toString().trim();
          ordmaxlimit.value = f.maxordamt!.toDouble();
          //print('selected ' + bknm + ' - ' + bukcmpstr.value.toString());
        }
      }
    }

    if (bukcmpstr.value.toString().trim().isNotEmpty) {
      CompanyListApi();
      //fetchbrand
      //fetchcate
    }

    if (buknm.value.isNotEmpty && acid.value > 0) {
      loadcredit(buknm.value);
    }
  }

  void setCOSList(List<ChainModel> value) {
    coslist.value = value.toList();
  }

  void ChainOfStoresListApi() async {
    await _api.cosListApi(acid.value).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setCOSList(value);
    }).onError((error, stackTrace) {
      print(error.toString());
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void setCompanyList(List<CompanyModel> value) {
    cmplist.value = value.toList();
  }

  void CompanyListApi() async {
    await _api.cmpListApi().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setCompanyList(value);
    }).onError((error, stackTrace) {
      print(error.toString());
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
      for (var f in buklist) {
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
          bukstday = f.osdays! - (f.crdays! > 0 ? f.crdays! : f.osdays!) > 0 ? 'Over' : '';
          bukosbil = f.osbill!;
          bukcrbil = f.crbills!;
          bukstbil = f.osbill! - (f.crbills! > 0 ? f.crbills! : f.osbill!) > 0 ? 'Over' : '';
          bukosrs = f.osamt!;
          bukcrrs = f.crrs!;
          bukstrs = f.osamt! - (f.crrs! > 0 ? f.crrs! : f.osamt!) > 0 ? 'Over' : '';
          if (bukstday.isNotEmpty || bukstbil.isNotEmpty || bukstrs.isNotEmpty) {
            ordlimitvalid.value = false;
            iscrdlimitover.value = true;
          }
          bukhasord = false;
          todayorddet = f.todayorddet ?? '';
          if (todayorddet.isNotEmpty) {
            bukhasord = true;
          }
        }
      }
    }
  }

  void setTodayorder(bool value) {
    todayorder.value = value;
  }

  Future<void> OrdPartyListApi() async {
    await _prtapi.partyListApi(acid.value).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setOrdPartyList(value);
    }).onError((error, stackTrace) {
      print(error.toString());
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void setOrdPartyList(List<PartyModel> value) {
    prtlist.value = value.toList();
  }

  bool _checkforDistance() {
    cdistance = 0.0;
    if (appSecure.chklocation == true) {
      if (plat != 0.0 && plon != 0.0) {
        cdistance = Geolocator.distanceBetween(plat, plon, ordlat.value, ordlon.value);
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