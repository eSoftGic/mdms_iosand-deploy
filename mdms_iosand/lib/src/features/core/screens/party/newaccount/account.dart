// ignore_for_file: unused_field, unused_local_variable, constant_identifier_names, avoid_print, non_constant_identifier_names, unused_element, unrelated_type_equality_checks, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:card_settings/card_settings.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:mdms_iosand/src/features/core/models/bank_model.dart';
import 'package:mdms_iosand/src/features/core/models/beat_model.dart';
import 'package:mdms_iosand/src/features/core/models/branchbank_model.dart';
import 'package:mdms_iosand/src/features/core/models/class_model.dart';
import 'package:mdms_iosand/src/features/core/models/country_model.dart';
import 'package:mdms_iosand/src/features/core/models/group_model.dart';
import 'package:mdms_iosand/src/features/core/models/state_model.dart';
import 'package:mdms_iosand/src/features/core/models/transporter_model.dart';
import 'package:mdms_iosand/src/features/core/models/type_model.dart';
import 'package:mdms_iosand/src/features/core/models/acmst_model.dart';
import 'package:mdms_iosand/src/features/core/models/acmst_len_model.dart';
import 'package:mdms_iosand/src/features/core/models/payment_model.dart';
import 'package:mdms_iosand/src/features/core/models/area_model.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../../../singletons/AppData.dart';
import '../home_list/party_home.dart';

enum ConfirmMstAction { CANCEL, ACCEPT }

class AccountMst extends StatefulWidget {
  const AccountMst({super.key});

  @override
  State<AccountMst> createState() => _AccountMstState();
}

class _AccountMstState extends State<AccountMst> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final dfmdy = DateFormat('MM/dd/yyyy');
  int _acid = 0;
  String _acnm = '';
  late Position currentLocation;
  String _lat = "";
  String _lon = "";
  final AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  var _acmstModel = AcMstModel();
  final bool _savesuccess = false;

  final List<IndiaState> _statelist = <IndiaState>[];
  final List<Country> _countrylist = <Country>[];
  final List<Beat> _beatlist = <Beat>[];
  final List<ClassModel> _classlist = <ClassModel>[];
  final List<TypeModel> _typelist = <TypeModel>[];
  final List<Transporter> _transplist = <Transporter>[];
  final List<GroupModel> _grouplist = <GroupModel>[];
  final List<Bank> _banklist = <Bank>[];
  final List<BankBranch> _branchlist = <BankBranch>[];
  final List<Payment> _paylist = <Payment>[];
  List<AcMstModel> _acmstList = <AcMstModel>[];
  final List<AcMstLenModel> _acmstlen = <AcMstLenModel>[];
  final List<Area> _arealist = <Area>[];

  @override
  void initState() {
    super.initState();
    loadlists();
    _acid = 0;
    _acnm = '';
    if (appData.acmstid! > 0) {
      _acid = appData.acmstid!;
      _acnm = appData.acmstnm!;
    }
    loadac(_acid);
  }

  void loadac(int acid) async {
    //acmst
    if (acid > 0) {
      await fetchAcMst(acid).then((value) {
        setState(() {
          _acmstList = value;
        });
      });
    } else {
      var acblnk = AcMstModel(
          acgrpid: 0,
          acgrpname: 'DEBTORS',
          acmstcode: '',
          acmstid: 0,
          acmstname: '',
          acopn: 0.00,
          add1: '',
          add2: '',
          add3: '',
          add4: '',
          bankid: 0,
          banknam: '.None',
          beatid: 0,
          beatnam: '',
          branchid: 0,
          branchnam: '.None',
          city: '',
          classid: 0,
          classnam: '',
          conPer: '',
          countryid: 1,
          countrynm: 'INDIA',
          crdbtype: 'Credit',
          distancekm: 0,
          drgLic: '',
          emailId: '',
          foodLic: '',
          gpslat: 0.00,
          gpslon: 0.00,
          gstDt: '2017-06-30',
          gstRegDt: DateTime.parse('2017-06-30'),
          gsttin: '',
          inactive: false,
          inactivereason: '',
          landline: '',
          mobileno: '',
          pan: '',
          payid: 0,
          paynam: 'Default',
          pincode: '',
          routeSr: '',
          statecd: '24',
          stateid: 1,
          statenm: 'GUJARAT',
          transportid: 0,
          transportnm: '',
          typeid: 0,
          typenam: '');
      _acmstList.add(acblnk);
    }
    setState(() {
      _acmstModel = _acmstList[0];
    });
  }

  void loadlists() async {
    //ACmstLen
    await fetchAcMstLen().then((value) {
      setState(() {
        _acmstlen.addAll(value);
      });
    });
    //state
    await fetchState().then((value) {
      setState(() {
        _statelist.addAll(value);
      });
    });

    //country
    await fetchCountry().then((value) {
      setState(() {
        _countrylist.addAll(value);
      });
    });

    //Beat
    await fetchBeat().then((value) {
      setState(() {
        _beatlist.addAll(value);
      });
    });

    //Class
    await fetchClass().then((value) {
      setState(() {
        _classlist.addAll(value);
      });
    });

    //Type
    await fetchType().then((value) {
      setState(() {
        _typelist.addAll(value);
      });
    });

    //Transporter
    await fetchTrans().then((value) {
      setState(() {
        _transplist.addAll(value);
      });
    });

    //Group
    await fetchGroup().then((value) {
      setState(() {
        _grouplist.addAll(value);
      });
    });

    //Bank
    await fetchBank().then((value) {
      setState(() {
        _banklist.addAll(value);
      });
    });

    //Branch
    await fetchBranch().then((value) {
      setState(() {
        _branchlist.addAll(value);
      });
    });

    //Payment
    await fetchPayment().then((value) {
      setState(() {
        _paylist.addAll(value);
      });
    });

    // Area
    if (appData.commonorder == true) {
      await fetchArea().then((value) {
        setState(() {
          _arealist.addAll(value);
          print('area ${_arealist.length}');
        });
      });
    }
  }

  AppBar appBar() => AppBar(
        title: Text(_acnm == '' ? 'New A/C' : _acnm),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _savePressed,
          ),
        ],
        /*
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: ,
        ),*/
      );
  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: appBar(),
        body: Form(key: _formKey, child: _buildPortraitLayout()));
  }

  Savebutton() {
    return IconButton(
        icon: const Icon(Icons.save),
        color: Colors.blue,
        disabledColor: Colors.grey,
        highlightColor: Colors.deepOrangeAccent,
        onPressed: () async {
          _savePressed();
        });
  }

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  _getloc() async {
    currentLocation = await locateUser();
    print('Acct get loc ${currentLocation.longitude}');
    setState(() {
      _lat = currentLocation.latitude.toString();
      _lon = currentLocation.longitude.toString();
      _acmstModel.gpslat = double.parse(currentLocation.latitude.toString());
      _acmstModel.gpslon = double.parse(currentLocation.longitude.toString());
    });
    print('New Location is :${_acmstModel.gpslat} - ${_acmstModel.gpslon}');
  }

  CardSettings _buildPortraitLayout() {
    return CardSettings.sectioned(
      labelWidth: 150,
      contentAlign: TextAlign.right,
      cardElevation: 2.0,
      cardless: false,
      labelAlign: TextAlign.left, // change the label alignment
      labelSuffix: ':', // add an optional tag after the label
      labelPadding: 0.0, // control the spacing between the label and the content
      shrinkWrap: true,
      children: <CardSettingsSection>[
        CardSettingsSection(
            header: CardSettingsHeader(label: 'Account'),
            children: <CardSettingsWidget>[
              _buildCardSettingsText_AcName(),
              _buildCardSettingsListPicker_AcGroup(),
              _buildCardSettingsText_AcCode(),
              _buildCardSettingsOpening(),
              _buildCardSettingsListPicker_CrDb(),
            ]),
        CardSettingsSection(
          header: CardSettingsHeader(label: 'Area/Beat/Class/Type'),
          children: <CardSettingsWidget>[
            _buildCardSettingsListPicker_Area(),
            _buildCardSettingsListPicker_Beat(),
            _buildCardSettingsListPicker_Class(),
            _buildCardSettingsListPicker_AcType(),
          ],
        ),
        CardSettingsSection(
          header: CardSettingsHeader(
            label: 'Contact',
          ),
          children: <CardSettingsWidget>[
            _buildCardSettingsText_mobile(),
            _buildCardSettingsEmail(),
            _buildCardSettingsText_ll(),
            _buildCardSettingsText_cp(),
          ],
        ),
        CardSettingsSection(
          header: CardSettingsHeader(label: 'Address'),
          children: const <CardSettingsWidget>[],
        ),
        CardSettingsSection(
          header: CardSettingsHeader(label: 'Address'),
          children: <CardSettingsWidget>[
            _buildCardSettingsText_Add1(),
            _buildCardSettingsText_Add2(),
            _buildCardSettingsText_Add3(),
            _buildCardSettingsText_Add4(),
            _buildCardSettingsText_City(),
            _buildCardSettingsText_Pin(),
            _buildCardSettingsListPicker_State(),
            _buildCardSettingsListPicker_Country(),
          ],
        ),
        CardSettingsSection(
          header: CardSettingsHeader(label: 'Shipping Address'),
          children: <CardSettingsWidget>[
            _buildCardSettingsText_SAdd1(),
            _buildCardSettingsText_SCity(),
            _buildCardSettingsText_SPin(),
            _buildCardSettingsListPicker_SState(),
            _buildCardSettingsText_Smobile(),
            _buildCardSettingsSEmail(),
            _buildCardSettingsText_Sll(),
            _buildCardSettingsText_Scp(),
            _buildCardSettingsText_SDistance(),
            _buildCardSettingsText_Sgst(),
            _buildCardSettingsDatePicker_SGstDt(),
          ],
        ),
        CardSettingsSection(
          header: CardSettingsHeader(label: 'Misc..'),
          children: <CardSettingsWidget>[
            _buildCardSettingsText_Route(),
            _buildCardSettingsListPicker_Bank(),
            _buildCardSettingsListPicker_Branch(),
            _buildCardSettingsListPicker_Payment(),
          ],
        ),
        CardSettingsSection(
          header: CardSettingsHeader(label: 'License'),
          children: <CardSettingsWidget>[
            _buildCardSettingsText_gst(),
            _buildCardSettingsDatePicker_GstDt(),
            _buildCardSettingsText_pan(),
            _buildCardSettingsText_drg(),
            _buildCardSettingsText_food(),
            _buildCardSettingsListPicker_Transport(),
            _buildCardSettingsText_Distance(),
          ],
        ),
        CardSettingsSection(
          header: CardSettingsHeader(label: 'GPS'),
          children: <CardSettingsWidget>[
            _buildCardSettingsButton_Gps(),
            //_buildCardSettingsText_GpsLat(),
            //_buildCardSettingsText_GpsLon(),
            _buildCardSettingsSwitch_Active(),
            _buildCardSettingsText_InactiveRsn()
          ],
        ),
      ],
    );
  }

  Future<List<AcMstLenModel>> fetchAcMstLen() async {
    var qryparam = "DbName=${appData.log_dbnm!}";
    var url = "${appData.baseurl!}ac_mst_field_len?$qryparam";
    var response = await http.get(url as Uri);
    var aclenlist = <AcMstLenModel>[];
    if (response.statusCode == 200) {
      var stt = json.decode(response.body);
      for (var sttjson in stt) {
        aclenlist.add(AcMstLenModel.fromJson(sttjson));
      }
    }
    return aclenlist;
  }

  Future<List<IndiaState>> fetchState() async {
    var qryparam = "DbName=${appData.log_dbnm!}";
    var url = "${appData.baseurl!}state_mst?$qryparam";
    var response = await http.get(url as Uri);
    var statelist = <IndiaState>[];
    if (response.statusCode == 200) {
      var stt = json.decode(response.body);
      for (var sttjson in stt) {
        statelist.add(IndiaState.fromJson(sttjson));
      }
    }
    return statelist;
  }

  Future<List<Country>> fetchCountry() async {
    var qryparam = "DbName=${appData.log_dbnm!}";
    var url = "${appData.baseurl!}country?$qryparam";
    var response = await http.get(url as Uri);
    var coutrylist = <Country>[];
    if (response.statusCode == 200) {
      var stt = json.decode(response.body);
      for (var sttjson in stt) {
        coutrylist.add(Country.fromJson(sttjson));
      }
    }
    return coutrylist;
  }

  Future<List<Beat>> fetchBeat() async {
    var qryparam = "DbName=${appData.log_dbnm!}";
    var url = "${appData.baseurl!}ac_beat?$qryparam";
    var response = await http.get(url as Uri);
    var beatlist = <Beat>[];
    if (response.statusCode == 200) {
      var stt = json.decode(response.body);
      for (var sttjson in stt) {
        beatlist.add(Beat.fromJson(sttjson));
      }
    }
    return beatlist;
  }

  Future<List<ClassModel>> fetchClass() async {
    var qryparam = "DbName=${appData.log_dbnm!}";
    var url = "${appData.baseurl!}ac_class?$qryparam";
    var response = await http.get(url as Uri);
    var clslist = <ClassModel>[];
    if (response.statusCode == 200) {
      var stt = json.decode(response.body);
      for (var sttjson in stt) {
        clslist.add(ClassModel.fromJson(sttjson));
      }
    }
    return clslist;
  }

  Future<List<TypeModel>> fetchType() async {
    var qryparam = "DbName=${appData.log_dbnm!}";
    var url = "${appData.baseurl!}ac_type?$qryparam";
    var response = await http.get(url as Uri);
    var typlist = <TypeModel>[];
    if (response.statusCode == 200) {
      var stt = json.decode(response.body);
      for (var sttjson in stt) {
        typlist.add(TypeModel.fromJson(sttjson));
      }
    }
    return typlist;
  }

  Future<List<Transporter>> fetchTrans() async {
    var qryparam = "DbName=${appData.log_dbnm!}";
    var url = "${appData.baseurl!}ac_transporter?$qryparam";
    var response = await http.get(url as Uri);
    var translist = <Transporter>[];
    if (response.statusCode == 200) {
      var stt = json.decode(response.body);
      for (var sttjson in stt) {
        translist.add(Transporter.fromJson(sttjson));
      }
    }
    return translist;
  }

  Future<List<GroupModel>> fetchGroup() async {
    var qryparam = "DbName=${appData.log_dbnm!}";
    var url = "${appData.baseurl!}ac_group?$qryparam";
    var response = await http.get(url as Uri);
    var grplist = <GroupModel>[];
    if (response.statusCode == 200) {
      var stt = json.decode(response.body);
      for (var sttjson in stt) {
        grplist.add(GroupModel.fromJson(sttjson));
      }
    }
    return grplist;
  }

  Future<List<Bank>> fetchBank() async {
    var qryparam = "DbName=${appData.log_dbnm!}";
    var url = "${appData.baseurl!}ac_bank?$qryparam";
    var response = await http.get(url as Uri);
    var bnklist = <Bank>[];
    if (response.statusCode == 200) {
      var stt = json.decode(response.body);
      for (var sttjson in stt) {
        bnklist.add(Bank.fromJson(sttjson));
      }
    }
    return bnklist;
  }

  Future<List<BankBranch>> fetchBranch() async {
    var qryparam = "DbName=${appData.log_dbnm!}";
    var url = "${appData.baseurl!}ac_branch?$qryparam";
    var response = await http.get(url as Uri);
    var brnlist = <BankBranch>[];
    if (response.statusCode == 200) {
      var stt = json.decode(response.body);
      for (var sttjson in stt) {
        brnlist.add(BankBranch.fromJson(sttjson));
      }
    }
    return brnlist;
  }

  Future<List<Payment>> fetchPayment() async {
    var url = "${appData.baseurl!}ac_pay_mode";
    var response = await http.get(url as Uri);
    var paylist = <Payment>[];
    if (response.statusCode == 200) {
      var stt = json.decode(response.body);
      for (var sttjson in stt) {
        paylist.add(Payment.fromJson(sttjson));
      }
    }
    return paylist;
  }

  Future<List<Area>> fetchArea() async {
    var qryparam = "DbName=${appData.log_dbnm!}&area_id_str=${appData.log_smnbeat!}";
    var url = "${appData.baseurl!}ret_area?$qryparam";
    print(url);
    var response = await http.get(url as Uri);
    var arealist = <Area>[];
    if (response.statusCode == 200) {
      var stt = json.decode(response.body);
      for (var sttjson in stt) {
        arealist.add(Area.fromJson(sttjson));
      }
    }
    return arealist;
  }

  Future<List<AcMstModel>> fetchAcMst(int acid) async {
    var qryparam = "DbName=${appData.log_dbnm!}&ac_id=$acid";
    var url = "${appData.baseurl!}ac_mst?$qryparam";
    print(url);
    var response = await http.get(url as Uri);
    var aclist = <AcMstModel>[];
    if (response.statusCode == 200) {
      var acmod = json.decode(response.body);
      debugPrint(acmod.toString());
      for (var acmstjson in acmod) {
        aclist.add(AcMstModel.fromJson(acmstjson));
      }
    }
    return aclist;
  }

  // Accounts
  CardSettingsText _buildCardSettingsText_AcName() {
    return CardSettingsText(
      label: 'Name',
      initialValue: _acnm,
      requiredIndicator: const Text('*', style: TextStyle(color: Colors.red)),
      autovalidateMode: _autoValidate,
      keyboardType: TextInputType.text,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(50),
        //BlacklistingTextInputFormatter.singleLineFormatter, // Forces Single Line
        //WhitelistingTextInputFormatter(RegExp("[a-z,A-Z, ,-,_,/,0-9]"))
      ],
      autofocus: true,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue.shade600),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Name type is required.';
        return null;
      },
      onChanged: (value) {
        setState(() => _acmstModel.acmstname = value);
      },
    );
  }

  CardSettingsListPicker _buildCardSettingsListPicker_AcGroup() {
    return CardSettingsListPicker(
        label: 'Group',
        hintText: _acmstModel.acgrpname,
        initialItem: _acmstModel.acgrpname,
        autovalidateMode: _autoValidate,
        requiredIndicator: const Text('*', style: TextStyle(color: Colors.red)),
        items: _grouplist.map((f) => f.grpnm).toList(),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Select';
          return null;
        },
        onChanged: (value) {
          setState(() {
            print(value);
            _acmstModel.acgrpname = value;
            for (var f in _grouplist) {
              if (value.trim().toLowerCase() == f.grpnm!.trim().toLowerCase()) {
                _acmstModel.acgrpid = f.grpid;
                _acmstModel.acgrpname = f.grpnm;
              }
            }
          });
        });
  }

  CardSettingsText _buildCardSettingsText_AcCode() {
    return CardSettingsText(
        //key: _formKey, //_accodeKey,
        label: 'Code',
        controller: TextEditingController.fromValue(TextEditingValue(
            text: _acmstModel.acmstcode ?? '',
            selection: TextSelection.collapsed(
                offset: _acmstModel.acmstcode == null ? 0 : _acmstModel.acmstcode!.length))),
        requiredIndicator: const Text('*', style: TextStyle(color: Colors.red)),
        keyboardType: TextInputType.text,
        inputFormatters: const <TextInputFormatter>[
          //LengthLimitingTextInputFormatter(20),
          //BlacklistingTextInputFormatter.singleLineFormatter, // Forces Single Line
          //WhitelistingTextInputFormatter(RegExp("[A-Z,_,0-9]"))
        ],
        autovalidateMode: _autoValidate,
        validator: (value) {
          if (value == null || value.isEmpty) return 'A/C Code is required.';
          return null;
        },
        onChanged: (value) {
          setState(() => _acmstModel.acmstcode = value);
        });
  }

  CardSettingsDouble _buildCardSettingsOpening() {
    return CardSettingsDouble(
        label: 'Opening',
        contentAlign: TextAlign.left,
        maxLength: 16,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [ThousandsFormatter(allowFraction: true)],
        //currencySymbol: 'Rs.',
        //currencyName: 'INR',
        initialValue: _acmstModel.acopn ?? 0,
        autovalidateMode: _autoValidate,
        onChanged: (value) {
          setState(
            () => _acmstModel.acopn = value,
          );
        });
  }

  CardSettingsListPicker _buildCardSettingsListPicker_CrDb() {
    return CardSettingsListPicker(
      label: 'Cr/Db',
      initialItem: 'Credit',
      autovalidateMode: _autoValidate,
      items: const <String>['Credit', 'Debit'],
      validator: (value) {
        if (_acmstModel.acopn != 0) {
          if (value == null || value.isEmpty) return 'Select Credit/Debit ';
          return null;
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          _acmstModel.crdbtype = value;
          var mf = 1;
          if (value == "Debit") {
            mf = -1;
          }
          _acmstModel.acopn = _acmstModel.acopn!.abs() * mf;
        });
      },
    );
  }

  // Area /Beat/Class/Type
  CardSettingsListPicker _buildCardSettingsListPicker_Area() {
    return CardSettingsListPicker(
        //key: _formKey, //_beatKey,
        label: 'Area',
        initialItem: _acmstModel.areanam,
        autovalidateMode: _autoValidate,
        requiredIndicator: const Text('*', style: TextStyle(color: Colors.red)),
        items: _arealist.map((f) => f.areanm).toList(),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Area is required';
          return null;
        },
        onChanged: (value) {
          //_showSnackBar('Beat ', value);
          setState(() {
            _acmstModel.areanam = value;
            for (var f in _arealist) {
              if (value.trim().toLowerCase() == f.areanm!.trim().toLowerCase()) {
                _acmstModel.areaid = f.areaid;
              }
            }
          });
        });
  }

  CardSettingsListPicker _buildCardSettingsListPicker_Beat() {
    return CardSettingsListPicker(
        //key: _formKey, //_beatKey,
        label: 'Beat',
        initialItem: _acmstModel.beatnam,
        autovalidateMode: _autoValidate,
        requiredIndicator: const Text('*', style: TextStyle(color: Colors.red)),
        items: _beatlist.map((f) => f.beatnm).toList(),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Beat is required';
          return null;
        },
        onChanged: (value) {
          //_showSnackBar('Beat ', value);
          setState(() {
            _acmstModel.beatnam = value;
            for (var f in _beatlist) {
              if (value.trim().toLowerCase() == f.beatnm!.trim().toLowerCase()) {
                _acmstModel.beatid = f.beatid;
              }
            }
          });
        });
  }

  CardSettingsListPicker _buildCardSettingsListPicker_Class() {
    return CardSettingsListPicker(
        label: 'Class',
        initialItem: _acmstModel.classnam,
        autovalidateMode: _autoValidate,
        requiredIndicator: const Text('*', style: TextStyle(color: Colors.red)),
        items: _classlist.map((f) => f.classnm).toList(),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Select Class ';
          return null;
        },
        onChanged: (value) {
          setState(() {
            _acmstModel.classnam = value;
            for (var f in _classlist) {
              if (value.trim().toLowerCase() == f.classnm!.trim().toLowerCase()) {
                _acmstModel.classid = f.classid;
              }
            }
          });
        });
  }

  CardSettingsListPicker _buildCardSettingsListPicker_AcType() {
    return CardSettingsListPicker(
        label: 'Type',
        initialItem: _acmstModel.typenam,
        autovalidateMode: _autoValidate,
        requiredIndicator: const Text('*', style: TextStyle(color: Colors.red)),
        items: _typelist.map((f) => f.typenm).toList(),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Select Type ';
          return null;
        },
        onChanged: (value) {
          setState(() {
            _acmstModel.typenam = value;
            for (var f in _typelist) {
              if (value.trim().toLowerCase() == f.typenm!.trim().toLowerCase()) {
                _acmstModel.typeid = f.typeid;
              }
            }
          });
        });
  }

  //Address
  CardSettingsText _buildCardSettingsText_Add1() {
    return CardSettingsText(
        //key: _formKey, //_add1Key,
        label: 'Address ',
        hintText: '.',
        requiredIndicator: const Text('*', style: TextStyle(color: Colors.red)),
        initialValue: _acmstModel.add1,
        keyboardType: TextInputType.text,
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(50),
          //BlacklistingTextInputFormatter.singleLineFormatter,
          //WhitelistingTextInputFormatter(RegExp("[a-z,A-Z,0-9,-,_,.,]"))
        ],
        autovalidateMode: _autoValidate,
        validator: (value) {
          if (value == null || value.isEmpty) return 'Add. Line 1 is required.';
          return null;
        },
        onChanged: (value) {
          setState(() => _acmstModel.add1 = value);
        });
  }

  CardSettingsText _buildCardSettingsText_Add2() {
    return CardSettingsText(
        //key: _formKey, //_add2Key,
        label: '',
        hintText: '..',
        initialValue: _acmstModel.add2,
        onChanged: (value) {
          setState(() => _acmstModel.add2 = value);
          //_showSnackBar('Add2 ', value);
        });
  }

  CardSettingsText _buildCardSettingsText_Add3() {
    return CardSettingsText(
        //key: _formKey, //_add3Key,
        label: '',
        hintText: '...',
        initialValue: _acmstModel.add3,
        onChanged: (value) {
          setState(() => _acmstModel.add3 = value);
          //_showSnackBar('Add3 ', value);
        });
  }

  CardSettingsText _buildCardSettingsText_Add4() {
    return CardSettingsText(
        //key: _formKey, //_add4Key,
        label: '',
        hintText: '....',
        initialValue: _acmstModel.add4,
        onChanged: (value) {
          setState(() => _acmstModel.add4 = value);
          //_showSnackBar('Add4 ', value);
        });
  }

  CardSettingsText _buildCardSettingsText_City() {
    return CardSettingsText(
        //key: _formKey, //_cityKey,
        label: 'City ',
        hintText: '...',
        initialValue: _acmstModel.city,
        requiredIndicator: const Text('*', style: TextStyle(color: Colors.red)),
        autovalidateMode: _autoValidate,
        validator: (value) {
          if (value == null || value.isEmpty) return 'City is required.';
          return null;
        },
        onChanged: (value) {
          setState(() => _acmstModel.city = value);
          //_showSnackBar('City ', value);
        });
  }

  CardSettingsText _buildCardSettingsText_Pin() {
    return CardSettingsText(
        //key: _formKey, //_pinKey,
        label: 'Pin Code',
        initialValue: _acmstModel.pincode ?? '',
        onChanged: (value) {
          setState(() => _acmstModel.pincode = value);
          //_showSnackBar('Pin ', value);
        });
  }

  CardSettingsListPicker _buildCardSettingsListPicker_State() {
    return CardSettingsListPicker(
        //key: _formKey, //_stateKey,
        label: 'State',
        initialItem: _acmstModel.statenm,
        autovalidateMode: _autoValidate,
        items: _statelist.map((f) => f.statenm).toList(),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Select State ';
          return null;
        },
        onChanged: (value) {
          //_showSnackBar('State ', value);
          setState(() {
            _acmstModel.statenm = value;
            for (var f in _statelist) {
              if (value.trim().toLowerCase() == f.statenm!.trim().toLowerCase()) {
                _acmstModel.stateid = f.stateid;
                _acmstModel.statecd = f.statecode;
              }
            }
          });
        });
  }

  CardSettingsListPicker _buildCardSettingsListPicker_Country() {
    return CardSettingsListPicker(
        //key: _formKey, //_countryKey,
        label: 'Country',
        initialItem: _acmstModel.countrynm,
        autovalidateMode: _autoValidate,
        items: _countrylist.map((f) => f.countrynm).toList(),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Select Country ';
          return null;
        },
        onChanged: (value) {
          //_showSnackBar('Country ', value);
          setState(() {
            _acmstModel.countrynm = value;
            for (var f in _countrylist) {
              if (value.trim().toLowerCase() == f.countrynm!.trim().toLowerCase()) {
                _acmstModel.countryid = f.countryid;
              }
            }
          });
        });
  }

  //Shipping Address
  CardSettingsText _buildCardSettingsText_SAdd1() {
    return CardSettingsText(
        //key: _formKey, //_add1Key,
        label: 'Shipping Addr. ',
        hintText: '.',
        //requiredIndicator: Text('*', style: TextStyle(color: Colors.red)),
        initialValue: _acmstModel.ship_add1,
        keyboardType: TextInputType.text,
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(50),
        ],
        autovalidateMode: _autoValidate,

        /*validator: (value) {
          if (value == null || value.isEmpty) return 'Add. Line 1 is required.';
          return null;
        },*/
        onChanged: (value) {
          setState(() => _acmstModel.ship_add1 = value);
        });
  }

  CardSettingsText _buildCardSettingsText_SCity() {
    return CardSettingsText(
        //key: _formKey, //_cityKey,
        label: 'City ',
        hintText: '...',
        initialValue: _acmstModel.ship_city,
        //requiredIndicator: Text('*', style: TextStyle(color: Colors.red)),
        autovalidateMode: _autoValidate,
        /*validator: (value) {
          if (value == null || value.isEmpty) return 'City is required.';
          return null;
        },*/
        onChanged: (value) {
          setState(() => _acmstModel.ship_city = value);
          //_showSnackBar('City ', value);
        });
  }

  CardSettingsText _buildCardSettingsText_SPin() {
    return CardSettingsText(
        //key: _formKey, //_pinKey,
        label: 'Pin Code',
        initialValue: _acmstModel.ship_pincode ?? '',
        onChanged: (value) {
          setState(() => _acmstModel.ship_pincode = value);
          //_showSnackBar('Pin ', value);
        });
  }

  CardSettingsListPicker _buildCardSettingsListPicker_SState() {
    return CardSettingsListPicker(
        //key: _formKey, //_stateKey,
        label: 'State',
        initialItem: _acmstModel.ship_statenm,
        autovalidateMode: _autoValidate,
        items: _statelist.map((f) => f.statenm).toList(),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Select State ';
          return null;
        },
        onChanged: (value) {
          //_showSnackBar('State ', value);
          setState(() {
            _acmstModel.ship_statenm = value;
            for (var f in _statelist) {
              if (value.trim().toLowerCase() == f.statenm!.trim().toLowerCase()) {
                _acmstModel.ship_stateid = f.stateid;
                _acmstModel.ship_statecd = f.statecode;
              }
            }
          });
        });
  }

  CardSettingsText _buildCardSettingsText_Scp() {
    return CardSettingsText(
      //key: _formKey, //_cpKey,
      label: 'Cont.Person ',
      initialValue: _acmstModel.ship_conPer,
      onChanged: (value) => {setState(() => _acmstModel.ship_conPer = value)},
    );
  }

  CardSettingsText _buildCardSettingsText_Sll() {
    return CardSettingsText(
      //key: _formKey, //_llKey,
      label: 'Land Line ',
      hintText: 'Phone...',
      initialValue: _acmstModel.ship_landline,
      onChanged: (value) => {setState(() => _acmstModel.ship_landline = value)},
    );
  }

  CardSettingsText _buildCardSettingsText_Smobile() {
    return CardSettingsText(
      label: 'Mobile',
      initialValue: _acmstModel.ship_mobileno,
      onChanged: (value) => {setState(() => _acmstModel.ship_mobileno = value)},
      /*
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(10),
      ],
      autovalidateMode: _autoValidate,
      validator: (value) {
        if (value != null && value.toString().length < 10)
          return 'Incomplete number';
        return null;
      },*/
    );
  }

  CardSettingsEmail _buildCardSettingsSEmail() {
    return CardSettingsEmail(
      initialValue: _acmstModel.emailId,
      //autovalidateMode: _autoValidate,
      /*
      validator: (value) {
        if (value == null || value.isEmpty) return 'Email is required.';
        if (!value.contains('@'))
          return "Email not formatted correctly."; // use regex in real application
        return null;
      },*/
      onChanged: (value) => {setState(() => _acmstModel.ship_emailId = value)},
    );
  }

  CardSettingsInt _buildCardSettingsText_SDistance() {
    return CardSettingsInt(
      label: 'Distance Km',
      keyboardType: TextInputType.number,
      initialValue: _acmstModel.ship_distancekm ?? 0,
      onChanged: (value) => {setState(() => _acmstModel.ship_distancekm = value)},
    );
  }

  CardSettingsText _buildCardSettingsText_Sgst() {
    return CardSettingsText(
      label: 'Shipping GSTIN ',
      initialValue: _acmstModel.ship_gsttin,
      /*
      autovalidateMode: _autoValidate,
      validator: (value) {
        if (value == null || value.isEmpty) return 'GSTIN is required.';
        return null;
      },*/
      onChanged: (value) => {setState(() => _acmstModel.ship_gsttin = value)},
    );
  }

  CardSettingsDatePicker _buildCardSettingsDatePicker_SGstDt() {
    var parsedDate = DateTime(2023, 04, 01);
    if (_acmstModel.shipgstDt != null && _acmstModel.shipgstDt!.isNotEmpty) {
      parsedDate = DateTime.parse(_acmstModel.shipgstDt!);
    }
    return CardSettingsDatePicker(
        label: 'Shipping GstReg. Dt',
        initialValue: parsedDate,
        onSaved: (value) => {
              _acmstModel.shipgstDt = value.toString(),
            },
        onChanged: (value) {
          setState(() {
            _acmstModel.shipgstDt = value.toString();
          });
        });
  }

  // Contact
  CardSettingsText _buildCardSettingsText_cp() {
    return CardSettingsText(
      //key: _formKey, //_cpKey,
      label: 'Cont.Person ',
      initialValue: _acmstModel.conPer,
      onChanged: (value) => {setState(() => _acmstModel.conPer = value)},
    );
  }

  CardSettingsText _buildCardSettingsText_ll() {
    return CardSettingsText(
      //key: _formKey, //_llKey,
      label: 'Land Line ',
      hintText: 'Phone...',
      initialValue: _acmstModel.landline,
      onChanged: (value) => {setState(() => _acmstModel.landline = value)},
    );
  }

  CardSettingsText _buildCardSettingsText_mobile() {
    return CardSettingsText(
      label: 'Mobile',
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(10),
        //WhitelistingTextInputFormatter.digitsOnly,
      ],
      initialValue: _acmstModel.mobileno,
      autovalidateMode: _autoValidate,
      validator: (value) {
        if (value != null && value.toString().length < 10) return 'Incomplete number';
        return null;
      },
      onChanged: (value) => {setState(() => _acmstModel.mobileno = value)},
    );
  }

  CardSettingsEmail _buildCardSettingsEmail() {
    return CardSettingsEmail(
      initialValue: _acmstModel.emailId,
      autovalidateMode: _autoValidate,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Email is required.';
        if (!value.contains('@')) {
          return "Email not formatted correctly."; // use regex in real application
        }
        return null;
      },
      onChanged: (value) => {setState(() => _acmstModel.emailId = value)},
    );
  }

  // Lic
  CardSettingsText _buildCardSettingsText_gst() {
    return CardSettingsText(
      label: 'GSTIN ',
      initialValue: _acmstModel.gsttin,
      autovalidateMode: _autoValidate,
      validator: (value) {
        if (value == null || value.isEmpty) return 'GSTIN is required.';
        return null;
      },
      onChanged: (value) => {setState(() => _acmstModel.gsttin = value)},
    );
  }

  CardSettingsDatePicker _buildCardSettingsDatePicker_GstDt() {
    var parsedDate = DateTime(2023, 04, 01);
    if (_acmstModel.gstDt != null && _acmstModel.gstDt!.isNotEmpty) {
      parsedDate = DateTime.parse(_acmstModel.gstDt!);
    }
    return CardSettingsDatePicker(
        label: 'Gst Reg. Dt',
        initialValue: parsedDate,
        onSaved: (value) => {
              _acmstModel.gstDt = value.toString(),
            },
        onChanged: (value) {
          setState(() {
            _acmstModel.gstDt = value.toString();
          });
        });
  }

  CardSettingsText _buildCardSettingsText_pan() {
    return CardSettingsText(
      label: 'PAN No ',
      initialValue: _acmstModel.pan,
      onChanged: (value) => {setState(() => _acmstModel.pan = value)},
    );
  }

  CardSettingsText _buildCardSettingsText_drg() {
    return CardSettingsText(
      label: 'DrugLic ',
      initialValue: _acmstModel.drgLic,
      autovalidateMode: _autoValidate,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Drg Lic is required.';
        return null;
      },
      onChanged: (value) => {setState(() => _acmstModel.drgLic = value)},
    );
  }

  CardSettingsText _buildCardSettingsText_food() {
    return CardSettingsText(
      label: 'FoodLic ',
      initialValue: _acmstModel.foodLic,
      onChanged: (value) => {setState(() => _acmstModel.foodLic = value)},
    );
  }

  CardSettingsInt _buildCardSettingsText_Distance() {
    return CardSettingsInt(
      label: 'Distance Km',
      keyboardType: TextInputType.number,
      initialValue: _acmstModel.distancekm!,
      onChanged: (value) => {setState(() => _acmstModel.distancekm = value)},
    );
  }

  CardSettingsListPicker _buildCardSettingsListPicker_Transport() {
    return CardSettingsListPicker(
        label: 'Transporter',
        initialItem: _acmstModel.transportnm,
        autovalidateMode: _autoValidate,
        items: _transplist.map((f) => f.transnm).toList(),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Select Transporter ';
          return null;
        },
        onChanged: (value) {
          _showSnackBar('Transporter ', value);
          setState(() {
            _acmstModel.transportnm = value;
            for (var f in _transplist) {
              if (value.trim().toLowerCase() == f.transnm!.trim().toLowerCase()) {
                _acmstModel.transportid = f.transid;
              }
            }
          });
        });
  }

  // Misc
  CardSettingsText _buildCardSettingsText_Route() {
    return CardSettingsText(
      label: 'Route Sr ',
      initialValue: _acmstModel.routeSr,
      onChanged: (value) => {setState(() => _acmstModel.routeSr = value)},
    );
  }

  CardSettingsListPicker _buildCardSettingsListPicker_Bank() {
    return CardSettingsListPicker(
        label: 'Bank',
        initialItem: _acmstModel.banknam,
        autovalidateMode: _autoValidate,
        items: _banklist.map((f) => f.banknm).toList(),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Select Bank ';
          return null;
        },
        onChanged: (value) {
          _showSnackBar('Bank ', value);
          setState(() {
            _acmstModel.banknam = value;
            for (var f in _banklist) {
              if (value.trim().toLowerCase() == f.banknm!.trim().toLowerCase()) {
                _acmstModel.bankid = f.bankid;
              }
            }
          });
        });
  }

  CardSettingsListPicker _buildCardSettingsListPicker_Branch() {
    return CardSettingsListPicker(
        label: 'Branch',
        initialItem: _acmstModel.branchnam,
        autovalidateMode: _autoValidate,
        items: _branchlist.map((f) => f.branchnm).toList(),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Select Branch ';
          return null;
        },
        onChanged: (value) {
          _showSnackBar('Brnch ', value);
          setState(() {
            _acmstModel.branchnam = value;
            for (var f in _branchlist) {
              if (value.trim().toLowerCase() == f.branchnm!.trim().toLowerCase()) {
                _acmstModel.branchid = f.branchid;
              }
            }
          });
        });
  }

  CardSettingsListPicker _buildCardSettingsListPicker_Payment() {
    return CardSettingsListPicker(
        label: 'Payment',
        initialItem: _acmstModel.paynam,
        autovalidateMode: _autoValidate,
        items: _paylist.map((f) => f.paynm).toList(),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Select Payment Mode ';
          return null;
        },
        onChanged: (value) {
          _showSnackBar('Payment ', value);
          setState(() {
            _acmstModel.paynam = value;
            for (var f in _paylist) {
              if (value.trim().toLowerCase() == f.paynm!.trim().toLowerCase()) {
                _acmstModel.payid = int.parse(f.payid!);
              }
            }
          });
        });
  }

  //GPS
  CardSettingsButton _buildCardSettingsButton_Gps() {
    return CardSettingsButton(
        label: 'Get Location',
        onPressed: () {
          _getloc();
          setState(() {
            _acmstModel.gpslat = double.parse(_lat.toString());
            _acmstModel.gpslon = double.parse(_lon.toString());
          });
        });
  }

  CardSettingsDouble _buildCardSettingsText_GpsLat() {
    return CardSettingsDouble(
      //key: _formKey, //_gpslatKey,
      label: 'Latitude',
      initialValue: _acmstModel.gpslat,
      onChanged: (value) => {setState(() => _acmstModel.gpslat = value)},
    );
  }

  CardSettingsDouble _buildCardSettingsText_GpsLon() {
    return CardSettingsDouble(
      label: 'Longitude',
      initialValue: _acmstModel.gpslon,
      onChanged: (value) => {setState(() => _acmstModel.gpslon = value)},
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_Active() {
    return CardSettingsSwitch(
      label: 'In-Active ?',
      initialValue: _acmstModel.inactive ?? false,
      onChanged: (value) {
        setState(() => _acmstModel.inactive = value);
      },
    );
  }

  CardSettingsText _buildCardSettingsText_InactiveRsn() {
    return CardSettingsText(
      label: 'Reason',
      initialValue: _acmstModel.inactivereason,
      visible: _acmstModel.inactive == 1 ? true : false,
      onChanged: (value) {
        setState(() => _acmstModel.inactivereason = value);
      },
    );
  }

  void _showSnackBar(String label, dynamic value) {
    print('$label = $value');
    /*_acmstKey.currentState.removeCurrentSnackBar();
    _acmstKey.currentState.showSnackBar(
      SnackBar(
        content: Text(label + ' = ' + value.toString()),
      ),
    );*/
  }

  Future<ConfirmMstAction?> _asyncConfirmDialog(
      BuildContext context, int ind, String demostat) async {
    return showDialog<ConfirmMstAction>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              children: <Widget>[
                Text(
                  _acmstModel.acmstname!,
                  style: TextStyle(color: Colors.blue.shade500, fontSize: 14.0),
                ),
              ],
            ),
            content: const Text(
              'Save',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop(ConfirmMstAction.CANCEL);
                },
              ),
              TextButton(
                child: const Text('ACCEPT'),
                onPressed: () {
                  Navigator.of(context).pop(ConfirmMstAction.ACCEPT);
                },
              )
            ],
          );
        });
  }

  Future _savePressed() async {
    print('_savePressed...');
    final form = _formKey.currentState;
    form!.save();
    _saveacmst();
  }

  void _saveacmst() async {
    debugPrint('Save Clicked');
    setState(() {
      _acmstModel.gstRegDt = DateTime.parse(_acmstModel.gstDt!);
    });
    print('Gst Date is ${_acmstModel.gstRegDt}');

    String qryparam = 'DbName=${appData.log_dbnm!}&ac_id=${_acmstModel.acmstid}&Grp_Id=${_acmstModel.acgrpid}&Ac_Nm=${_acmstModel.acmstname!}&Ac_Code=${_acmstModel.acmstcode!}&Open_Bal=${_acmstModel.acopn}&Add_1=${_acmstModel.add1!}&Add_2=${_acmstModel.add2!}&Add_3=${_acmstModel.add3!}&Add_4=${_acmstModel.add4!}&City=${_acmstModel.city!}&Pin=${_acmstModel.pincode}&state_id=${_acmstModel.stateid}&distance_km=${_acmstModel.distancekm}&TRANSPORTER_ID=${_acmstModel.transportid}&Phone_No=${_acmstModel.landline!}&Mobile_No=${_acmstModel.mobileno!}&Contact_Nm=${_acmstModel.conPer!}&gstin=${_acmstModel.gsttin!}&GSTIN_Reg_Dt=${dfmdy.format(_acmstModel.gstRegDt!)}&Pan_No=${_acmstModel.pan!}&Drug_Lic_No=${_acmstModel.drgLic!}&Food_Lic_No=${_acmstModel.foodLic!}&Email_Id=${_acmstModel.emailId!}&Beat_Id=${_acmstModel.beatid}&Class_Id=${_acmstModel.classid}&Type_Id=${_acmstModel.typeid}&Route_Sr=${_acmstModel.routeSr!}&InActive=${_acmstModel.inactive}&InActive_Reason=${_acmstModel.inactivereason!}&Bank_Id=${_acmstModel.bankid}&Branch_Id=${_acmstModel.branchid}&Pay_Mode=${_acmstModel.payid}&Latitude=${_acmstModel.gpslat}&Longitude=${_acmstModel.gpslon}&Tax_Invoice=1&retval=0';

    print("${appData.baseurl!}ac_mst_add?$qryparam");
    String resmsg = "";
    http.Response res = await doacmstpost("${appData.baseurl!}ac_mst_add?$qryparam");
    //_showSnackBar('Error ', resmsg);
    //print(response.body);
    var route = MaterialPageRoute(builder: (BuildContext context) => const PartyHomeScreen());
    Navigator.of(context).push(route);
  }

  Future<http.Response> doacmstpost(String acurl) async {
    Map<String, String> headersMap = {'Content-Type': 'application/json'};
    Map<String, dynamic> userData = {'dummy': 'dummy'};
    await http
        .post(acurl as Uri, body: json.encode(userData), headers: headersMap)
        .then((http.Response response) {
      return response.statusCode;
    });
    throw '';
  }

  void validateAcEntry() {
    /*
    setState(() {
      // Acname
      if (_acmstModel.acmstname == null || _acmstModel.acmstname.length == 0)
        _acmstModel.acname_error = ' Name is required';
      if (_acmstModel.acmstname.length > _acmstModel.acname_maxlen)
        _acmstModel.acname_error =
            'Name must not be greater than $_acmstModel.acname_maxlen characters';
      if (_acmstModel.acmstname.length <= 3)
        _acmstModel.acname_error = 'Name must be greater than 3 characters';

      // Accode
      if (_acmstModel.acmstcode == null || _acmstModel.acmstcode.isEmpty)
        _acmstModel.accode_error = ' Code is required';
      if (_acmstModel.acmstcode.length > _acmstModel.accode_maxlen)
        _acmstModel.accode_error =
            'Code must not be greater than $_acmstModel.accode_maxlen characters';

      // Group
      if (_acmstModel.acgrpid == 0)
        _acmstModel.acgrp_error = ' Group is required';

      // Accode
      if (_acmstModel.add1 == null || _acmstModel.add1.isEmpty)
        _acmstModel.acadd1_error = ' Add Line 1 is required';
      if (_acmstModel.add1.length > _acmstModel.acadd1_maxlen)
        _acmstModel.acadd1_error =
            'Add1 must not be greater than $_acmstModel.acadd1_maxlen characters';

      // Beat
      if (_acmstModel.beatid == 0)
        _acmstModel.acbeat_error = ' Beat is required';

      // Type
      if (_acmstModel.typeid == 0)
        _acmstModel.actype_error = ' Type is required';

      // Class
      if (_acmstModel.classid == 0)
        _acmstModel.acclass_error = ' Class is required';

      // State
      if (_acmstModel.stateid == 0)
        _acmstModel.acstate_error = ' State is required';

      // Country
      if (_acmstModel.countryid == 0)
        _acmstModel.accountry_error = ' Country is required';

      if (_acmstModel.accode_error.length > 0 ||
          _acmstModel.acname_error.length > 0 ||
          _acmstModel.acgrp_error.length > 0 ||
          _acmstModel.acbeat_error.length > 0 ||
          _acmstModel.actype_error.length > 0 ||
          _acmstModel.acclass_error.length > 0 ||
          _acmstModel.acstate_error.length > 0 ||
          _acmstModel.accountry_error.length > 0 ||
          _acmstModel.gstin_error.length > 0 ||
          _acmstModel.acadd1_error.length > 0) _acmstModel.haserror = true;
    });
    */
  }
}