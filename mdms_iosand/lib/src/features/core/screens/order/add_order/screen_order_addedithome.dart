// ignore_for_file: unrelated_type_equality_checks, avoid_print, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/constants/colors.dart';
import 'package:mdms_iosand/src/ecommerce/widget/custom_appbar.dart';
import 'package:mdms_iosand/src/features/core/orderdb/orderhome.dart';
import 'package:mdms_iosand/src/features/core/screens/order/add_order/widgets/controller_cart.dart';
import 'package:mdms_iosand/src/features/core/screens/order/add_order/widgets/controller_orderbasic.dart';
import 'package:mdms_iosand/src/features/core/screens/order/add_order/widgets/widget_orderbasic.dart';
import 'package:mdms_iosand/src/features/core/screens/order/add_order/widgets/widget_ordercartlist.dart';
import 'package:mdms_iosand/src/features/core/screens/order/add_order/widgets/widget_orderitemlist.dart';
//import 'package:mdms_iosand/src/features/core/screens/order/screen_orderhome.dart';

class AddOrderHomeScreen extends StatefulWidget {
  const AddOrderHomeScreen({super.key});
  @override
  State<AddOrderHomeScreen> createState() => _AddOrderHomeScreenState();
}

class _AddOrderHomeScreenState extends State<AddOrderHomeScreen> {
  int _activeStepIndex = 0;
  int curacid = 0;
  final controller = Get.put(OrderBasicController());
  final cartcontroller = Get.put(OrderCartController());

  List<Step> stepList(BuildContext context) => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: Obx(() => Text(
                '${controller.acnm.value} [ Rs.${cartcontroller.ordtotstr} ]',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: tCardBgColor),
              )),
          content: OrderBasic(context),
        ),
        Step(
          state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: Obx(() => Text(
                'Order Items ${cartcontroller.lislen.value}',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: tAccentColor),
              )),
          content: OrderItemSelect(),
        ),
        Step(
          state: StepState.complete,
          isActive: _activeStepIndex >= 2,
          title: Text(
            'Order Summary',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: tAccentColor),
          ),
          content: OrderTotal(),
        ),
      ];

  @override
  void initState() {
    controller.initorder(0);
    cartcontroller.clearCartlist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          isWishList: false,
          isCartList: controller.ordrefno.value == 0 ? false : true,
          title: controller.ordrefno.value == 0 ? 'NEW ORDER' : 'EDIT ORDER',
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
                          if (_activeStepIndex <
                              (stepList(context).length - 1)) {
                            //if (controller.iscrdlimitover == false) {
                            setState(() {
                              curacid = controller.acid.value;
                              debugPrint('curacid $curacid');
                              _activeStepIndex += 1;
                            });
                            //} else {
                            //  Get.snackbar('Credit Alert',
                            //      'Credit Limit Over for New Order',
                            //      snackPosition: SnackPosition.BOTTOM);
                            //}
                          } else {
                            // Save Order
                            cartcontroller.saveOrder();
                            Get.delete<OrderBasicController>(force: true);
                            Get.delete<OrderCartController>(force: true);
                            //Get.to(() => const OrderHomeScreen());
                            Get.to(() => const OrderHomeView());
                          }
                        },
                        child: (_activeStepIndex <
                                (stepList(context).length - 1))
                            ? Text('NEXT',
                                style: Theme.of(context).textTheme.bodyMedium)
                            : Text('SAVE ORDER',
                                style: Theme.of(context).textTheme.bodyMedium),
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
                            ? Text('Previous',
                                style: Theme.of(context).textTheme.bodyMedium)
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

  Widget OrderBasic(BuildContext context) {
    return OrderBasicFormWidget();
  }

  Widget OrderItemSelect() {
    /*debugPrint('OrderItemSelect ${controller.acid.value}');
    return controller.acid.value > 0 &&
            controller.iscrdlimitover.value == false &&
            controller.ordlimitvalid.value == true
        ? OrderItemList(ordch: 'ADD')
        : const Text('Order Party or Credit Details Not Valid');
    */
    return controller.acid.value > 0
        ? OrderItemList(ordch: 'ADD')
        : const Text('Order Party Not properly selected');
  }

  Widget OrderTotal() {
    //debugPrint('Going for Order total');
    return const OrderCartScreen();
  }

  @override
  void dispose() {
    //Get.delete<OrderBasicController>();
    Get.delete<OrderCartController>();
    super.dispose();
  }
}
