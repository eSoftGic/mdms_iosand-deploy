// ignore_for_file: unrelated_type_equality_checks, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/ecommerce/widget/custom_appbar.dart';
import 'package:mdms_iosand/src/features/core/screens/prebook/add/controller_prebookcart.dart';
import 'package:mdms_iosand/src/features/core/screens/prebook/add/widget_prebookbasic.dart';
import 'package:mdms_iosand/src/features/core/screens/prebook/add/widget_prebookcartlist.dart';
import 'package:mdms_iosand/src/features/core/screens/prebook/add/widget_prebookitemlist.dart';
import '../home/screen_prebookhome.dart';
import 'controller_prebookbasic.dart';

class PreBookAddScreen extends StatefulWidget {
  const PreBookAddScreen({super.key});
  @override
  State<PreBookAddScreen> createState() => _PreBookAddScreenState();
}

class _PreBookAddScreenState extends State<PreBookAddScreen> {
  int _activeStepIndex = 0;
  final controller = Get.put(PreBookBasicController());
  final cartcontroller = Get.put(PreBookCartController());
  List<Step> stepList(BuildContext context) => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: Obx(() => Text(
                '${controller.acnm.value} [ Rs.${cartcontroller.ordtotstr} ]',
                style: Theme.of(context).textTheme.headlineSmall,
              )),
          content: PreBookBasic(context),
        ),
        Step(
          state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: Obx(() => Text(
                'Items ${cartcontroller.lislen}',
                style: Theme.of(context).textTheme.headlineSmall,
              )),
          content: PreBookItemSelect(),
        ),
        Step(
          state: StepState.complete,
          isActive: _activeStepIndex >= 2,
          title: Text(
            'Summary',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          content: PreBookTotal(),
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          isWishList: false,
          isCartList: false,
          title: controller.ordrefno.value == 0 ? 'NEW PRE BOOKING' : 'EDIT PREBOOK',
        ),
        body: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Obx(() {
              return Stepper(
                physics: const ClampingScrollPhysics(),
                type: StepperType.vertical,
                currentStep: _activeStepIndex,
                steps: stepList(context),
                controlsBuilder: (context, _) {
                  return Row(
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          if (_activeStepIndex < (stepList(context).length - 1)) {
                            if (controller.iscrdlimitover == false) {
                              setState(() {
                                _activeStepIndex += 1;
                              });
                            } else {
                              Get.snackbar(
                                  'Credit Alert',
                                  'Credit Limit Over for New '
                                      'Prebooking',
                                  snackPosition: SnackPosition.BOTTOM);
                            }
                          } else {
                            // Save Order
                            cartcontroller.saveOrder();
                            Get.delete<PreBookBasicController>(force: true);
                            Get.delete<PreBookCartController>(force: true);
                            Get.to(() => const PrebookHomeScreen());
                          }
                        },
                        child: (_activeStepIndex < (stepList(context).length - 1))
                            ? Text('NEXT', style: Theme.of(context).textTheme.headlineSmall)
                            : Text('SAVE PREBOOKING',
                                style: Theme.of(context).textTheme.headlineSmall),
                      ),
                      TextButton(
                        onPressed: () {
                          if (_activeStepIndex == 0) {
                            return;
                          }
                          setState(() {
                            _activeStepIndex -= 1;
                          });
                        },
                        child: (_activeStepIndex > 0)
                            ? Text('Previous', style: Theme.of(context).textTheme.headlineSmall)
                            : const SizedBox(),
                      ),
                    ],
                  );
                },
                onStepTapped: (int index) {
                  setState(() {
                    _activeStepIndex = index;
                  });
                },
              );
            }),
          )
        ]));
  }

  Widget PreBookBasic(BuildContext context) {
    return PreBookBasicFormWidget();
  }

  Widget PreBookItemSelect() {
    return controller.acid.value > 0 &&
            controller.iscrdlimitover.value == false &&
            controller.ordlimitvalid.value == true
        ? PreBookItemList(
            ordch: 'ADD',
          )
        : const Text('PreBook Basic Details Not Valid');
  }

  Widget PreBookTotal() {
    return const PreBookCartScreen();
  }

  @override
  void dispose() {
    //Get.delete<OrderBasicController>();
    //Get.delete<OrderCartController>();
    super.dispose();
  }
}