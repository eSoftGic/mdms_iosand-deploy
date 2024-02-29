import 'package:get/get.dart';

//import '../../features/core/screens/order/add_edit_order/model_item.dart';
import '../models/ecomm_model.dart';

class WishListController extends GetxController {
  List<ItemModel> wishlist = <ItemModel>[];
  RxInt lislen = 0.obs;

  void addtoWishlist(ItemModel value) async {
    wishlist.add(value);
    lislen.value = wishlist.length;
  }

  void removefromWishlist(ItemModel value) async {
    wishlist.remove(value);
    lislen.value = wishlist.length;
  }

  void clearWishlist() async {
    wishlist.clear();
    lislen.value = 0;
  }
}