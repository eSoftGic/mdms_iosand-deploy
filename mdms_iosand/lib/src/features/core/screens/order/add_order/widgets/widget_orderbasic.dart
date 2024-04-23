// ignore_for_file: must_be_immutable, prefer_final_fields, non_constant_identifier_names, prefer_interpolation_to_compose_strings, unrelated_type_equality_checks, prefer_adjacent_string_concatenation, curly_braces_in_flow_control_structures, unused_element, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:card_settings/card_settings.dart';
import 'package:mdms_iosand/src/constants/constants.dart';
import '../../../../../../../singletons/singletons.dart';
import 'controller_orderbasic.dart';
import 'package:list_picker/list_picker.dart';

class OrderBasicFormWidget extends StatelessWidget {
  OrderBasicFormWidget({
    super.key,
  });

  OrderBasicController controller = Get.put(OrderBasicController());

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> _bukidnm = GlobalKey<FormState>();
  GlobalKey<FormState> _prtidnm = GlobalKey<FormState>();
  GlobalKey<FormState> _bukidnmtxt = GlobalKey<FormState>();
  GlobalKey<FormState> _buknoorder = GlobalKey<FormState>();
  GlobalKey<FormState> _cmpselstr = GlobalKey<FormState>();
  GlobalKey<FormState> _cosidnm = GlobalKey<FormState>();
  final TextEditingController fieldCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Form(
          key: _formKey,
          child: Obx(() {
            return Card(
                elevation: 8,
                child: Column(children: <Widget>[
                  _buildpartyWidget(context),
                  _buildPortraitLayout(context),
                ]));
          }),
        ),
        const SizedBox(
          height: 5,
        ),
        Obx(() {
          return (controller.buknm.value != '' && controller.acid.value > 0)
              ? _Limit(context)
              : const SizedBox();
        })
      ],
    );
  }

  _Limit(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: controller.iscrdlimitover.value,
      title: Text(
        'Credit Limits',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: controller.iscrdlimitover.value == false
                ? Colors.green
                : Colors.red,
            fontWeight: FontWeight.bold),
      ),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('CREDIT',
                          style: Theme.of(context).textTheme.bodySmall),
                      Text('O/S', style: Theme.of(context).textTheme.bodySmall),
                      Text('LIMIT',
                          style: Theme.of(context).textTheme.bodySmall),
                      Text('STATUS',
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('DAYS',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w400)),
                    Text(
                      controller.bukosday.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(controller.bukcrday.toString(),
                        style: Theme.of(context).textTheme.bodyMedium),
                    controller.bukstday.toString().trim() == 'Over'
                        ? Icon(
                            Icons.clear,
                            color: Colors.red.shade900,
                            size: 20,
                          )
                        : Icon(
                            Icons.check,
                            color: Colors.green.shade900,
                            size: 20,
                          ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('BILLS',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w400)),
                    Text(controller.bukosbil.toString().trim(),
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text(controller.bukcrbil.toString(),
                        style: Theme.of(context).textTheme.bodyMedium),
                    controller.bukstbil.toString().trim() == 'Over'
                        ? Icon(Icons.clear,
                            size: 20, color: Colors.red.shade900)
                        : Icon(
                            Icons.check,
                            size: 20,
                            color: Colors.green.shade900,
                          ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('RS.#',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w400)),
                    Text(controller.bukosrs.toString(),
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text(controller.bukcrrs.toString(),
                        style: Theme.of(context).textTheme.bodyMedium),
                    controller.bukstrs.trim() == 'Over'
                        ? Icon(
                            Icons.clear,
                            size: 20,
                            color: Colors.red.shade900,
                          )
                        : Icon(
                            Icons.check,
                            size: 20,
                            color: Colors.green.shade900,
                          ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                CreditLimit(context),
                TodayOrder(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  CreditLimit(BuildContext context) {
    String msg = "";
    if (controller.iscrdlimitover == false) {
      msg = "Max. Order Amount Rs. " + controller.OrdLimit.toStringAsFixed(0);
    } else {
      msg = "Credit Limit Over";
    }
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            msg,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: controller.iscrdlimitover.value
                      ? Colors.red.shade900
                      : Colors.green.shade900,
                ),
          )
        ],
      ),
    );
  }

  TodayOrder() {
    String msg = '';
    if (controller.bukhasord == true) {
      msg = 'Order No. Created for ' + appData.buknm!;
    }
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            msg,
            style: const TextStyle(color: Colors.red, fontSize: 18.0),
          )
        ],
      ),
    );
  }

  CardSettings _buildPortraitLayout(BuildContext context) {
    return CardSettings.sectioned(
        showMaterialonIOS: true,
        cardElevation: 1.0,
        labelWidth: 100,
        labelAlign: TextAlign.left,
        labelPadding: 1,
        shrinkWrap: true,
        contentAlign: TextAlign.right,
        cardless: true,
        children: <CardSettingsSection>[
          CardSettingsSection(
            header: CardSettingsHeader(child: OrderHeader(context)),
            children: <CardSettingsWidget>[
              //_buildCardSettingsListPicker_Prt(),
              _buildCardSettingsListPicker_Buk(),
              //_buildCardSettingsText_Buk(),
              _buildCardSettingsSwitch_noorder(),
              _buildCardSettingsListPicker_Cos(),
              _buildCardSettingsSwitch_noorder(),
              _buildCardSettingsCheckboxPicker_cmp(),
            ],
          )
        ]);
  }

  CardSettingsSwitch _buildCardSettingsSwitch_noorder() {
    return CardSettingsSwitch(
      key: _buknoorder,
      label: 'Today\'s Order : ',
      showMaterialonIOS: true,
      initialValue: controller.todayorder.value,
      visible: appSecure.noorderoption!,
      onChanged: (value) {
        if (kDebugMode) {
          print('change no order value ' + value.toString());
        }
        controller.setTodayorder(value);
      },
    );
  }

  CardSettingsListPicker _buildCardSettingsListPicker_Cos() {
    return CardSettingsListPicker(
        key: _cosidnm,
        label: appData.commonorder! ? 'Ship.Addr : ' : 'Chainof Store : ',
        initialItem: appData.chainnm,
        //initialValue:
        contentAlign: TextAlign.end,
        autovalidateMode: AutovalidateMode.disabled,
        items: controller.coslist.map((f) => f.areanm).toList(),
        //options:
        visible: controller.costore,
        validator: (value) {
          if (value == null || value.toString().isEmpty)
            return appData.commonorder!
                ? 'Shipping Addr'
                : 'Chain Store ' + ' is required';
          return null;
        },
        onSaved: (value) {
          appData.chainnm = value;
        },
        onChanged: (value) {
          Get.snackbar('COS/Shipping Addr', value.toString());
          appData.chainnm = value;
        });
  }

  CardSettingsListPicker _buildCardSettingsListPicker_Buk() {
    return CardSettingsListPicker(
        key: _bukidnm,
        label: 'Sales Book : ',
        initialItem: controller.buknm.toString(),
        contentAlign: TextAlign.end,
        autovalidateMode: AutovalidateMode.disabled,
        items: controller.buklist.map((f) => f.trandesc).toList(),
        visible: true,
        validator: (value) {
          if (value == null || value.isEmpty) return 'Sales Book is required';
          return null;
        },
        onSaved: (value) {
          //print('selected buk ' + value);
          controller.buknm = value;
          controller.loadcredit(value);
          controller.setbukcmp(value);
          //appData.buknm = value;
          //controller.loadcredit(value);
        },
        onChanged: (value) {
          //Get.snackbar('Sales Book', value.toString());
          controller.buknm.value = value;
          controller.loadcredit(value);
          controller.setbukcmp(value);
        });
  }

  CardSettingsListPicker _buildCardSettingsListPicker_Prt() {
    return CardSettingsListPicker(
        key: _prtidnm,
        label: 'Name : ',
        initialItem: controller.acnm.value,
        contentAlign: TextAlign.center,
        autovalidateMode: AutovalidateMode.disabled,
        items: controller.prtlist.map((f) => f.ac_nm).toList(),
        showMaterialonIOS: true,
        visible: true,
        validator: (value) {
          if (value == null || value.isEmpty) return 'Party Name required';
          return null;
        },
        onSaved: (value) {
          controller.setParty(value);
          controller.acnm = value;
          controller.initorder(controller.acid.value);
        },
        onChanged: (value) {
          controller.setParty(value);
          controller.acnm.value = value;
          controller.initorder(controller.acid.value);

          if (controller.acid > 0) {
            if (appSecure.chklocation == true &&
                controller.invaliddist.value == false) {
              Get.snackbar(
                  'Invalid Distance, You are ',
                  controller.cdistance.toString() +
                      ' mtrs away from Party Location');
            }
          }
        });
  }

  CardSettingsCheckboxPicker _buildCardSettingsCheckboxPicker_cmp() {
    return CardSettingsCheckboxPicker(
      key: _cmpselstr,
      label: 'Company : ',
      initialItems: controller.company,
      items: controller.cmplist.map((f) => f.companynm).toList(),
      onSaved: (value) {
        controller.company = value!.cast<String>();
        appData.company = value.cast<String>();
      },
      onChanged: (value) {
        //Get.snackbar('Comapny ', value.toString());
        controller.company = value.cast<String>();
        appData.company = value.cast<String>(); //toString() as List<String>;
      },
    );
  }

  CardSettingsText _buildCardSettingsText_Buk() {
    return CardSettingsText(
      key: _bukidnmtxt,
      label: 'Sales Book',
      initialValue: controller.buknm.value,
      visible: true,
    );
  }

  Widget OrderHeader(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(controller.ordqottype != 'QOT' ? 'Order # ' : 'Quote # ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w400, fontSize: 18)),
                Text(
                    controller.istelephonicorder
                        ? controller.ordrefno.value.toString() + ' Telephonic '
                        : (controller.ordrefno.value.toString()),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                    controller.ordlat.toString() +
                        '/' +
                        controller.ordlon.toString().toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
                Text(controller.cdistance.toStringAsFixed(3) + ' mtrs',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ]),
          const Divider(),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Party Name',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w400, fontSize: 18)),
                  

              ],
            ),
        ]);
  }

  _buildpartyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
              controller.acnm.toString().isEmpty
                  ? 'Select Party'
                  : controller.acnm.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500, fontSize: 16)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: tCardLightColor, // Background color
              foregroundColor: tPrimaryColor, // Text Color (Foreground color)
            ),
            onPressed: () async {
              final String? prnm = await showPickerDialog(
                context: context,
                label: 'Party',
                items: controller.prtlist.map((f) => f.ac_nm!).toList(),
              );
              if (prnm != null) {
                controller.setParty(prnm);
                controller.acnm.value = prnm.toString();
                controller.initorder(controller.acid.value);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(prnm),
                  ),
                );
              }
              if (controller.acid > 0) {
                if (appSecure.chklocation == true &&
                    controller.invaliddist.value == false) {
                  Get.snackbar(
                      'Invalid Distance, You are ',
                      controller.cdistance.toString() +
                          ' mtrs away from Party Location');
                }
              }
            },
            child: const Text('>>'),
          ),
        
        ],
      ),
    );
  }
}
