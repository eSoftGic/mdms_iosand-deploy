import 'package:get/get.dart';
import 'package:mdms_iosand/src/ecommerce/controller/cart_controller.dart';
import 'package:mdms_iosand/src/features/authentication/controllers/login_controller.dart';
//import 'package:mdms_iosand/temp/on_boarding_controller.dart';
import 'package:mdms_iosand/src/features/authentication/controllers/otp_controller.dart';
import 'package:mdms_iosand/src/features/authentication/controllers/signup_controller.dart';
import 'package:mdms_iosand/src/features/core/neworder/controller/controller_item.dart';
import 'package:mdms_iosand/src/features/core/neworder/controller/controller_order.dart';
import 'package:mdms_iosand/src/features/core/neworder/controller/controller_orderbasic.dart';
import 'package:mdms_iosand/src/features/core/neworder/controller/controller_orderitem.dart';

import 'package:mdms_iosand/src/features/core/screens/party/option/details/controller_option.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/ledger/controller_ledger.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/os/controller_os.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/uncrn/controller_uncrn.dart';

import 'package:mdms_iosand/src/repository/user_repository/user_repository.dart';
import '../features/core/screens/approval/controller_approvalhome.dart';
import '../features/core/neworder/controller/controller_orderedit.dart';
import '../features/core/screens/party/home_list/party_controller.dart';
import '../features/core/screens/party/option/rcp/controller_rcp.dart';
import '../features/core/screens/stock/stock_controller.dart';
import '../repository/authentication_repository/authentication_repository.dart';



class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthenticationRepository(), fenix: true);
    Get.lazyPut(() => UserRepository(), fenix: true);
    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => SignUpController(), fenix: true);
    Get.lazyPut(() => OTPController(), fenix: true);
    //Get.lazyPut(() => OnBoardingController(), fenix: true);

    Get.lazyPut(() => OrderController(), fenix: true);
    Get.lazyPut(() => StockController(), fenix: true);
    Get.lazyPut(() => PartyController(), fenix: true);
    Get.lazyPut(() => PartyOptionController(), fenix: true);
    Get.lazyPut(() => PartyLedgerController(), fenix: true);
    Get.lazyPut(() => PartyOsController(), fenix: true);
    Get.lazyPut(() => PartyRcpController(), fenix: true);
    Get.lazyPut(() => PartyUnCrnController(), fenix: true);

    Get.lazyPut(() => CartController(), fenix: true);
    Get.lazyPut(() => SingleItemController(), fenix: true);
    Get.lazyPut(() => OrderBasicController(), fenix: true);
    Get.lazyPut(() => OrderItemController(), fenix: true);
    Get.lazyPut(() => OrderEditController(), fenix: true);
    Get.lazyPut(() => ApprovalController(), fenix: true);
  }
}