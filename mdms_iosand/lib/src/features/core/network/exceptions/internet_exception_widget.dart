import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';

class InternetExceptionWidget extends StatefulWidget {
  final VoidCallback onPress;

  const InternetExceptionWidget({super.key, required this.onPress});

  @override
  State<InternetExceptionWidget> createState() =>
      _InternetExceptionWidgetState();
}

class _InternetExceptionWidgetState extends State<InternetExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            const Icon(
              Icons.cloud_off,
              color: Colors.red,
              size: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Center(child: Text('internet_exp'.tr)),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: widget.onPress,
              child: Container(
                height: 44,
                width: 150,
                decoration: BoxDecoration(
                  color: tSecondaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                    child: Text('Retry',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: tWhiteColor))),
              ),
            )
          ],
        ));
  }
}