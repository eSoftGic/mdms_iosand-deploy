// ignore_for_file: unused_field, unused_local_variable, library_private_types_in_public_api, non_constant_identifier_names, unused_element, avoid_print, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, unrelated_type_equality_checks

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mdms_iosand/src/ecommerce/screen/home_screen.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
//import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mdms_iosand/src/constants/constants.dart';
import 'package:mdms_iosand/singletons/singletons.dart';
import 'package:mdms_iosand/src/features/authentication/models/models.dart';

import 'package:mdms_iosand/src/features/authentication/screens/setup/tabindicator.dart';
import '../../../../common_widgets/form/form_header_widget.dart';
//import '../../../core/screens/dashboard/dashboard.dart';

class LoginSetupPage extends StatefulWidget {
  const LoginSetupPage({super.key});
  @override
  _LoginSetupPageState createState() => _LoginSetupPageState();
}

class _LoginSetupPageState extends State<LoginSetupPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isloading = false;
  String _identifier = '';
  String baseUrl = "http://";
  String _devid = "";
  int _mySmanId = 0;
  int _myUserId = 0;
  String _myEdmsPort = '';
  String _myEdmsIp = "";
  int _myPrtId = 0;
  int _myDlrId = 0;
  int _myDmanId = 0;
  String _myFirmSelection = "";
  String _myDbName = "";
  int _myBranchId = 0;
  String _myFirmName = "";
  String _myCoyr = "";
  String _myBranchName = "";
  String _myUserType = "";
  String _myUserName = "";
  String _myUserPass = "";
  String _myIp = "";
  String _mySmanBeat = "";
  String _mySmanComp = "";
  String _myForBuk = "";
  String _myDlvIp = "";

  String _acstdt = "";
  String _acendt = "";
  String _acmxdt = "";

  int _mybillissno = 0;
  String _serverErr = "";
  bool validuser = false;
  bool validfirm = false;
  bool validyear = false;
  bool validbranch = false;
  bool _centralorder = false;

  String _myprtnm = "";
  String _mysaltyp = "";
  bool _mychain = false;

  // Login
  final FocusNode myFocusHttp = FocusNode();
  final FocusNode myFocusUser = FocusNode();
  final FocusNode myFocusPassword = FocusNode();
  TextEditingController loginUserController = TextEditingController();
  TextEditingController loginHttpController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  bool _obscureTextLogin = true;

  //Page
  late PageController _pageController;
  Color left = tPrimaryColor; //Colors.black;
  Color right = tAccentColor; //Colors.white;

  // Setup
  List<AppUser> _user = [];
  List<PrtUser> _prtuser = [];
  List<Firm> _firms = [];
  List<AcYear> _years = [];
  List<Branch> _branch = [];
  List<SmanBeat> _sbeat = [];

  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            throw '';
          },
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height >= 775.0
                  ? MediaQuery.of(context).size.height
                  : 775.0,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [tCardLightColor, Colors.white],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                  ),
                  FormHeaderWidget(
                    image: tWelcomeScreenImage,
                    title: tAppName,
                    subTitle: _identifier,
                    imageHeight: 0.1,
                    textAlign: TextAlign.center,
                    fsize: 14,
                  ),
                  const SizedBox(
                    height: tDefaultSize,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: _buildMenuBar(context),
                  ),
                  Expanded(
                    flex: 2,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (i) {
                        if (i == 0) {
                          setState(() {
                            right = Colors.white;
                            left = Colors.black;
                          });
                        } else if (i == 1) {
                          setState(() {
                            right = Colors.black;
                            left = Colors.white;
                          });
                        }
                      },
                      children: <Widget>[
                        ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                          child: _buildSignIn(context),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                          child: _buildSetup(context), //_buildChange(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            /*Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height >= 775.0
                  ? MediaQuery.of(context).size.height
                  : 775.0,
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [tAccentColor, tPrimaryColor],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: tDefaultSize,
                  ),
                  FormHeaderWidget(
                    image: tWelcomeScreenImage,
                    title: tAppName,
                    subTitle: _identifier,
                    imageHeight: 0.1,
                    textAlign: TextAlign.center,
                    fsize: 18,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: _buildMenuBar(context),
                  ),
                  Expanded(
                    flex: 2,
                    child: PageView(
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      pageSnapping: true,
                      clipBehavior: Clip.hardEdge,
                      onPageChanged: (i) {
                        if (i == 0) {
                          setState(() {
                            right = Colors.white;
                            left = Colors.black;
                          });
                        } else if (i == 1) {
                          setState(() {
                            right = Colors.black;
                            left = Colors.white;
                          });
                        }
                      },
                      children: <Widget>[
                        ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                          child: _buildSignIn(context),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints.expand(width: 300, height: 300),
                          child: _buildSetup(context), //_buildChange(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),*/
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    myFocusPassword.dispose();
    myFocusUser.dispose();
    myFocusHttp.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _pageController = PageController();
    initUniqueIdentifierState();
    loadpref();
  }

  Future<void> initUniqueIdentifierState() async {
    String identifier;
    try {
      _identifier = (await UniqueIdentifier.serial)!;
    } on PlatformException {
      _identifier = 'Failed to get Unique Identifier';
    }
    if (!mounted) return;
    setState(() {
      _devid = _identifier;
      appData.log_deviceid = _identifier;
    });
  }

  Widget _NewbuildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: const BoxDecoration(
        color: tPrimaryColor,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: TextButton(
                onPressed: _onSignInButtonPress,
                child: Text(
                  "API",
                  style: TextStyle(
                    color: left,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: TextButton(
                onPressed: _onSignUpButtonPress,
                child: Text(
                  "Settings",
                  style: TextStyle(
                    color: right,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _NewbuildSignIn(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          Card(
            elevation: 2.0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: SizedBox(
              width: 300.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
                    child: TextFormField(
                      controller: loginHttpController,
                      focusNode: myFocusHttp,
                      keyboardType: TextInputType.url,
                      style: const TextStyle(fontSize: 18),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            LineAwesomeIcons.server,
                            size: 18,
                            color: tPrimaryColor,
                          ),
                          labelText: 'API Url',
                          hintText: 'API URL'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
                    child: TextFormField(
                      focusNode: myFocusUser,
                      controller: loginUserController,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontSize: 18),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            LineAwesomeIcons.user,
                            size: 18,
                            color: tPrimaryColor,
                          ),
                          labelText: 'User Name',
                          hintText: 'Username'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
                    child: TextFormField(
                      focusNode: myFocusPassword,
                      controller: loginPasswordController,
                      obscureText: _obscureTextLogin,
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: const Icon(
                          Icons.fingerprint,
                          size: 18.0,
                          color: tPrimaryColor,
                        ),
                        hintText: "Password",
                        suffixIcon: GestureDetector(
                          onTap: _toggleLogin,
                          child: const Icon(
                            Icons.visibility_off,
                            size: 18.0,
                            color: tPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: tDefaultSize,
          ),
          SizedBox(
            width: 300.0,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(tPrimaryColor)),
              onPressed: () {
                setState(() {
                  _isloading = true;
                });
                setbaseurl();
                savebasicpref();
                checkuser();
              },
              child: _isloading
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text("Connecting..")
                      ],
                    )
                  : const Text('Connect'),
            ),
          ),
        ],
      ),
    );
  }

  /*Widget _NewbuildSetup(BuildContext context) {
    return Container(
      height: 260,
      width: 300,
      padding: EdgeInsets.only(top: 30.0),
      child: Column(children: <Widget>[
        Card(
          elevation: 2.0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: tPrimaryColor,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: SizedBox(
            width: 300.0,
            height: 230.0,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 0.0),
                  child: _showfirmDd(),
                ),
                Container(
                  width: 260.0,
                  height: 1.0,
                  color: tPrimaryColor,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 0.0),
                  child: _showyearDd(),
                ),
                Container(
                  width: 260.0,
                  height: 1.0,
                  color: tPrimaryColor,
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 5.0),
                    child: _showbranchDd()),
              ],
            ),
          ),
        ),
        SizedBox(
          height: tDefaultSize,
        ),
        SizedBox(
          width: 300.0,
          child: ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(tPrimaryColor)),
            onPressed: () {
              setState(() {
                _isloading = true;
              });
              if (validbranch == true) {
                setddvars();
                savepref();
                showdashboard();
              } else {}
            },
            child: _isloading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text("Initialising..")
                    ],
                  )
                : Text('OK'),
          ),
        ),
        //_showHomebtn(),
      ]),
    );
  }*/

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: const BoxDecoration(
        color: tCardLightColor, //Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: TextButton(
                onPressed: _onSignInButtonPress,
                child: Text(
                  "Connect",
                  style: TextStyle(
                      color: left,
                      fontSize: 20.0,
                      fontFamily: "WorkSansSemiBold"),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: TextButton(
                onPressed: _onSignUpButtonPress,
                child: Text(
                  "Firm",
                  style: TextStyle(
                      color: right,
                      fontSize: 20.0,
                      fontFamily: "WorkSansSemiBold"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40.0),
      child: Column(
        children: <Widget>[
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SizedBox(
                  width: 300.0,
                  height: 230.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusHttp,
                          controller: loginHttpController,
                          keyboardType: TextInputType.url,
                          //style: Theme.of(context).textTheme.headlineMedium,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: const Icon(
                              LineAwesomeIcons.server,
                              size: 28.0,
                            ),
                            hintText: "Server Ip",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontSize: 14),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: tAccentColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusUser,
                          controller: loginUserController,
                          keyboardType: TextInputType.text,
                          //style: Theme.of(context).textTheme.headlineMedium,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: const Icon(
                              LineAwesomeIcons.user,
                              size: 28.0,
                            ),
                            hintText: "Username",
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.lightBlue,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusPassword,
                          controller: loginPasswordController,
                          obscureText: _obscureTextLogin,
                          //style: Theme.of(context).textTheme.headlineMedium,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: const Icon(
                              LineAwesomeIcons.key,
                              size: 28.0,
                            ),
                            hintText: "Password",
                            hintStyle: const TextStyle(
                                fontFamily: "Montserrat-Medium",
                                fontSize: 16.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: const Icon(
                                LineAwesomeIcons.eye,
                                size: 24.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 250.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: tCardLightColor,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: tWhiteColor,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: LinearGradient(
                      colors: [tCardLightColor, Colors.white],
                      begin: FractionalOffset(0.2, 0.2),
                      end: FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    //splashColor: Theme.Colors.loginGradientEnd,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "CONNECT",
                        style: TextStyle(
                            color: tPrimaryColor,
                            fontSize: 20.0,
                            fontFamily: "Montserrat-Medium"),
                      ),
                    ),
                    onPressed: () {
                      setbaseurl();
                      savebasicpref();
                      checkuser();
                    }),
              ),
            ],
          ),

          //),
        ],
      ),
    );
  }

  Widget _buildSetup(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50.0),
      child: Column(
        children: <Widget>[
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: <Widget>[
              Card(
                elevation: 8.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SizedBox(
                  width: 300.0,
                  height: 230.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 10.0, right: 0.0),
                        child: _showfirmDd(),
                      ),
                      Container(
                        width: 300.0,
                        height: 1.0,
                        color: Colors.blue[400],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 10.0, right: 0.0),
                        child: _showyearDd(),
                      ),
                      Container(
                        width: 300.0,
                        height: 1.0,
                        color: Colors.lightBlue,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 10.0, left: 10.0, right: 25.0),
                          child: _showbranchDd()),
                    ],
                  ),
                ),
              ),
              _showHomebtn(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _showHomebtn() {
    return validbranch
        ? Container(
            margin: const EdgeInsets.only(top: 250.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: tCardLightColor,
                  offset: Offset(1.0, 6.0),
                  blurRadius: 20.0,
                ),
                BoxShadow(
                  color: tWhiteColor,
                  offset: Offset(1.0, 6.0),
                  blurRadius: 20.0,
                ),
              ],
              gradient: LinearGradient(
                  colors: [tCardLightColor, Colors.white],
                  begin: FractionalOffset(0.2, 0.2),
                  end: FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: MaterialButton(
                highlightColor: Colors.transparent,
                //splashColor: Theme.Colors.loginGradientEnd,
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                  child: Text(
                    "START",
                    style: TextStyle(
                        color: tPrimaryColor,
                        fontSize: 20.0,
                        fontFamily: "Montserrat-Medium"),
                  ),
                ),
                onPressed: () {
                  setddvars();
                  savepref();
                  showdashboard();
                }),
          )
        : const SizedBox(
            height: 10,
          );
  }

  Widget _NewshowHomebtn() {
    return validbranch
        ? SizedBox(
            width: 300.0,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(tAccentColor)),
              onPressed: () {
                setddvars();
                savepref();
                showdashboard();
              },
              child: _isloading
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text("SAVING SELECTION")
                      ],
                    )
                  : const Text('OK'),
            ),
          )
        : const Text('');

    /*Container(
            margin: EdgeInsets.only(top: 225.0),
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: MaterialButton(
                highlightColor: Colors.transparent,
                splashColor: tPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 42.0),
                  child: Text(
                    "START",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontFamily: "Montserrat-Medium"),
                  ),
                ),
                onPressed: () async {
                  setddvars();
                  savepref();
                  //print('showdashboard');
                  showdashboard();
                }),
          )
        : Container();*/
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    if (validuser == true) {
      //Get.snackbar('OK', 'Select Firms & Other Details');

      debugPrint('onsignupbuttonpress .. loading pref');
      loadpref();

      debugPrint('Firm $_myFirmSelection');
      debugPrint('DbName $_myDbName');
      debugPrint('BrnId $_myBranchId');
      debugPrint('Brnname $_myBranchName');
      debugPrint('Central Order $_centralorder.toString()');

      if (validuser == true) {
        loadfirms();
        if (_myFirmSelection.isNotEmpty) {
          validfirm = true;
          loadyear();
        }
        if (_myDbName.isNotEmpty) {
          validyear = true;
          loadbranch();
        }
        if (_myBranchId > 0) {
          validbranch = true;
        }
      }

      _pageController.animateToPage(1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.decelerate);
    } else {
      Get.snackbar('Error', 'Enter Login Details First');
    }
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
      _devid = _identifier;
    });
  }

  void loadpref() async {
    //print('loading pref');
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _myUserName = prefs.get('spUserName').toString() == 'null'
          ? ''
          : prefs.get('spUserName').toString();
      _myUserPass = prefs.get('spUserPass').toString() == 'null'
          ? ''
          : prefs.get('spUserPass').toString();
      _myIp = prefs.get('spIp').toString() == 'null'
          ? ''
          : prefs.get('spIp').toString();

      loginUserController.text = _myUserName == 'null' ? '' : _myUserName;
      loginPasswordController.text = _myUserPass == 'null' ? '' : _myUserPass;
      loginHttpController.text = _myIp == 'null' ? '' : _myIp;

      _mySmanId = int.tryParse(prefs.get('spSmanId').toString()) ?? 0;
      _myFirmSelection = prefs.get('spFrim').toString();
      _myFirmName = prefs.get('spFirmName').toString();
      _myCoyr = prefs.get('spCoYr').toString();
      _myDbName = prefs.get('spDbName').toString();
      _myBranchId = int.tryParse(prefs.get('spBrnId').toString()) ?? 0;
      _myBranchName = prefs.get('spBranchName').toString();
      _myUserType = prefs.get('spUserType').toString();
      _mySmanBeat = prefs.get('spSmanBeat').toString();
      _myDmanId = int.tryParse(prefs.get('spDmanId').toString()) ?? 0;
      _myDlrId = int.tryParse(prefs.get('spDlrId').toString()) ?? 0;
      _acstdt = prefs.get('spacstdt').toString();
      _acendt = prefs.get('spacendt').toString();
      _acmxdt = prefs.get('spacmxdt').toString();
      _centralorder =
          (int.tryParse(prefs.get('spcentralorder').toString()) ?? 0) == 1
              ? true
              : false;

      validfirm = _myFirmSelection.toString().isNotEmpty;
      validyear = _myCoyr.toString().isNotEmpty;
      validbranch = _myBranchId > 0;
      appData.commonorder = _centralorder;

      appData.log_name = _myUserName;
      appData.log_id = _myUserId;
      appData.log_deviceid = _identifier;
      appData.log_branch = _myBranchName;
      appData.log_branchid = _myBranchId;
      appData.log_coid = _myFirmSelection.toString();
      appData.log_conm = _myFirmName;
      appData.log_coyr = _myCoyr;
      appData.log_dbnm = _myDbName;
      appData.log_smanid = _mySmanId;
      appData.log_dmanid = _myDmanId;
      appData.log_dlrid = _myDlrId;

      appData.log_ip = _myIp.trim();
      appData.log_smnbeat = _mySmanBeat;
      appData.log_type = _myUserType;
      appData.prtid = 0;
      appData.prtnm = "";
      appData.ordrefno = 0;
      appData.cologo = "assets/img/smdms.png";
      if (_myIp.trim().isNotEmpty) {
        appData.baseurl = 'http://${_myIp.trim()}/api/';
        appData.pdfbaseurl = 'http://${_myIp.trim()}/pdf/';
        appData.cologo = '${appData.pdfbaseurl}co_logo.png';
      }

      //print('cologo ' + appData.cologo.toString());
      appData.demover = false;
      if (appData.log_name!.toLowerCase() == "demo") {
        appData.demover = true;
        appData.log_conm = "Demo Version";
      }
    });
  }

  void setbaseurl() {
    setState(() {
      baseUrl = 'http://${loginHttpController.text.toString().trim()}/api/';
      _myUserName = loginUserController.text.toString();
      _myUserPass = loginPasswordController.text.toString();
      _myIp = loginHttpController.text.toString().trim();
      _myEdmsIp = loginHttpController.text.toString().trim();
    });
  }

  void checkuser() async {
    String msg = '';
    String lat = '0.0';
    String lon = '0.0';
    //_lat = appData.currgeolat! != null ? appData.currgeolat! : '';
    //_lon = appData.currgeolon! != null ? appData.currgeolon! : '';
    appData.demover = false;
    appData.demover = (loginUserController.text.trim().toLowerCase() == "demo");
    String pwd = loginPasswordController.text.trim();
    pwd = pwd.replaceAll('@', '%40').replaceAll('#', '%23').toString().trim();
    final String usrchkmurl =
        "checkuser?UserNm=${loginUserController.text.trim()}&UserPs=$pwd&DeviceId=$_devid&Latitude=$lat&Longitude=$lon";
    //"checkuser?UserNm=${loginUserController.text.trim()}&UserPs=$pwd&DeviceId=$_devid&Latitude=$lat&Longitude=$lon&WDMS_VER_DT=$appData.wdmsver&MDMS_VER_DT=$appData.mdmsver&MDMS_VER_NO=$appData.mdmsverno";

    //debugPrint(baseUrl + usrchkmurl);
    var url = Uri.parse(baseUrl + usrchkmurl);
    debugPrint(url.toString());
    _centralorder = false;
    setState(() {
      _isloading = false;
    });
    try {
      var res = await http.get(url, headers: {"Accept": "application/json"});
      debugPrint(res.statusCode.toString());
      if (res.statusCode == 200) {
        String resBody = res.body;
        debugPrint(resBody);
        if (resBody != "null") {
          final jsonBody = json.decode(resBody);
          _user = (jsonBody)
              .map<AppUser>((item) => AppUser.fromJson(item))
              .toList();
          debugPrint('User ' + _user.toString());
          setState(() {
            for (var f in _user) {
              _myUserId = f.userstatus!;
              _myUserType = f.usertype.toString().trim();
              debugPrint('usertype $_myUserType');
              _mySmanId = f.smanid!; // this will be stored on getbranch
              _myPrtId = f.acid!; // this will be stored on getbranch
              _myDmanId = f.dmanid!; // this will be stored on getbranch
              _myDlrId = f.acid!;
              _centralorder = f.commonorder ?? false;
              _myEdmsPort = f.edmsport.toString().trim();
              appData.commonorder = _centralorder;
              appData.edmsport = _myEdmsPort;
              appData.log_dlrid = _myDlrId;
              // EdmsUrl
              debugPrint(' edms port ' + appData.edmsport.toString());
              debugPrint('Generationg Edms base url');
              _myEdmsIp = _myIp.substring(0, _myIp.length - 4);
              debugPrint(_myEdmsIp);
              appData.edmsurl = 'http://$_myEdmsIp$_myEdmsPort/';
              debugPrint('edms url ' + appData.edmsurl.toString());

              //print(' on chk user comn ord ' + appData.commonorder.toString());
              // store delivery api if DMAN
              if (_myUserType == 'DMAN') {
                //print('Generationg Dlv base url');
                //print(_myIp);
                _myDlvIp = _myIp.substring(0, _myIp.length - 4);
                appData.deliveryurl = 'http://${_myDlvIp}8086/api/';
                //print(appData.deliveryurl);
              }
              appSecure.addac = f.addac;
              appSecure.editac = f.editac;
              appSecure.viewac = f.viewac;
              appSecure.addcasrcpt = f.addcasrcpt;
              appSecure.addchqrcpt = f.addchqrcpt;
              appSecure.addorder = f.addorder;
              appSecure.editorder = f.editorder;
              appSecure.showledger = f.showledger;
              appSecure.showos = f.showos;
              appSecure.showstock = f.showstock;
              appSecure.rtwithtax = 0;
              appSecure.showcrnt = f.showcrnt;
              appSecure.shareos = f.shareos;
              appSecure.sharegrl = f.sharegrl;
              appSecure.shareos = f.shareos;
              appSecure.sharecrnt = f.sharecrnt;
              appSecure.chklocation = f.chklocation ?? false;
              appSecure.allowdistance = f.allowlocdistance ?? 50;
              appSecure.showitemstock = f.showitemstock ?? true;
              // Refresh at Company Selection
              appSecure.noorderoption = f.noorderoption ?? false;
              appSecure.partysearchmethod = f.partysearchmethod ?? "CONTAINS";
              appSecure.itmsearchmethod = f.itmsearchmethod ?? "CONTAINS";
              appSecure.namecontains = true;
              appSecure.itemcontains = true;
              appSecure.addqot = f.addqot;
              appSecure.editqot = f.editqot;
              appSecure.shareqot = f.shareqot;
              appSecure.showqot = true;
              appSecure.showhistory = true; //f.showhistory;
              if (appSecure.addqot == false && appSecure.editqot == false) {
                appSecure.showqot = false;
              }
              validuser = false;
              // Check for Errors where userid < 0
              if (_myUserId <= 0) {
                switch (_myUserId) {
                  case -1:
                    {
                      msg = "$_myUserType : Wrong Password !!";
                    }
                    break;
                  case -2:
                    {
                      msg = "$_myUserType : User Device not registered !!";
                    }
                    break;
                  case -3:
                    {
                      msg = "$_myUserType : Licence nos. limit reached !!";
                    }
                    break;
                  case -9:
                    {
                      msg = "$_myUserType : Min. version required..";
                    }
                    break;
                  case -10:
                    {
                      msg = 'Minimum version ${appData.mdmsver} is required ';
                    }
                    break;
                  case -11:
                    {
                      msg = "$_myUserType : Demo period over..";
                    }
                    break;
                  default:
                    {
                      msg = "$_myUserType : Login Error $_myUserId";
                    }
                }
                Get.snackbar("Login", msg,
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 7));
              }
              if (_myUserId > 0) {
                validuser = true;
                msg = '${loginUserController.text} ($_myUserType)';
                loadfirms();
                _onSignUpButtonPress();
                Get.snackbar("Welcome", msg,
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 10));
              }
            }
          });
        } // res is not null
        else {
          Get.snackbar("Server error", res.statusCode.toString(),
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 7));
        }
      } else {
        Get.snackbar("Status", res.statusCode.toString(),
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 7));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void savebasicpref() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('spUserName', _myUserName);
    prefs.setString('spUserPass', _myUserPass);
    prefs.setString('spIp', _myIp);
  }

  Future<void> getprtuser() async {
    //print('getprtuser');
    var qryparam =
        "DbName=${appData.log_dbnm!}&Branch_Id=$_myBranchId&ac_id=$_myPrtId&Route_Sr_Wise=0&Order_Status=ALL&SmanId=0&BEAT_ID_STR=";
    var url = "${appData.baseurl!}party_list?$qryparam";
    //print(url.toString());
    var res =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    //print(res.statusCode.toString());
    if (res.statusCode == 200) {
      String resBody = res.body;
      //print(res.body);
      if (resBody != "null") {
        final jsonBody = json.decode(resBody);
        _prtuser =
            (jsonBody).map<PrtUser>((item) => PrtUser.fromJson(item)).toList();
        setState(() {
          _myprtnm = _prtuser[0].acnm!;
          _mysaltyp = _prtuser[0].saletype!;
          _mychain = _prtuser[0].anychain!;
          _myPrtId = _prtuser[0].acid!;
          _myDlrId = _prtuser[0].acid!;
        });
      }
      appData.prtid = _myPrtId;
      appData.log_dlrid = _myDlrId;
      appData.prtnm = _myprtnm;
    }
  }

  void loadfirms() async {
    final String firmurl = "firm?UserId=${_myUserId.toString().trim()}";
    var url = Uri.parse(baseUrl + firmurl);
    var res = await http.get(url, headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      String resBody = res.body;
      if (resBody != "null") {
        final jsonBody = json.decode(resBody);
        _firms = (jsonBody).map<Firm>((item) => Firm.fromJson(item)).toList();
        setState(() {
          _myFirmSelection = _myFirmSelection == '' ? "0" : _myFirmSelection;
          for (var f in _firms) {
            _myFirmSelection = _firms[0].coid.toString().trim();
            appSecure.rtwithtax = _firms[0].rtwithtax;
            appSecure.noorderoption =
                _firms[0].noorderoption == 0 ? false : true;
            appSecure.partysearchmethod = _firms[0].partysearchmethod;
            appSecure.itmsearchmethod = _firms[0].itmsearchmethod;
            appSecure.itemcontains =
                appSecure.itmsearchmethod.toString().contains("BEGIN")
                    ? false
                    : true;

            appSecure.namecontains =
                appSecure.partysearchmethod.toString().contains("BEGIN")
                    ? false
                    : true;
          }
        });
      }
    } else {
      Get.snackbar('Error', 'Error Fething data from api endpoint');
    }
  }

  Widget _showfirmDd() {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 16.0, bottom: 16.0, left: 8.0, right: 8.0),
          child: validuser
              ? Row(
                  children: <Widget>[
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: const Text('Select Firm'),
                        value: _myFirmSelection,
                        isDense: true,
                        onChanged: (newValue) {
                          setState(() {
                            _myFirmSelection = newValue.toString();
                            validfirm = true;
                            loadyear();
                          });
                        },
                        items: _firms.map((Firm f) {
                          return DropdownMenuItem<String>(
                            value: f.coid.toString(),
                            child: Text(
                              f.conm!,
                              //style: Theme.of(context).textTheme.headlineSmall,
                              softWrap: true,
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                )
              : Container(),
        ),
      ),
    );
  }

  void loadyear() async {
    final String yrurl = "yearlist?CoId=${_myFirmSelection.toString().trim()}";
    print(yrurl);
    var url = Uri.parse(baseUrl + yrurl);
    var res = await http.get(url, headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      String resBody = res.body;
      if (resBody != "null") {
        final jsonBody = json.decode(resBody);
        _years =
            (jsonBody).map<AcYear>((item) => AcYear.fromJson(item)).toList();
        setState(() {
          for (var fyr in _years) {
            _myDbName = _years[0].codbnm!;
          }
        });
      } else {
        setState(() {
          _serverErr = "No A/C Years Returned From Server";
        });
      }
    }
  }

  Widget _showyearDd() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 16.0, bottom: 16.0, left: 15.0, right: 16.0),
        child: validfirm
            ? Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Year : ', style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(
                    width: 10,
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: const Text('A/C Year'),
                      value: _myDbName,
                      isDense: true,
                      onChanged: (newValue) async {
                        setState(() {
                          _myDbName = newValue.toString();
                          validyear = true;
                          print(_centralorder);
                          if (_centralorder == false) {
                            appData.commonorder = false;
                            print('loading branch');
                            loadbranch();
                          } else {
                            validbranch = true;
                            _centralorder = true;
                            appData.commonorder = true;
                            print('Central Order is $_centralorder');
                            print('User Type $_myUserType');
                            print(appData.commonorder);
                            if (_myUserType == 'SMAN' || _myUserType == 'ASM') {
                              loadsmanbeat();
                            }
                            _showHomebtn();
                          }
                        });
                      },
                      items: _years.map((AcYear acyr) {
                        return DropdownMenuItem<String>(
                          value: acyr.codbnm,
                          child: Text(
                            acyr.coyear!,
                            //style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ],
              )
            : Container(),
      ),
    );
  }

  void loadbranch() async {
    String brnchusrtype = "";
    int brnchusrid = 0;
    final String brurl =
        "branch?DbName=$_myDbName&UserId=${_myUserId.toString().trim()}";
    var res = await http.get(Uri.parse(baseUrl + brurl),
        headers: {"Accept": "application/json"});
    print(baseUrl + brurl);
    if (res.statusCode == 200) {
      String resBody = res.body;
      if (resBody != "null") {
        final jsonBody = json.decode(resBody);
        _branch =
            (jsonBody).map<Branch>((item) => Branch.fromJson(item)).toList();
        setState(() {
          _myBranchId = _myBranchId == "" ? 1 : _myBranchId;
          for (var brn in _branch) {
            _myBranchId = _branch[0].branchid!;
            brnchusrtype = _branch[0].usertype!;
            brnchusrid = _branch[0].usertypeid!;
            switch (brnchusrtype) {
              case "PARTY":
                {
                  _myPrtId = brnchusrid;
                  _myDlrId = brnchusrid;
                  appData.log_dlrid = _myDlrId;
                  print(appData.log_dlrid.toString());
                  print(_myDlrId.toString());
                }
                break;
              case "SMAN":
                {
                  _mySmanId = brnchusrid;
                }
                break;
              case "TEAMLEADER":
                {
                  _mySmanId = brnchusrid;
                }
                break;
              case "DMAN":
                {
                  _myDmanId = brnchusrid;
                }
                break;
            }
          }
        });
      } else {
        setState(() {
          _serverErr = "No Branch From Server";
        });
      }
      print(' On Branch Load $brnchusrtype - $brnchusrid');
      if (brnchusrtype == 'SMAN' || brnchusrtype == 'ASM') {
        loadsmanbeat();
      }
    }
  }

  Widget _showbranchDd() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 16.0, bottom: 16.0, left: 15.0, right: 16.0),
        child: validyear
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Branch : ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      hint: const Text('Branch'),
                      value: _myBranchId,
                      isDense: true,
                      onChanged: (newValue) {
                        setState(() {
                          _myBranchId = newValue!;
                          validbranch = true;
                        });
                      },
                      items: _branch.map((Branch brn) {
                        return DropdownMenuItem<int>(
                          value: brn.branchid,
                          child: Text(
                            brn.brnachnm!,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            //style: Theme.of(context).textTheme.headlineSmall
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ],
              )
            : Container(),
      ),
    );
  }

  void setddvars() async {
    if (_myUserType == 'SMAN' || _myUserType == 'ASM') {
      loadsmanbeat();
    }
    //print('smanbeat loaded');

    for (var f in _firms) {
      if (_myFirmSelection.toString().trim() == f.coid.toString().trim()) {
        _myFirmName = f.conm!.toUpperCase().trim();
        appSecure.rtwithtax = f.rtwithtax;
      }
    }

    for (var a in _years) {
      if (_myDbName == a.codbnm) {
        _myCoyr = a.coyear!;
        _acstdt = a.acstdt!;
        _acendt = a.acendt!;
        _acmxdt = a.acmaxdt!;
      }
    }

    if (_centralorder == false) {
      for (var b in _branch) {
        if (_myBranchId == b.branchid) {
          _myBranchName = b.brnachnm!;
        }
      }
    } else {
      _myBranchId = 1;
      _myBranchName = "HO";
      //print('Branch Id ' + _myBranchId.toString() + ' Branch Name ' + _myBranchName.toString());
    }
  }

  void savepref() async {
    //print(_mySmanBeat);

    if (_myUserType == 'SMAN' || _myUserType == 'ASM') {
      loadsmanbeat();
    }

    prefs = await SharedPreferences.getInstance();

    prefs.setString('spIp', _myIp.toString());
    prefs.setString('spUserName', _myUserName.toString());
    prefs.setString('spUserType', _myUserType.toString());
    prefs.setInt('spUserId', _myUserId);
    prefs.setString('spUserPass', _myUserPass.toString());
    prefs.setString('spDevId', _identifier.toString());

    prefs.setString('spFrim', _myFirmSelection.toString());
    prefs.setString('spFirmName', _myFirmName.toString());
    prefs.setString('spCoYr', _myCoyr.toString());
    prefs.setString('spDbName', _myDbName.toString());
    prefs.setInt('spBrnId', _myBranchId);
    prefs.setString('spBranchName', _myBranchName.toString());
    prefs.setString('spacstdt', _acstdt.toString());
    prefs.setString('spacendt', _acendt.toString());
    prefs.setString('spacmxdt', _acmxdt.toString());
    prefs.setInt('spcentralorder', _centralorder == true ? 1 : 0);

    prefs.setString('spSmanBeat', _mySmanBeat.toString());
    prefs.setInt('spSmanId', _mySmanId);
    prefs.setInt('spDmanId', _myDmanId);
    prefs.setInt('spDlrId', _myDlrId);

    setState(() {
      appData.log_name = _myUserName;
      appData.log_deviceid = _identifier;
      appData.log_branch = _myBranchName;
      appData.log_id = _myUserId;
      appData.log_branchid = _myBranchId;
      appData.log_coid = _myFirmSelection.toString();
      appData.log_conm = _myFirmName;
      appData.log_coyr = _myCoyr;
      appData.log_dbnm = _myDbName;
      appData.log_smanid = _mySmanId;
      appData.log_ip = _myIp.trim();
      appData.log_smnbeat = _mySmanBeat;
      appData.log_type = _myUserType;
      appData.log_dmanid = _myDmanId;
      appData.log_dlrid = _myDlrId;

      //print('appdata.log_dmanid is ' + _myDmanId.toString());
      appData.prtid = 0;
      appData.prtnm = "";
      appData.ordrefno = 0;
      appData.baseurl = 'http://' + _myIp.trim() + "/api";
      appData.demover = false;
      appData.acstdt = _acstdt;
      appData.acendt = _acendt;
      appData.acmxdt = _acmxdt;
      appData.billissno = _mybillissno;
      appData.pdfbaseurl = 'http://${_myIp.trim()}/pdf/';
      appData.commonorder = _centralorder;
      if (_myUserName.toLowerCase().trim() == "demo") {
        appData.demover = true;
      }
    });
  }

  void loadsmanbeat() async {
    //print('loading smanbeat');
    String demostr = "false";
    if (appData.demover == true) {
      demostr = "true";
    }
    final smanbeaturl =
        "SMANBEAT?DbName=$_myDbName&SmanId=${_mySmanId.toString().trim()}&Demo=$demostr&DmanId=${_myDmanId.toString().trim()}&User_Type_Code=${_myUserType.toString().trim()}";

    //print(baseUrl + smanbeaturl);

    var res = await http.get(Uri.parse(baseUrl + smanbeaturl),
        headers: {"Accept": "application/json"});

    if (res.statusCode == 200) {
      String resBody = res.body;

      final jsonBody = json.decode(resBody);
      _sbeat =
          (jsonBody).map<SmanBeat>((item) => SmanBeat.fromJson(item)).toList();
      setState(() {
        _mySmanBeat = _sbeat[0].forbeat.toString().trim();
        appData.log_smnbeat = _mySmanBeat;
        _mySmanComp = _sbeat[0].forcomp.toString().trim();
        _myForBuk = _sbeat[0].forbukid.toString().trim();
        appData.log_smncomp = _mySmanComp.toString().trim();
        appData.log_forbuk = _myForBuk.toString().trim();
        //print('mysmancmp ' + _mySmanComp + ' For Buk Id' + _myForBuk);
        _mybillissno = _sbeat[0].billissno ?? 0;
        appData.billissno = _mybillissno;
        if (appData.demover == true) {
          appData.demoupto = _sbeat[0].tdt.toString().trim();
        }
        appSecure.taxbeforescheme = _sbeat[0].taxbeforescheme;
        appSecure.showfree = _sbeat[0].showfree;
        appSecure.showsch = _sbeat[0].showsch;
        appSecure.showdisc = _sbeat[0].showdisc;
        appSecure.editrate = _sbeat[0].editrate;
        // Announce Html Message
        appData.announcemsg = _sbeat[0].announcemsg.toString().trim();
        //print(appData.announcemsg);
      });
    }
  }

  void showdashboard() async {
    //print('showing dashboard');
    //print(_myUserType);
    if (_myUserType == "PARTY") {
      await getprtuser();
      setState(() {
        appData.log_dlrid = _myPrtId;
        appData.prtid = _myPrtId;
        appData.prtnm = _myprtnm;
        appData.saletype = _mysaltyp;
        appData.chainofstores = _mychain;
        appData.log_forbuk = "";
        appData.log_smncomp = "";
        appData.ispartytrgt = true;
        appData.partytrgtid = _myPrtId;
      });
      /*var route =
          MaterialPageRoute(builder: (BuildContext context) => PartyTabBar());
      Navigator.of(context).push(route);
    } else {
      var route =
          MaterialPageRoute(builder: (BuildContext context) => Dashboard());
      Navigator.of(context).push(route);
    }*/
    }
    Get.to(() => const HomeScreen());
    //Get.to(() => const Dashboard());
  }

  /*Future<void> _msgAlert(BuildContext context, String msg, String tit) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            tit,
            style: TextStyle(
              color: Colors.blue.shade600,
            ),
          ),
          content: Text(
            msg,
            style: TextStyle(color: Colors.blue.shade600, fontSize: 20),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> _errAlert(BuildContext context, String msg, String tit) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            tit,
            //style: prefix0.TextStyle(color: Colors.blue.shade600),
          ),
          content: Text(
            msg,
            //style: prefix0.TextStyle(color: Colors.red, fontSize: 20),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  */
}
