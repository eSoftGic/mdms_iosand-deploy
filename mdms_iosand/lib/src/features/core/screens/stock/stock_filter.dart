// ignore_for_file: unused_local_variable, non_constant_identifier_names

import 'package:flutter/material.dart' show AppBar, BuildContext, Form, FormState, GlobalKey, Icon, IconButton, Icons, MediaQuery, Navigator, Scaffold, ScaffoldState, State, StatefulWidget, Text, TextAlign, Theme, Widget;
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mdms_iosand/src/features/core/screens/stock/stock_home.dart';
import '../../../../../singletons/AppData.dart';
import 'package:card_settings/card_settings.dart';

import '../../../../constants/colors.dart';

class StockFilter extends StatefulWidget {
  const StockFilter({super.key});

  @override
  State<StockFilter> createState() => _StockFilterState();
}

class _StockFilterState extends State<StockFilter> {
  final GlobalKey<FormState> _filtKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scfdKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _compstr = GlobalKey<FormState>();
  final GlobalKey<FormState> _brndstr = GlobalKey<FormState>();
  final GlobalKey<FormState> _catestr = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      key: _scfdKey,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: appBar(),
      body: Form(key: _filtKey, child: _buildPortraitLayout()),
    );
  }

  AppBar appBar() => AppBar(
          leading: IconButton(
              color: tPrimaryColor,
              onPressed: () {
                Get.to(() => const StockHomeScreen());
              },
              icon: const Icon(
                LineAwesomeIcons.angle_left,
                size: 24,
              )),
          title: Text("Stock Filter Options", style: Theme.of(context).textTheme.headlineMedium),
          actions: <Widget>[
            IconButton(
                icon: const Icon(
                  Icons.delete_forever_outlined,
                  color: tPrimaryColor,
                  size: 24,
                ),
                onPressed: () {
                  setState(() {
                    appData.filtbrand = <String>[];
                    appData.filtcategory = <String>[];
                    appData.filtcompany = <String>[];
                  });
                  Navigator.pop(context);
                }),
          ]);

  CardSettings _buildPortraitLayout() {
    return CardSettings.sectioned(
        labelWidth: 150,
        contentAlign: TextAlign.center,
        children: <CardSettingsSection>[
          CardSettingsSection(
              header: CardSettingsHeader(label: 'Item Filter'),
              children: <CardSettingsWidget>[
                _buildCardSettingsCheckboxPicker_Cmp(),
                _buildCardSettingsCheckboxPicker_Cat(),
                _buildCardSettingsCheckboxPicker_Brn(),
              ])
        ]);
  }

  CardSettingsCheckboxPicker _buildCardSettingsCheckboxPicker_Cmp() {
    return CardSettingsCheckboxPicker(
      key: _compstr,
      label: 'Company',
      initialItems: appData.filtcompany,
      items: appData.allcomp.toList(),
      onSaved: (value) => appData.filtbrand = value as List<String>,
      onChanged: (value) {
        setState(() {
          appData.filtcompany = value.cast<String>(); // as List<String>;
          appData.applystkfilter = false;
          if (value.toString().trim() != '') {
            appData.applystkfilter = true;
          }
        });
      },
    );
  }

  CardSettingsCheckboxPicker _buildCardSettingsCheckboxPicker_Brn() {
    return CardSettingsCheckboxPicker(
      key: _brndstr,
      label: 'Brand',
      initialItems: appData.filtbrand,
      items: appData.allbrand.toList(),
      onSaved: (value) => appData.filtbrand = value as List<String>,
      onChanged: (value) {
        setState(() {
          appData.filtbrand = value.cast<String>(); //, as List<String>;
          appData.applystkfilter = false;
          if (value.toString().trim() != '') {
            appData.applystkfilter = true;
          }
        });
      },
    );
  }

  CardSettingsCheckboxPicker _buildCardSettingsCheckboxPicker_Cat() {
    return CardSettingsCheckboxPicker(
      key: _catestr,
      label: 'Category',
      initialItems: appData.filtcategory,
      items: appData.allcategory.toList(),
      onSaved: (value) => appData.filtcategory = value as List<String>,
      onChanged: (value) {
        setState(() {
          appData.filtcategory = value.cast<String>(); // as List<String>;
          appData.applystkfilter = false;
          if (value.toString().trim() != '') {
            appData.applystkfilter = true;
          }
        });
      },
    );
  }
}