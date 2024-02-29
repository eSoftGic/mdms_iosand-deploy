// ignore_for_file: non_constant_identifier_names, invalid_use_of_protected_member, avoid_print

import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/core/screens/track/repository_track.dart';
import '../../network/status.dart';
import 'model_track.dart';
import 'package:intl/intl.dart';

class TrackController extends GetxController {
  final _api = TrackRepository();

  RxInt trklen = 0.obs;
  RxString error = ''.obs;
  final RxRequestStatus = Status.LOADING.obs;
  RxList<TrackModel> tracklist = <TrackModel>[].obs;
  var trkhdr = TrackHeader(
      trantype: '', ordno: '', chainnm: '', prtnm: '', usernm: '', netamt: 0, orddt: '');
  RxString trantype = 'ORD'.obs;
  RxString ordidstr = '0'.obs;
  RxList<Events> listOfEvents = <Events>[].obs;

  String getdmy(String dt) {
    //print(typ + '- ' + dt);
    if (dt == 'NA' || dt == '00:00:00') {
      return 'NA';
    }
    final datm = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(dt);
    String dat = '${datm.day}/${datm.month}/${datm.year}';
    String tim = '${datm.hour}:${datm.minute}:${datm.second}';
    if (tim == '0:0:0' || tim == '00:00:00') {
      return dat;
    } else {
      return '$dat $tim';
    }
  }

  TrackHeader getTrkHdr() {
    if (trklen.value > 0) {
      return TrackHeader(
          trantype: tracklist.value[0].tran_type.toString().trim(),
          ordno: tracklist.value[0].ref_no.toString().trim(),
          prtnm: tracklist.value[0].ac_nm.toString().trim(),
          usernm: tracklist.value[0].user_nm.toString().trim(),
          chainnm: tracklist.value[0].chain_area_nm.toString().trim(),
          netamt: double.parse(tracklist.value[0].net_amt.toString()),
          orddt: tracklist.value[0].ord_dt.toString().replaceAll('T00:00:00', '').trim());
    } else {
      return TrackHeader(
          trantype: '', ordno: '', chainnm: '', prtnm: '', usernm: '', netamt: 0, orddt: '');
    }
  }

  void setordIdstr(String val) {
    ordidstr.value = val.toString().trim();
  }

  void settrantype(String val) {
    trantype.value = val.toString().trim().toUpperCase();
  }

  void setRxRequestStatus(Status value) => RxRequestStatus.value = value;
  void settrackList(List<TrackModel> value) {
    value.sort((a, b) => a.tbl_id!.compareTo(b.tbl_id as num));

    tracklist.value = value.toList();
    trklen.value = tracklist.value.length;

    listOfEvents.clear();
    for (var element in tracklist.value) {
      String evnm =
          getevname(element.approval_type.toString(), element.approval_tran_type.toString());

      Events ev = Events(
          tblid: int.parse(element.tbl_id.toString()),
          atype: element.approval_type.toString(),
          astatus: element.approval_status.toString(),
          adate: getdmy(element.approval_date.toString()), // 'adate' + element.tbl_id.toString()),
          atrantype: element.approval_tran_type.toString(),
          orddesc: ('${element.tran_type}-${element.tran_desc}-${element.tran_no}'),
          orddt: getdmy(element.ord_dt.toString()), //, 'orddt ' + element.tbl_id.toString()),
          bildesc: ('${element.bill_tran_type}-${element.bill_tran_desc}-${element.bill_tran_no}'),
          bildt: getdmy(element.bill_tran_dt.toString()), //, 'biltrndt ' + element.tbl_id.toString
          usernm: element.user_nm.toString(),
          eventName: evnm.toString(),
          description: '',
          description2: '');
      listOfEvents.add(ev);
    }
  }

  String getevname(String aprtype, String aptrntype) {
    String retstr = 'ORDER';
    if (aptrntype == 'SAL') {
      if (aprtype == '') {
        retstr = 'BILLING';
      }
      if (aprtype == 'ACCOUNT') {
        retstr = 'FINANCE';
      }
      if (aprtype == 'LOGISTIC') {
        retstr = 'LOGISTIC';
      }
    }
    return retstr;
  }

  void trackApi() async {
    await _api.trackApi(trantype.value, ordidstr.value).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      settrackList(value);
    }).onError((error, stackTrace) {
      print(error.toString());
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void setError(String value) => error.value = value;
}

class Events {
  final int tblid;
  final String atype;
  final String astatus;
  final String adate;
  final String atrantype;
  final String orddesc;
  final String orddt;
  final String bildesc;
  final String bildt;
  final String usernm;
  final String eventName;
  final String description;
  final String description2;
  Events(
      {required this.tblid,
      required this.atype,
      required this.astatus,
      required this.adate,
      required this.atrantype,
      required this.orddesc,
      required this.orddt,
      required this.bildesc,
      required this.bildt,
      required this.usernm,
      required this.eventName,
      required this.description,
      required this.description2});
}

class TrackHeader {
  final String trantype;
  final String ordno;
  final String orddt;
  final String prtnm;
  final double netamt;
  final String chainnm;
  final String usernm;
  TrackHeader(
      {required this.trantype,
      required this.ordno,
      required this.orddt,
      required this.prtnm,
      required this.netamt,
      required this.chainnm,
      required this.usernm});
}