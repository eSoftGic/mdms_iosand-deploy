import '../../../../singletons/AppData.dart';

class AppUrl {
  static String? baseUrl = appData.baseurl;
  //static const String loginUrl = '$baseUrl/api/login';
  static String partyListUrl = '$baseUrl/party_list?';
  static String stockListUrl = '$baseUrl/stock?';
  static String ordersummaryListUrl = '$baseUrl/party_order_list?';
  static String bookListUrl = '$baseUrl/book?';
  static String cosListUrl = '$baseUrl/ac_mst_chain?';
  static String cmpListUrl = '$baseUrl/company?';
  static String itmListUrl = '$baseUrl/item_stock?';
  static String getqotnoUrl = '$baseUrl/Quot_New_Ref_No?';
  static String osListUrl = '$baseUrl/debtors_sumr?';

  // Party Options
  static String acmstdetailUrl = '$baseUrl/ac_mst_debtors?';
  static String acmstledgerUrl = '$baseUrl/genldgr_ac?';
  static String acmstosUrl = '$baseUrl/debtors?';
  static String acmstrcpUrl = '$baseUrl/chqcash_list?';
  static String acmstuncrnUrl = '$baseUrl/unadj_cr_note?';
  static String acmsthistoryUrl = '$baseUrl/party_order_item_history?';
  static String allocateUrl = '$baseUrl/stock_alloc_item_party_summary?';
  static String trackUrl = '$baseUrl/approval_log?';
}
