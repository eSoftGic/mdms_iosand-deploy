class AppUser {
  //Define
  final int? userstatus;
  final String? usertype;
  final int? smanid;
  final int? acid;
  final int? dmanid;
  final bool? addac;
  final bool? editac;
  final bool? viewac;
  final bool? addcasrcpt;
  final bool? addchqrcpt;
  final bool? addorder;
  final bool? editorder;
  final bool? showledger;
  final bool? showos;
  final bool? showstock;
  final bool? showcrnt;
  final bool? shareord;
  final bool? shareos;
  final bool? sharegrl;
  final bool? sharecrnt;
  final bool? chklocation;
  final String? itmsearchmethod;
  final String? partysearchmethod;
  final bool? noorderoption;
  final int? allowlocdistance;
  final bool? showitemstock;
  final bool? commonorder;
  final bool? addqot;
  final bool? editqot;
  final bool? shareqot;
  final String? edmsport;
  final bool? showhistory;

  // Constructutor
  AppUser(
      {this.userstatus,
      this.usertype,
      this.smanid,
      this.acid,
      this.dmanid,
      this.addac,
      this.editac,
      this.viewac,
      this.addcasrcpt,
      this.addchqrcpt,
      this.addorder,
      this.editorder,
      this.showledger,
      this.showos,
      this.showstock,
      this.showcrnt,
      this.sharegrl,
      this.shareord,
      this.shareos,
      this.sharecrnt,
      this.chklocation,
      this.itmsearchmethod,
      this.partysearchmethod,
      this.noorderoption,
      this.allowlocdistance,
      this.showitemstock,
      this.commonorder,
      this.addqot,
      this.editqot,
      this.shareqot,
      this.edmsport,
      this.showhistory});

  //Maping
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      userstatus: json['UserStatus'],
      usertype: json['User_Type_Code'],
      smanid: json['Sman_Id'],
      acid: json['Ac_Id'],
      dmanid: json['Dman_Id'],
      addac: json['ADD_AC'],
      editac: json['EDIT_AC'],
      viewac: json['VIEW_AC'],
      addcasrcpt: json['ADD_CASH_RCPT'],
      addchqrcpt: json['ADD_CHQ_RCPT'],
      addorder: json['ADD_ORDER'],
      editorder: json['EDIT_ORDER'],
      showledger: json['SHOW_LEDGER'],
      showos: json['SHOW_OS'],
      showstock: json['SHOW_STOCK'],
      showcrnt: json['SHOW_UNADJ_CRNOTE'],
      shareord: json['SHARE_ORDER'],
      sharegrl: json['SHARE_LEDGER'],
      shareos: json['SHARE_OS'],
      sharecrnt: json['SHARE_UNADJ_CRNOTE'],
      chklocation: json['CHECK_LOCATION'] ?? false,
      itmsearchmethod: json['ITEM_SEARCH_METHOD'] ?? "CONTAINS",
      partysearchmethod: json['PARTY_SEARCH_METHOD'] ?? "CONTAINS",
      noorderoption: json['NO_ORDER_OPTION'] ?? false,
      allowlocdistance: json['ALLOW_PARTY_LOCATION_DIFF'] ?? 10,
      showitemstock: json['SHOW_STOCK_QTY'] ?? true,
      commonorder: json['COMMON_ORDER'] ?? false,
      addqot: json['ADD_QUOT'] ?? true,
      editqot: json['EDIT_QUOT'] ?? true,
      shareqot: json['SHARE_QUOT'] ?? true,
      edmsport: json['EDMS_PORT'] ?? '8090',
      showhistory: json['SHOW_HISTORY'] ?? true,
    );
  }
}