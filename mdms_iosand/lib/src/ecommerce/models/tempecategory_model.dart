import 'package:equatable/equatable.dart';

class PrdCategory extends Equatable {
  final String name;
  final String imageUrl;
  const PrdCategory({
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
        name,
        imageUrl,
      ];

  /*static Category fromSnapshot(DocumentSnapshot snap) {
    Category category = Category(
      name: snap['name'],
      imageUrl: snap['imageUrl'],
    );
    return category;
  }*/

  static List<PrdCategory> categories = [
    const PrdCategory(
      name: 'Mobiles',
      imageUrl:
          'https://images.unsplash.com/photo-1534057308991-b9b3a578f1b1?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80', //https://unsplash.com/photos/5lZhD2qQ2SE
    ),
    const PrdCategory(
      name: 'Tablets',
      imageUrl:
          'https://images.unsplash.com/photo-1502741224143-90386d7f8c82?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80', //https://unsplash.com/photos/m741tj4Cz7M
    ),
    const PrdCategory(
      name: 'Accesories',
      imageUrl:
          'https://images.unsplash.com/photo-1559839914-17aae19cec71?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80', //https://unsplash.com/photos/7Zlds3gm7NU
    ),
  ];
}