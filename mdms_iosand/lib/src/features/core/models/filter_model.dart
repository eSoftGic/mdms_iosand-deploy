// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: true)
class FilterModel {
  //Define

  final String? company_nm;
  final String? item_cat_nm;
  final String? item_brand_nm;
  final String? item_nm;

  // Constructutor
  FilterModel({
    this.company_nm,
    this.item_cat_nm,
    this.item_brand_nm,
    this.item_nm,
  });

  //Maping
  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return FilterModel(
      company_nm: json['COMPANY_NM'],
      item_cat_nm: json['ITEM_CAT_NM'],
      item_brand_nm: json['ITEM_BRAND_NM'],
      item_nm: json['ITEM_NM'],
    );
  }
}
