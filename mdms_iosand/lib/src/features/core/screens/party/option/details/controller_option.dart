// ignore_for_file: invalid_use_of_protected_member, unused_local_variable, non_constant_identifier_names, avoid_print

import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/details/repository_option.dart';
import '../../../../../../../singletons/AppData.dart';
import '../../../../network/status.dart';
import 'package:geolocator/geolocator.dart';
import 'model_acmstdetail.dart';

class PartyOptionController extends GetxController {
  final _api = PartyOptionRepository();
  RxInt prtlen = 0.obs;
  RxString error = ''.obs;
  String lat = '0';
  String lon = '0';

  final RxRequestStatus = Status.LOADING.obs;
  final prtrecord = <AcMstDetail>[].obs;
  late RxDouble ordlat = 0.0.obs;
  late RxDouble ordlon = 0.0.obs;
  late Position currentLocation;

  void setRxRequestStatus(Status value) => RxRequestStatus.value = value;
  void setAcMstList(List<AcMstDetail> value) {
    prtrecord.value = value.toList();
    prtlen.value = prtrecord.length;
    setLat(prtrecord.value[0].latitude!);
    setLon(prtrecord.value[0].longitude!);
    if (lat == '0.0' || lon == '0.0') {
      getloc();
    }
  }

  void setLat(double val) {
    lat = val.toString();
    print(lat);
  }

  void setLon(double val) {
    lon = val.toString();
    print(lon);
  }

  void getloc() async {
    currentLocation = await locateUser();
    ordlat.value = currentLocation.latitude;
    ordlon.value = currentLocation.longitude;
    appData.livlat = currentLocation.latitude.toString();
    appData.livlon = currentLocation.longitude.toString();
    setLat(currentLocation.latitude);
    setLon(currentLocation.longitude);
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
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  void acmstdetailApi(int acid) async {
    await _api.acmstApi(acid).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setAcMstList(value);
    }).onError((error, stackTrace) {
      print(error.toString());
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void setError(String value) => error.value = value;
}

/*void _updloc() async {

    if (ordlat.value != 0 && ordlon.value != 0) {
      String qryparam = "DbName=" +
          appData.log_dbnm! +
          "&ac_id=" +
          appData.prtid.toString() +
          "&Latitude=" +
          ordlat.value.toString() +
          "&Longitude=" +
          ordlon.value.toString();
       var result = await domstpost(appData.baseurl.toString() + "AC_MST_LatLong?" + qryparam);
      if (result.statusCode == 200) {
        setState(() {
          _updatestatus = "Location Updated";
        });
      } else {
        setState(() {
          _updatestatus = "Invalid Location";
        });
      }
    }
  }*/