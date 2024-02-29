// ignore_for_file: non_constant_identifier_names

class AllocationModel {
  AllocationModel(
      {this.item_id,
      this.item_code,
      this.item_nm,
      this.ac_id,
      this.ac_nm,
      this.chain_id,
      this.area_nm,
      this.alloc_period_from,
      this.alloc_period_upto,
      this.allocated_qty,
      this.pend_order_qty,
      this.billed_qty,
      this.alloc_pend_qty});

  int? item_id;
  String? item_code;
  String? item_nm;
  int? ac_id;
  String? ac_nm;
  int? chain_id;
  String? area_nm;
  String? alloc_period_from;
  String? alloc_period_upto;
  double? allocated_qty;
  double? pend_order_qty;
  double? billed_qty;
  double? alloc_pend_qty;

  factory AllocationModel.fromJson(Map<String, dynamic> json) {
    return AllocationModel(
        item_id: json['ITEM_ID'] ?? 0,
        item_code: json['ITEM_CODE'] ?? '',
        item_nm: json['ITEM_NM'] ?? '',
        ac_id: json['AC_ID'] ?? '',
        ac_nm: json['AC_NM'] ?? '',
        chain_id: json['CHAIN_ID'] ?? 0,
        area_nm: json['AREA_NM'] ?? '',
        alloc_period_from: json['ALLOC_PERIOD_FROM'] ?? '',
        alloc_period_upto: json['ALLOC_PERIOD_UPTO'] ?? '',
        allocated_qty: json['ALLOCATED_QTY'] ?? 0.0,
        pend_order_qty: json['PEND_ORDER_QTY'] ?? 0.0,
        billed_qty: json['BILLED_QTY'] ?? 0.0,
        alloc_pend_qty: json['ALLOC_PEND_QTY'] ?? 0.0);
  }

  Map<String, dynamic> toJson() => {
        'item_id': item_id,
        'item_code': item_code,
        'item_nm': item_nm,
        'ac_id': ac_id,
        'ac_nm': ac_nm,
        'chain_id': chain_id,
        'area_nm': area_nm,
        'alloc_period_from': alloc_period_from,
        'alloc_period_upto': alloc_period_upto,
        'allocated_qty': allocated_qty,
        'pend_order_qty': pend_order_qty,
        'billed_qty': billed_qty,
        'alloc_pend_qty': alloc_pend_qty
      };

  String toStringView() {
    return '$item_nm'; // if you want to show id and speciality as string
  }

  /*@override
  List<Object?> get props => [
        item_id,
        item_code,
        item_nm,
        ac_id,
        ac_nm,
        chain_id,
        area_nm,
        alloc_period_from,
        alloc_period_upto,
        allocated_qty,
        pend_order_qty,
        billed_qty,
        alloc_pend_qty
      ];*/
}