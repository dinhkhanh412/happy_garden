import 'package:flutter/material.dart';
import 'package:happy_garden/ui/page/home/homepage.dart';
import 'package:provider/provider.dart';

import 'helpers/service_locator.dart';
import 'manage/mqtt/MQTTManager.dart';

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
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: '/',
          routes: {
            '/': (BuildContext context) => HomeScreen(),
          }),
    );
  }
}
