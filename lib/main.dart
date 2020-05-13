import 'dart:async';

import 'package:flutter/material.dart';
import 'package:clapme_client/screens/home_screen.dart';
import 'package:clapme_client/screens/login_screen.dart';
import 'package:clapme_client/screens/signup_screen.dart';
import 'package:clapme_client/screens/onboarding_screen.dart';
import 'package:clapme_client/screens/routine_list_screen.dart';
import 'package:clapme_client/screens/routine_list_weekly_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:clapme_client/components/nofi_component.dart';

class Auth {
  Future<bool> isLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken');

    if (accessToken == null) {
      return false;
    } else {
      return true;
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /* setLocalPush(); */

  // notification setting
  var initAndroidSetting = AndroidInitializationSettings('app_icon');
  var initIosSetting = IOSInitializationSettings();
  var initSetting = InitializationSettings(initAndroidSetting, initIosSetting);
  await FlutterLocalNotificationsPlugin().initialize(initSetting);

  // auth token check
  final Auth _auth = Auth();
  final bool isLogged = await _auth.isLogged();

  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: HomeScreen(),
    routes: <String, WidgetBuilder>{
      '/signup': (BuildContext context) => new Signup(),
      '/login': (BuildContext context) => new Login(),
      '/onboarding': (BuildContext context) => new Onboarding(),
      '/routinelist': (BuildContext context) => new RoutineListScreen(),
      '/routinelistWeekly': (BuildContext context) => new RoutineListWeekly(),
    },
    initialRoute: isLogged ? '/routinelist' : '/',
  ));
}

final routes = {'/': (BuildContext context) => HomeScreen};
