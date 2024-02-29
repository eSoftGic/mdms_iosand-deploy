class AppSecure {
  static final AppSecure _appSecure = AppSecure._internal();

  bool? taxbeforescheme;
  bool? showfree;
  bool? showsch;
  bool? showdisc;
  bool? editrate;
  bool? addac;
  bool? editac;
  bool? viewac;
  bool? addcasrcpt;
  bool? addchqrcpt;
  bool? addorder;
  bool? editorder;
  bool? showledger;
  bool? showos;
  bool? showstock;
  int? rtwithtax;
  bool? showcrnt;
  //bool? showstokupdate;
  //bool? showstokreturn;
  bool? shareos;
  bool? sharegrl;
  bool? shareord;
  bool? sharecrnt;
  bool? chklocation;
  String? itmsearchmethod;
  String? partysearchmethod;
  bool? noorderoption;
  bool? itemcontains;
  bool? namecontains;
  int? allowdistance;
  bool? showitemstock;
  bool? addqot;
  bool? editqot;
  bool? shareqot;
  bool? showqot;
  bool? showtarget;
  bool? showhistory;

  factory AppSecure() {
    return _appSecure;
  }
  AppSecure._internal();
}

final appSecure = AppSecure();