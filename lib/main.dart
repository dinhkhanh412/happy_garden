import 'package:flutter/material.dart';
import 'package:happy_garden/ui/page/home/homepage.dart';
import 'package:happy_garden/ui/page/welcome_page.dart';
import 'package:provider/provider.dart';

import 'helpers/service_locator.dart';
import 'manage/mqtt/MQTTManager.dart';

import 'package:happy_garden/ui/page/detail/detailpage.dart';
import 'package:happy_garden/ui/page/login/login_page.dart';

void main() {
  setupLocator();
  runApp(MyApp());
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
            // '/': (BuildContext context) => DesignCourseHomeScreen()
            '/': (BuildContext context) => LoginPage()
          }),
    );
  }
}
