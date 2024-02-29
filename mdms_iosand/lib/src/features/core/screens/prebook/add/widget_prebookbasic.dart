// ignore_for_file: must_be_immutable, non_constant_identifier_names, unrelated_type_equality_checks, avoid_print, unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:card_settings/card_settings.dart';
import '../../../../../../../singletons/singletons.dart';
import 'controller_prebookbasic.dart';

class PreBookBasicFormWidget extends StatelessWidget {
  PreBookBasicFormWidget({
    super.key,
  });

  PreBookBasicController controller = Get.put(PreBookBasicController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _bukidnm = GlobalKey<FormState>();
  final GlobalKey<FormState> _prtidnm = GlobalKey<FormState>();
  final GlobalKey<FormState> _bukidnmtxt = GlobalKey<FormState>();
  final GlobalKey<FormState> _buknoorder = GlobalKey<FormState>();
  final GlobalKey<FormState> _cmpselstr = GlobalKey<FormState>();
  final GlobalKey<FormState> _cosidnm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Form(
          key: _formKey,
          child: Obx(() {
            return Card(elevation: 8, child: _buildPortraitLayout(context));
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
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: controller.iscrdlimitover.value == false ? Colors.green : Colors.red,
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
                      Text('CREDIT', style: Theme.of(context).textTheme.headlineSmall),
                      Text('O/S', style: Theme.of(context).textTheme.headlineSmall),
                      Text('LIMIT', style: Theme.of(context).textTheme.headlineSmall),
                      Text('STATUS', style: Theme.of(context).textTheme.headlineSmall),
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
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
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
                    Text(
                      'BILLS',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(controller.bukosbil.toString().trim(),
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text(controller.bukcrbil.toString(),
                        style: Theme.of(context).textTheme.bodyMedium),
                    controller.bukstbil.toString().trim() == 'Over'
                        ? Icon(Icons.clear, size: 20, color: Colors.red.shade900)
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
                    Text(
                      'RS.#',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
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
      msg = "Max. Order Amount Rs. ${controller.OrdLimit.toStringAsFixed(0)}";
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
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color:
                      controller.iscrdlimitover.value ? Colors.red.shade900 : Colors.green.shade900,
                ),
          )
        ],
      ),
    );
  }

  CardSettings _buildPortraitLayout(BuildContext context) {
    return CardSettings.sectioned(
        showMaterialonIOS: false,
        cardElevation: 1.0,
        labelWidth: 100,
        labelAlign: TextAlign.left,
        labelPadding: 1,
        shrinkWrap: true,
        contentAlign: TextAlign.right,
        cardless: true,
        children: <CardSettingsSection>[
          CardSettingsSection(
            header: CardSettingsHeader(child: PreOrderHeader(context)),
            children: <CardSettingsWidget>[
              _buildCardSettingsListPicker_Prt(),
              _buildCardSettingsListPicker_Buk(),
              //_buildCardSettingsText_Buk(),
              _buildCardSettingsSwitch_noorder(),
              _buildCardSettingsListPicker_Cos(),
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
        print('change no order value $value');
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
          if (value == null || value.toString().isEmpty) {
            return appData.commonorder! ? 'Shipping Addr' : 'Chain Store ' ' is required';
          }
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
        contentAlign: TextAlign.end,
        autovalidateMode: AutovalidateMode.disabled,
        items: controller.prtlist.map((f) => f.ac_nm).toList(),
        visible: true,
        validator: (value) {
          if (value == null || value.isEmpty) return 'Party Name required';
          return null;
        },
        onSaved: (value) {
          //print('selected prt on saved ' + value);
          controller.setParty(value);
          controller.acnm = value;
          controller.initorder(controller.acid.value);
        },
        onChanged: (value) {
          controller.setParty(value);
          if (controller.acid > 0) {
            if (appSecure.chklocation == true && controller.invaliddist.value == false) {
              Get.snackbar('Invalid Distance, You are ',
                  '${controller.cdistance} mtrs away from Party Location');
            }
            controller.initorder(controller.acid.value);
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
        Get.snackbar('Comapny ', value.toString());
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

  Widget PreOrderHeader(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('PreBook # ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
                Text(
                  controller.istelephonicorder
                      ? '${controller.ordrefno.value} Telephonic '
                      : (controller.ordrefno.value.toString()),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${controller.ordlat}/${controller.ordlon}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                Text('${controller.cdistance.toStringAsFixed(3)} mtrs',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ],
            )
          ]),
          const Divider(),
        ]);
  }
}