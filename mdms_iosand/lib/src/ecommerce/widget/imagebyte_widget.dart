// ignore_for_file: must_be_immutable, unused_local_variable, avoid_unnecessary_containers

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../constants/constants.dart';

class ImageByteWidget extends StatelessWidget {
  String b64;
  double imgwid;
  double imght;

  ImageByteWidget({super.key, required this.b64, this.imgwid = 100, this.imght = 100});
  @override
  Widget build(BuildContext context) {
    DecorationImage? decorationImage;
    Uint8List bytesImage = const Base64Decoder().convert(b64);
    bool hasimgByte = b64.isNotEmpty;

    return Container(
        margin: const EdgeInsets.only(right: 5, top: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: tCardLightColor,
        ),
        child: hasimgByte
            ? GestureDetector(
                onTap: () async {
                  await showDialog(context: context, builder: (_) => zoomImage(bytesImage));
                },
                child: Container(
                    child: Image.memory(
                  bytesImage,
                  width: imgwid,
                  height: imght,
                  fit: BoxFit.cover,
                )))
            : SizedBox(width: imgwid, height: imght));
  }

  Widget zoomImage(Uint8List bytesImage) {
    return Dialog(
      child: Container(child: Image.memory(bytesImage, width: 250, height: 250)),
    );
  }
}