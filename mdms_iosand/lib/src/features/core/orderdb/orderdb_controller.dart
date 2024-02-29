// ignore_for_file: unnecessary_overrides
import 'package:get/get.dart';

class OrderDbController extends GetxController {
  var tabIndex = 0.obs;
  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
