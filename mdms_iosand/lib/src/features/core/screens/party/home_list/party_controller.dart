// ignore_for_file: invalid_use_of_protected_member, non_constant_identifier_names, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/core/models/party/party_model.dart';
import 'package:unique_list/unique_list.dart';
import '../../../../../../singletons/singletons.dart';
import 'party_repository.dart';
import '../../../network/status.dart';

class PartyController extends GetxController {
  final _api = PartyRepository();

  List<PartyModel> _fullprtlist = <PartyModel>[];
  
  RxString error = ''.obs;
  final RxRequestStatus = Status.LOADING.obs;
  final searchtxt = TextEditingController();
  final prtlist = <PartyModel>[].obs;
  RxInt prtlen = 0.obs;
  RxInt filterlen = 0.obs;

  void setRxRequestStatus(Status value) => RxRequestStatus.value = value;

  void setFullPartyList(List<PartyModel> value) async {
    _fullprtlist = value.toList();
    prtlen.value = _fullprtlist.length;
    loadfiltervalues();
  }

  void setPartyList(List<PartyModel> value) {
    prtlist.value = value.toList();
    prtlen.value = prtlist.length;
  }

  void applyfilters(String text) async {
    List<PartyModel> prtfiltlist = _fullprtlist;
    if (text.isNotEmpty) {
      debugPrint(appSecure.namecontains.toString());
      debugPrint(text);

      if (appSecure.namecontains == true) {
        prtfiltlist = prtfiltlist.where((prt) {
          return prt.ac_nm!.toLowerCase().contains(text);
        }).toList();
      } else {
        prtfiltlist = prtfiltlist.where((prt) {
          return prt.ac_nm!.toLowerCase().startsWith(text, 0);
        }).toList();
      }
    }

    if (appData.filtbeat.isNotEmpty) {
      prtfiltlist = prtfiltlist.where((prt) {
        String betnm = prt.beatnm!;
        return appData.filtbeat.contains(betnm);
      }).toList();
    }

    if (appData.filtclass.isNotEmpty) {
      prtfiltlist = prtfiltlist.where((prt) {
        String clsnm = prt.classnm!;
        return appData.filtclass.contains(clsnm);
      }).toList();
    }

    if (appData.filttype.isNotEmpty) {
      prtfiltlist = prtfiltlist.where((prt) {
        String typenm = prt.typenm!;
        return appData.filttype.contains(typenm);
      }).toList();
    }

    prtlist.value = prtfiltlist;
    prtlen.value = prtlist.value.length;
  }

  void setError(String value) => error.value = value;
  /*
  List<String> setAllBeat() =>
      UniqueList<String>.from(prtlist.value.map((t) => t.beatnm!).toList());
  List<String> setAllClass() =>
      UniqueList<String>.from(prtlist.value.map((t) => t.classnm!).toList());
  List<String> setAllType() =>
      UniqueList<String>.from(prtlist.value.map((t) => t.typenm!).toList());
*/

  void partyListApi() {
    int acid = 0;
    print(appData.log_type);
    if (appData.log_type == 'PARTY') {
      acid = appData.prtid!;
      //print('dlr id' + appData.prtid!.toString());
    }
    _api.partyListApi(acid).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setFullPartyList(value);
      setPartyList(value);
    }).onError((error, stackTrace) {
      print(error.toString());
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshpartyListApi() {
    setRxRequestStatus(Status.LOADING);
    _api.partyListApi(0).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setFullPartyList(value);
      setPartyList(value);
      prtlen.value = value.length;
    }).onError((error, stackTrace) {
      print(error.toString());
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void loadfiltervalues() async {
    if (_fullprtlist.isNotEmpty) {
      appData.allbeat =
          UniqueList<String>.from(_fullprtlist.map((t) => t.beatnm!).toList());
      appData.allclass =
          UniqueList<String>.from(_fullprtlist.map((t) => t.classnm!).toList());
      appData.alltype =
          UniqueList<String>.from(_fullprtlist.map((t) => t.typenm!).toList());
    }
  }
}
