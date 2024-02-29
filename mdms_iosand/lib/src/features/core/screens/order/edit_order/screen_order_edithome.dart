// ignore_for_file: prefer_interpolation_to_compose_strings, unrelated_type_equality_checks, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../ecommerce/widget/custom_appbar.dart';
import '../add_order/widgets/controller_cart.dart';
import '../add_order/widgets/widget_ordercartlist.dart';
import '../add_order/widgets/widget_orderitemlist.dart';
import '../screen_orderhome.dart';
import 'controller_orderedit.dart';

class EditOrderScreen extends StatefulWidget {
  const EditOrderScreen({super.key});

  @override
  State<EditOrderScreen> createState() => _EditOrderScreenState();
}

class _EditOrderScreenState extends State<EditOrderScreen> {
  final editcontroller = Get.put(OrderEditController());
  final cartcontroller = Get.put(OrderCartController());

  List<Step> stepList(BuildContext context) => [
        Step(
          state: editcontroller.activeStepIndex.value <= 0
              ? StepState.editing
              : StepState.complete,
          isActive: editcontroller.activeStepIndex.value >= 0,
          title: Obx(() => Text(
                '${editcontroller.acnm.value} [ Rs.${cartcontroller.ordtotstr.value} ]',
                style: Theme.of(context).textTheme.headlineSmall,
              )),
          content: OrderEditBasic(context),
        ),
        Step(
          state: editcontroller.activeStepIndex.value <= 1
              ? StepState.editing
              : StepState.complete,
          isActive: editcontroller.activeStepIndex.value >= 1,
          title: Obx(() => Text(
                'Items ${cartcontroller.lislen.value.toString()}',
                style: Theme.of(context).textTheme.headlineSmall,
              )),
          content: OrderItemSelect(),
        ),
        Step(
          state: StepState.complete,
          isActive: editcontroller.activeStepIndex.value >= 2,
          title: Text(
            'Summary',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          content: OrderTotal(),
        ),
      ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          isWishList: false,
          isCartList: true,
          title: 'EDIT ORDER ' + editcontroller.ordrefno.value.toString(),
        ),
        body: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Obx(() {
              return Stepper(
                physics: const ClampingScrollPhysics(),
                type: StepperType.vertical,
                currentStep: editcontroller.activeStepIndex.value,
                steps: stepList(context),
                controlsBuilder: (context, _) {
                  return Row(
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          if (editcontroller.activeStepIndex.value <
                              (stepList(context).length - 1)) {
                            if (editcontroller.iscrdlimitover == false) {
                              //setState(() {
                              editcontroller.activeStepIndex.value += 1;
                              //});
                            } else {
                              Get.snackbar('Credit Alert',
                                  'Credit Limit Over for New Order',
                                  snackPosition: SnackPosition.BOTTOM);
                            }
                          } else {
                            // Save Order
                            cartcontroller.saveOrder();
                            Get.snackbar('Order', 'Succesfull',
                                snackPosition: SnackPosition.BOTTOM);
                            Get.to(() => const OrderHomeScreen());
                          }
                        },
                        child: (editcontroller.activeStepIndex.value <
                                (stepList(context).length - 1))
                            ? Text('NEXT',
                                style:
                                    Theme.of(context).textTheme.headlineSmall)
                            : Text('SAVE ORDER',
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                      ),
                      TextButton(
                        onPressed: () {
                          if (editcontroller.activeStepIndex.value == 0) {
                            return;
                          }
                          //setState(() {
                          editcontroller.activeStepIndex.value -= 1;
                          //});
                        },
                        child: (editcontroller.activeStepIndex.value > 0)
                            ? Text('Previous',
                                style:
                                    Theme.of(context).textTheme.headlineSmall)
                            : const SizedBox(),
                      ),
                    ],
                  );
                },
                onStepTapped: (int index) {
                  editcontroller.activeStepIndex.value = index;
                },
              );
            }),
          )
        ]));
  }

  Widget OrderEditBasic(BuildContext context) {
    return Card(
      elevation: 8,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Order # ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(editcontroller.ordrefno.value.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(
                width: 5,
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Book Name # ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(editcontroller.buknm.value.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(
                width: 5,
              ),
            ]),
          ]),
    );
  }

  Widget OrderItemSelect() {
    return editcontroller.acid.value > 0
        ? OrderItemList(
            ordch: 'EDIT',
          )
        : const Text('Party Name Not '
            'Valid');
  }

  Widget OrderTotal() {
    return const OrderCartScreen();
  }

  @override
  void dispose() {
    Get.delete<OrderCartController>();
    super.dispose();
  }
}
