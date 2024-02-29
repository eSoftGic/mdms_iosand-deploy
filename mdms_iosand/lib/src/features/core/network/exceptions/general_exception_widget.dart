import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/colors.dart';

class GeneralExceptionWidget extends StatefulWidget {
  final VoidCallback onPress;

  const GeneralExceptionWidget({super.key, required this.onPress});

  @override
  State<GeneralExceptionWidget> createState() => _GeneralExceptionWidgetState();
}

class _GeneralExceptionWidgetState extends State<GeneralExceptionWidget> {
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
              Icons.error,
              color: Colors.red,
              size: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Center(
                child: Text(
                  'General Exception Err.'.tr,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
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
                            .headlineSmall
                            ?.copyWith(color: tWhiteColor))),
              ),
            )
          ],
        ));
  }
}