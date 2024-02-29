// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/constants.dart';

class ImageUrlWidget extends StatelessWidget {
  String imgurl;
  double imgwid;
  double imght;
  ImageUrlWidget({super.key, required this.imgurl, this.imgwid = 100, this.imght = 100});

  @override
  Widget build(BuildContext context) {
    bool hasimgUrl = imgurl.trim().isNotEmpty;
    return Container(
        margin: const EdgeInsets.only(right: 5, top: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Get.isDarkMode ? tCardLightColor : tCardBgColor),
        child: hasimgUrl
            ? Container(
                width: imgwid,
                height: imght,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(imgurl))),
                child: GestureDetector(
                  onTap: () async {
                    await showDialog(context: context, builder: (_) => zoomImage(imgurl));
                  },
                ))
            : Container(
                width: imgwid,
                height: imght,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                    image:
                        const DecorationImage(fit: BoxFit.cover, image: AssetImage(tNoImage))),
                child: GestureDetector(
                  onTap: () async {
                    await showDialog(context: context, builder: (_) => zoomImage(imgurl));
                  },
                )));
  }

  Widget zoomImage(String imgurl) {
    return Dialog(
      child: Container(
        width: 250,
        height: 250,
        decoration:
            BoxDecoration(image: DecorationImage(image: NetworkImage(imgurl), fit: BoxFit.cover)),
      ),
    );
  }
}