import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/firebase_options.dart';

import 'package:mdms_iosand/src/repository/authentication_repository/authentication_repository.dart';
import 'package:mdms_iosand/src/utils/app_bindings.dart';
import 'package:mdms_iosand/src/utils/theme/theme.dart';
//import 'package:flex_color_scheme/flex_color_scheme.dart';

/// NOTE:
/// DESIGN PLAYLIST : https://www.youtube.com/playlist?list=PL5jb9EteFAODpfNJu8U2CMqKFp4NaXlto
/// FIREBASE PLAYLIST : https://www.youtube.com/playlist?list=PL5jb9EteFAOC9V6ZHAIg3ycLtjURdVxUH
/// For the Firebase setup You can watch this video - https://www.youtube.com/watch?v=fxDusoMcWj8
///
/// UPDATE: March, 2023
/// 1. Updated Deprecated TextTheme Attributes  [headline1], [headline2], ... TO ->
///    Check link https://codingwitht.com/how-to-use-theme-in-flutter-light-dark-theme/
/// 2. Elevated Button Properties updated from [onPrimary] to [foregroundColor] & [primary] to [backgroundColor]

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// Show Splash Screen till data loads & when loaded call FlutterNativeSplash.remove();
  /// In this case I'm removing it inside AuthenticationRepository() -> onReady() method.
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// Before running App - Initialize Firebase and after initialization, Call
  /// Authentication Repository so that It can check which screen to show.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding:
          AppBinding(), // Solves the issues of Get.lazyPut and Get.Put() by defining all Controllers in single class
      /*
      theme: FlexThemeData.light(scheme: FlexScheme.blueWhale),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.blueWhale),
      themeMode: ThemeMode.system,
      */
      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,

      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      debugShowCheckedModeBanner: false,

      home: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
