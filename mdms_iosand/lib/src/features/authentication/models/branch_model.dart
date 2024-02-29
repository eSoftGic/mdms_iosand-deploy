class Branch {
  //Define
  final int? branchid;
  final String? brnachnm;
  final String? usertype;
  final int? usertypeid; // this is smanid, delmid, prtid
  // Constructutor
  Branch({this.branchid, this.brnachnm, this.usertype, this.usertypeid});
  //Maping
  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
        branchid: json['BRANCH_ID'],
        brnachnm: json["BRANCH_NM"],
        usertype: json["USERTYPE"],
        usertypeid: json["USERTYPEID"]);
  }
}