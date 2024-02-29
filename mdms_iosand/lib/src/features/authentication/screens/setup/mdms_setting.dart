// ignore_for_file: constant_identifier_names, library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:card_settings/card_settings.dart';
import 'package:mdms_iosand/singletons/singletons.dart';
import 'package:mdms_iosand/src/constants/colors.dart';

enum ConfirmSetAction { CANCEL, ACCEPT }

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  AppBar appBar() => AppBar(
        title: const Text(
          'mDMS Settings',
          style: TextStyle(color: tPrimaryColor, fontSize: 18),
        ),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: _buildPortraitLayout(),
    );
  }

  CardSettings _buildPortraitLayout() {
    return CardSettings.sectioned(
      showMaterialonIOS: false,
      cardElevation: 1.0,
      labelWidth: 100,
      labelAlign: TextAlign.left,
      labelPadding: 2,
      labelSuffix: ":",
      shrinkWrap: true,
      contentAlign: TextAlign.right,
      cardless: true,
      children: <CardSettingsSection>[
        CardSettingsSection(
          header: CardSettingsHeader(label: 'Account'),
          children: <CardSettingsWidget>[
            _buildCardSettingsSwitch_ViwAcmst(),
            _buildCardSettingsSwitch_Acmst(),
            _buildCardSettingsSwitch_EdtAcmst(),
            _buildCardSettingsSwitch_Ledger(),
            _buildCardSettingsSwitch_UnAdjCrNt(),
            CardSettingsHeader(label: 'Order'),
            _buildCardSettingsSwitch_AddOrd(),
            _buildCardSettingsSwitch_EdtOrd(),
            _buildCardSettingsSwitch_Rate(),
            _buildCardSettingsSwitch_Free(),
            _buildCardSettingsSwitch_Scheme(),
            _buildCardSettingsSwitch_TxBfSch(),
            _buildCardSettingsSwitch_Disc(),
            _buildCardSettingsSwitch_ChkLoc(),
            _buildCardSettingsSwitch_NoOrder(),
            _buildCardSettingsSwitch_NoStock(),
            CardSettingsHeader(label: 'Search'),
            _buildCardSettingsSwitch_ItemSearch(),
            _buildCardSettingsSwitch_PartySearch(),
            CardSettingsHeader(label: 'Receipt'),
            _buildCardSettingsSwitch_CasRcp(),
            _buildCardSettingsSwitch_ChqRcp(),
            CardSettingsHeader(label: 'Dashboard'),
            _buildCardSettingsSwitch_Os(),
            _buildCardSettingsSwitch_Stock(),
          ],
        )
      ],
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_ViwAcmst() {
    return CardSettingsSwitch(
      label: 'View Account ',
      //activeTrackColor: Colors.amber,
      showMaterialonIOS: true,
      initialValue: appSecure.viewac as bool,
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_Acmst() {
    return CardSettingsSwitch(
      label: 'Add New Account ',
      initialValue: appSecure.addac as bool,
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_EdtAcmst() {
    return CardSettingsSwitch(
      label: 'Edit Account ',
      initialValue: appSecure.editac as bool,
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_Ledger() {
    return CardSettingsSwitch(
      label: 'Show Ledger ',
      initialValue: appSecure.showledger as bool,
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_AddOrd() {
    return CardSettingsSwitch(
      label: 'Add Order ',
      initialValue: appSecure.addorder as bool,
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_EdtOrd() {
    return CardSettingsSwitch(
      label: 'Edit Order ',
      initialValue: appSecure.editorder as bool,
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_Rate() {
    return CardSettingsSwitch(
      label: 'Edit Rate ',
      initialValue: appSecure.editrate as bool,
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_Free() {
    return CardSettingsSwitch(
      label: 'Show Free ',
      initialValue: appSecure.showfree as bool,
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_Scheme() {
    return CardSettingsSwitch(
      label: 'Show Scheme ',
      initialValue: appSecure.showsch as bool,
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_TxBfSch() {
    return CardSettingsSwitch(
      label: 'Tax Before Scheme ',
      initialValue: appSecure.taxbeforescheme as bool,
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_Disc() {
    return CardSettingsSwitch(
      label: 'Show Discount ',
      initialValue: appSecure.showdisc as bool,
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_ChkLoc() {
    return CardSettingsSwitch(
      label: 'Check Location ',
      initialValue: appSecure.chklocation as bool,
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_NoOrder() {
    return CardSettingsSwitch(
      label: 'Show No Order Today',
      initialValue: appSecure.noorderoption as bool,
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_NoStock() {
    return CardSettingsSwitch(
      label: 'Show Item Stock',
      initialValue: appSecure.showitemstock as bool,
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_ItemSearch() {
    return CardSettingsSwitch(
      label: 'Item Search Contains ',
      initialValue: appSecure.itemcontains as bool,
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_PartySearch() {
    return CardSettingsSwitch(
      label: 'Party Search Contains ',
      initialValue: appSecure.namecontains as bool,
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_CasRcp() {
    return CardSettingsSwitch(
      label: 'Add/Edit Cash Receipts ',
      initialValue: appSecure.addcasrcpt as bool,
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_ChqRcp() {
    return CardSettingsSwitch(
      label: 'Add/Edit Cheque Receipts ',
      initialValue: appSecure.addchqrcpt as bool,
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_Os() {
    return CardSettingsSwitch(
      label: 'Show Outstanding ',
      initialValue: appSecure.showos as bool,
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_Stock() {
    return CardSettingsSwitch(
      label: 'Show Stock ',
      initialValue: appSecure.showstock as bool,
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_UnAdjCrNt() {
    return CardSettingsSwitch(
      label: 'UnAdjusted Credit Note ',
      initialValue: appSecure.showcrnt as bool,
    );
  }
}