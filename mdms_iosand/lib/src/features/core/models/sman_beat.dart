class SmanBeat {
  final int? smanid;
  final String? forbeat;
  final String? tdt;
  final int? dmanid;
  final int? billissno;
  final String? forbukid;
  final bool? taxbeforescheme;
  final bool? showfree;
  final bool? showsch;
  final bool? showdisc;
  final bool? editrate;
  final String? forcomp;
  final String? announcemsg;

  SmanBeat(
      {this.smanid,
      this.forbeat,
      this.tdt,
      this.dmanid,
      this.billissno,
      this.forbukid,
      this.taxbeforescheme,
      this.showfree,
      this.showdisc,
      this.showsch,
      this.editrate,
      this.forcomp,
      this.announcemsg});

  factory SmanBeat.fromJson(Map<String, dynamic> json) {
    return SmanBeat(
        smanid: json['SMANID'],
        forbeat: json["FORBEAT"],
        tdt: json["TDT"],
        dmanid: json["DMANID"],
        billissno: json["BILL_ISS_NO"],
        forbukid: json['FORBOOK'],
        taxbeforescheme: json['TAX_BEFORE_SCHEME'],
        showfree: json['SHOW_FREE'],
        showsch: json['SHOW_SCH'],
        showdisc: json['SHOW_DISC'],
        editrate: json['EDIT_RATE'],
        forcomp: json['FORCOMPANY'],
        announcemsg: json['ANNOUNCE_MSG']);
  }
}
