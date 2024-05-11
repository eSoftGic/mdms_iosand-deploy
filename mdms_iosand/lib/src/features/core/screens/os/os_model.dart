// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class OsTotalModel extends Equatable {
  //Define
  final int? acid;
  final String? acnm;
  final double? posamt;
  final double? rcvamt;
  final int? posday;
  final int? posbil;
  final double? lgrbal;

  // Constructutor
  const OsTotalModel(
      {required this.acid,
      required this.acnm,
      required this.posamt,
      required this.rcvamt,
      required this.posday,
      required this.posbil,
      required this.lgrbal});

  //Maping
  factory OsTotalModel.fromJson(Map<String, dynamic> json) {
    return OsTotalModel(
        acid: json['AC_ID'],
        acnm: json['AC_NM'],
        posamt: json['OSAMT'],
        rcvamt: json['RCVAMT'],
        posday: json['OSDAYS'],
        posbil: json['OSBILLS'],
        lgrbal: json['LEDGER_BAL']);
  }

  @override
  List<Object?> get props =>
      [acid, acnm, posamt, rcvamt, posday, posbil, lgrbal];
}
