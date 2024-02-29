// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mdms_iosand/singletons/singletons.dart';
import 'package:card_settings/card_settings.dart';
import 'package:mdms_iosand/src/constants/colors.dart';
import 'package:mdms_iosand/src/features/core/screens/party/home_list/party_home.dart';

class PartyFilter extends StatefulWidget {
  const PartyFilter({super.key});

  @override
  _PartyFilterState createState() => _PartyFilterState();
}

class _PartyFilterState extends State<PartyFilter> {
  final GlobalKey<FormState> _pfiltKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _pscfdKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _betstr = GlobalKey<FormState>();
  final GlobalKey<FormState> _clsstr = GlobalKey<FormState>();
  final GlobalKey<FormState> _typstr = GlobalKey<FormState>();
  final GlobalKey<FormState> _ordstr = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _pscfdKey,
      appBar: AppBar(
        leading: IconButton(
            color: tPrimaryColor,
            onPressed: () {
              Get.to(() => const PartyHomeScreen());
            },
            icon: const Icon(
              LineAwesomeIcons.angle_left,
              size: 24,
            )),
        title: Text("Party Filter Options", style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.delete_forever_outlined,
                color: tPrimaryColor,
                size: 24,
              ),
              onPressed: () {
                setState(() {
                  appData.filtbeat = <String>[];
                  appData.filtclass = <String>[];
                  appData.filttype = <String>[];
                  appData.filtordnm = 'ALL';
                  appData.sortbyroute = false;
                });
                Navigator.pop(context);
              }),
          IconButton(
              icon: const Icon(
                Icons.refresh_outlined,
                color: tPrimaryColor,
                size: 24,
              ),
              onPressed: () {
                setState(() {
                  appData.filtbeat = <String>[];
                  appData.filtclass = <String>[];
                  appData.filttype = <String>[];
                  appData.filtordnm = 'ALL';
                  appData.sortbyroute = false;
                });
                Navigator.pop(context);
              }),
        ],
      ),
      body: Form(key: _pfiltKey, child: _buildPortraitLayout()),
    );
  }

  CardSettings _buildPortraitLayout() {
    return CardSettings.sectioned(
      labelWidth: 150,
      contentAlign: TextAlign.right,
      children: <CardSettingsSection>[
        CardSettingsSection(children: <CardSettingsWidget>[
          _buildCardSettingsCheckboxPicker_Beat(),
          _buildCardSettingsCheckboxPicker_Class(),
          _buildCardSettingsCheckboxPicker_Type(),
          _buildCardSettingsListPicker_Order(),
          _buildCardSettingsSwitch_Route(),
        ])
      ],
    );
  }

  CardSettingsCheckboxPicker _buildCardSettingsCheckboxPicker_Beat() {
    return CardSettingsCheckboxPicker(
      key: _betstr,
      label: 'Beat',
      initialItems: appData.filtbeat,
      items: appData.allbeat.toList(),
      /*autovalidate: _autoValidate,
      validator: (List<String> value) {
        if (value == null || value.isEmpty)
          return 'You must pick at least one hobby.';
        return null;
      },*/
      onSaved: (value) => appData.filtbeat = value as List<String>,
      onChanged: (value) {
        setState(() {
          appData.filtbeat = value.map((e) => e.toString()).toList();
        });
      },
    );
  }

  CardSettingsCheckboxPicker _buildCardSettingsCheckboxPicker_Type() {
    return CardSettingsCheckboxPicker(
      key: _typstr,
      label: 'Type',
      initialItems: appData.filttype,
      items: appData.alltype.toList(),
      onSaved: (value) => appData.filttype = value as List<String>,
      onChanged: (value) {
        setState(() {
          appData.filttype = value.map((e) => e.toString()).toList();
        });
      },
    );
  }

  CardSettingsCheckboxPicker _buildCardSettingsCheckboxPicker_Class() {
    return CardSettingsCheckboxPicker(
      key: _clsstr,
      label: 'Class',
      initialItems: appData.filtclass,
      items: appData.allclass.toList(),
      onSaved: (value) => appData.filtclass = value as List<String>,
      onChanged: (value) {
        setState(() {
          appData.filtclass = value.map((e) => e.toString()).toList();
        });
      },
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_Route() {
    return CardSettingsSwitch(
      label: 'Sort By Route ',
      initialValue: appData.sortbyroute,
      onChanged: (value) {
        setState(() {
          appData.sortbyroute = value;
        });
      },
    );
  }

  CardSettingsListPicker _buildCardSettingsListPicker_Order() {
    return CardSettingsListPicker(
        key: _ordstr,
        label: 'Party Order Filter',
        initialItem: appData.filtordnm,
        contentAlign: TextAlign.end,
        autovalidateMode: AutovalidateMode.disabled,
        items: appData.filtord.toList(),
        visible: true,
        validator: (value) {
          if (value == null) return 'ALL';
          return null;
        },
        onSaved: (value) {
          setState(() {
            appData.filtordnm = value;
          });
        },
        onChanged: (value) {
          setState(() {
            appData.filtordnm = value;
          });
        });
  }
}