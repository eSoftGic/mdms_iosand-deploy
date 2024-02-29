import 'package:equatable/equatable.dart';
import 'ecomm_model.dart';

class WishList extends Equatable {
  final List<Product> wishproducts;
  const WishList({this.wishproducts = const <Product>[]});
  @override
  List<Object?> get props => [wishproducts];
}