import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  //Define
  final String catnm;
  final int catid;
  final String catimage;
  const CategoryModel({required this.catnm, required this.catid, required this.catimage});

  //Maping
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      catnm: json['CATEGORY_NM'],
      catid: json["CATEGORY_ID"],
      catimage: json["CATEGORY_IMAGE"] ?? "",
    );
  }

  @override
  List<Object?> get props => [catnm, catimage, catid];

  static List<CategoryModel> prdcategories = [
    const CategoryModel(
      catid: 1,
      catnm: 'Mobiles',
      catimage:
          'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=580&q=80',
    ),
    const CategoryModel(
      catid: 2,
      catnm: 'Tablets',
      catimage:
          'https://images.unsplash.com/photo-1585790050230-5dd28404ccb9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1032&q=80',
    ),
    const CategoryModel(
      catid: 3,
      catnm: 'Accessories',
      catimage:
          'https://media.istockphoto.com/id/1156397327/photo/mobile-kit-with-smartphone-headphones-and-chargers.jpg?s=1024x1024&w=is&k=20&c=_TA9RXXnrwgH2w4qaLFmnUi9WGYTTbk2Esw1b-80jdw=',
    ),
  ];
}