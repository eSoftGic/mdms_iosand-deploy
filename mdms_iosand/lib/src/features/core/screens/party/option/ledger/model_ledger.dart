class LedgerModel {
  //Define
  final String? trandt;
  final String? trantype;
  final String? tranno;
  final String? descrem;
  final double? cramt;
  final double? dbamt;
  final double? balamt;
  final String? balcrdb;

  // Constructutor
  LedgerModel(
      {this.trandt,
      this.trantype,
      this.tranno,
      this.descrem,
      this.cramt,
      this.dbamt,
      this.balamt,
      this.balcrdb});

  //Maping
  factory LedgerModel.fromJson(Map<String, dynamic> json) {
    return LedgerModel(
        trandt: json['TRANDT'],
        trantype: json['TRANTYPE'],
        tranno: json['TRANNO'],
        descrem: json['DESCREM'],
        cramt: json['CRAMT'],
        dbamt: json['DBAMT'],
        balamt: json['BALAMT'],
        balcrdb: json['BALCRDB']);
  }
}