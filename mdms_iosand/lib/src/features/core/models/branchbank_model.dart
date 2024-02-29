class BankBranch {
  //Define
  final int? branchid;
  final String? branchnm;
  // Constructutor
  BankBranch({this.branchid, this.branchnm});
  //Maping
  factory BankBranch.fromJson(Map<String, dynamic> json) {
    return BankBranch(
        branchid: json['AC_BRANCH_ID'], branchnm: json["AC_BRANCH"]);
  }
}
