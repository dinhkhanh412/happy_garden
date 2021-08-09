import 'package:flutter/material.dart';
import 'package:happy_garden/ui/page/auth/sign_in_screen.dart';
import 'package:happy_garden/ui/page/home/homepage.dart';
import 'package:happy_garden/ui/page/welcome_page.dart';
import 'package:provider/provider.dart';

import 'helpers/service_locator.dart';
import 'manage/mqtt/MQTTManager.dart';

import 'package:happy_garden/ui/page/welcome_page.dart';
import 'package:provider/src/change_notifier_provider.dart';
import 'package:happy_garden/models/global_device.dart';

import 'package:happy_garden/ui/page/detail/detailpage.dart';



import 'models/global_schedule.dart';void main() {
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GlobalSchedule()),
        ChangeNotifierProvider(create: (context) => GlobalDeviceStatus()),
        // Provider(create: (context) => SomeOtherClass()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MQTTManager>(
      create: (context) => service_locator<MQTTManager>(),
      child: MaterialApp(
          title: 'Happy Garden',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: '/',
          routes: {
            // '/': (BuildContext context) =>
            //     HomeScreen(UID: "61063c60d95daa29e8639f65", gardenName: "Home")
            '/': (BuildContext context) => HomeScreen(UID: "61063c60d95daa29e8639f65", gardenName: "Home")
            // '/': (BuildContext context) => SignInScreen()
          }),
    );
  }
}
