import 'package:mdms_iosand/src/features/core/screens/prebook/home/model_prebook.dart';
import '../../../../../../singletons/AppData.dart';
import '../../../models/company_model.dart';
import '../../../network/app_url.dart';
import '../../../network/network_api_service.dart';
import '../../order/add_order/model_book.dart';
import '../../order/add_order/model_chain.dart';

class PreBookRepository {
  final _apiService = NetworkApiServices();

  Future<List<PreBookModel>> orderListApi(int acid) async {
    final String ordersummqryparam = "DbName=${appData.log_dbnm!}&AcId=${acid.toString().trim()}&chain_id=0&Branch_Id=${appData.log_branchid.toString().trim()}&SmanId=${appData.log_smanid.toString().trim()}&User_Type_Code=${appData.log_type.toString().trim()}&tran_type=PREBK&User_Type_Code=${appData.log_type.toString().trim()}";

    var ordlist = <PreBookModel>[];
    var resdata = await _apiService.getApi(AppUrl.ordersummaryListUrl + ordersummqryparam);
    if (resdata != null) {
      for (var ordjson in resdata) {
        ordlist.add(PreBookModel.fromJson(ordjson as Map<String, dynamic>));
      }
    }
    return ordlist;
  }

  Future<List<BookModel>> bookListApi(int acid) async {
    var qryparam = "DbName=${appData.log_dbnm!}&TRAN_TYPE=SAL&Branch_Id=${appData.log_branchid.toString().trim()}&ac_id=${acid.toString().trim()}&forcmp=${appData.log_smncomp.toString().trim()}&forbook=${appData.log_forbuk!}&ordtype=PREBK";

    var buklist = <BookModel>[];
    var resdata = await _apiService.getApi(AppUrl.bookListUrl + qryparam);
    if (resdata != null) {
      for (var bukjson in resdata) {
        buklist.add(BookModel.fromJson(bukjson as Map<String, dynamic>));
      }
    }
    return buklist;
  }

  Future<List<ChainModel>> cosListApi(int acid) async {
    var qryparam = "DbName=${appData.log_dbnm!}&acid=$acid&Branch_Id=${appData.log_branchid.toString().trim()}";

    var coslist = <ChainModel>[];
    var resdata = await _apiService.getApi(AppUrl.cosListUrl + qryparam);
    if (resdata != null) {
      for (var cosjson in resdata) {
        coslist.add(ChainModel.fromJson(cosjson as Map<String, dynamic>));
      }
    }
    return coslist;
  }

  Future<List<CompanyModel>> cmpListApi() async {
    var qryparam =
        "DbName=${appData.log_dbnm!}&Branch_Id=${appData.log_branchid.toString().trim()}";
    //print('buk cmp str ' + appData.bukcmpstr.toString());
    if (appData.bukcmpstr.toString().isNotEmpty) {
      qryparam += "&CmpStr=${appData.bukcmpstr.toString().trim()}";
    }
    var cmplist = <CompanyModel>[];
    var resdata = await _apiService.getApi(AppUrl.cmpListUrl + qryparam);

    if (resdata != null) {
      for (var cmpjson in resdata) {
        cmplist.add(CompanyModel.fromJson(cmpjson as Map<String, dynamic>));
      }
    }
    return cmplist;
  }
}