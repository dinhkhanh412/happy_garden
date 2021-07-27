import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:happy_garden/manage/mqtt/MQTTAppState.dart';

import 'package:happy_garden/ui/page/home/widget/ImageSwiper.dart';
import 'package:happy_garden/ui/page/home/widget/ElementCard.dart';

import 'package:happy_garden/manage/mqtt/MQTTManager.dart';
import 'package:happy_garden/api/device_api.dart';
import 'package:happy_garden/models/Feed.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final String UID;
  final String gardenName;
  HomeScreen({Key key, this.UID, this.gardenName}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MQTTManager _manager_1 = new MQTTManager();
  MQTTManager _manager_2 = new MQTTManager();
  int _selectedIndex = 0;
  bool online = false;
  bool status = false;

  bool connectivity = false;
  num temperature = 0;
  num humidity = 0;
  num waterLv = 0;
  num lightLv = 0;
  bool pumpStart = false;

  @override
  void initState() {
    _initValue();
    _manager_1.addListener(() {
      MQTTAppState map1 = _manager_1.currentState;
      Map<String, dynamic> adaResponse = jsonDecode(map1.getReceivedText);
      Feed feed = Feed.fromJson(adaResponse);
      setState(() {
        online = true;
      });
      String data = feed.data;
      switch (int.parse(feed.id)) {
        case 7:
          {
            setState(() {
              final sub = data.indexOf("-");
              temperature = int.parse(data.substring(0, sub));
              humidity = int.parse(data.substring(sub + 1, data.length));
            });
          }
          break;

        case 9:
          {
            setState(() {
              waterLv = int.parse(data);
            });
          }
          break;

        default:
          {
            //statements;
          }
          break;
      }
    });
    _manager_2.addListener(() {
      MQTTAppState map2 = _manager_2.currentState;
      Map<String, dynamic> adaResponse = jsonDecode(map2.getReceivedText);
      Feed feed = Feed.fromJson(adaResponse);
      setState(() {
        online = true;
      });
      String data = feed.data;
      switch (int.parse(feed.id)) {
        case 11:
          {
            setState(() {
              pumpStart = (data == "1") ? true : false;
            });
          }
          break;

        case 13:
          {
            setState(() {
              lightLv = int.parse(data);
            });
          }
          break;

        default:
          {
            //statements;
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //_manager.subScribeTo(_topicTextController.text);
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: Color(0xffF5FDFB),
        body: _buildScroll(_manager_1, constraints),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'School',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xff0C9359),
          onTap: _onItemTapped,
        ),
      );
    });
  }

  Widget _buildScroll(MQTTManager manager, BoxConstraints constraints) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: constraints.maxHeight,
        ),
        child: _buildColumn(manager, constraints),
      ),
    );
  }

  Widget _buildColumn(MQTTManager manager, BoxConstraints constraints) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: constraints.maxHeight * 0.085,
        ),
        Row(
          children: [
            SizedBox(
              width: constraints.maxWidth * 0.075,
            ),
            Text(
              "Hello user",
              style: TextStyle(fontSize: 24, fontFamily: "Mulish"),
            ),
            SizedBox(
              width: constraints.maxWidth * 0.1,
            ),
          ],
        ),
        SizedBox(
          height: constraints.maxHeight * 0.025,
        ),
        Container(
          constraints: BoxConstraints.expand(height: constraints.maxHeight * 0.25),
          child: imageSwiper(context, constraints),
        ),
        SizedBox(
          height: constraints.maxHeight * 0.05,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                displayToastMessage("Humidity", context);
              },
              child: Container(
                constraints: BoxConstraints.expand(
                    height: constraints.maxWidth * 0.3, width: constraints.maxWidth * 0.3),
                child: card(context, "Humidity", Icons.cloud, "OFF"),
              ),
            ),
            GestureDetector(
              onTap: () {
                displayToastMessage("Temperature", context);
              },
              child: Container(
                constraints: BoxConstraints.expand(
                    height: constraints.maxWidth * 0.3, width: constraints.maxWidth * 0.3),
                child: card(context, "Temperature", Icons.thermostat_sharp, "OFF"),
              ),
            ),
            GestureDetector(
              onTap: () {
                displayToastMessage("Water Level", context);
              },
              child: Container(
                constraints: BoxConstraints.expand(
                    height: constraints.maxWidth * 0.3, width: constraints.maxWidth * 0.3),
                child: card(context, "Water Level", Icons.eco, "OFF"),
              ),
            ),
          ],
        ),
        SizedBox(
          height: constraints.maxHeight * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                displayToastMessage("Connectivity", context);
              },
              child: Container(
                constraints: BoxConstraints.expand(
                    height: constraints.maxWidth * 0.3, width: constraints.maxWidth * 0.3),
                child: card(context, "Connectivity", Icons.network_wifi, "OFF"),
              ),
            ),
            GestureDetector(
              onTap: () {
                displayToastMessage("Light Status", context);
              },
              child: Container(
                  constraints: BoxConstraints.expand(
                      height: constraints.maxWidth * 0.3, width: constraints.maxWidth * 0.6),
                  child: light(lightLv)),
            ),
          ],
        ),
        SizedBox(
          height: constraints.maxHeight * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                displayToastMessage("Status", context);
              },
              child: Container(
                constraints: BoxConstraints.expand(
                    height: constraints.maxWidth * 0.3, width: constraints.maxWidth * 0.6),
                child: cardStat(context, "Light Status", Icons.lightbulb, "OFF"),
              ),
            ),
            GestureDetector(
              onTap: () {
                displayToastMessage("Alarm", context);
              },
              child: Container(
                constraints: BoxConstraints.expand(
                    height: constraints.maxWidth * 0.3, width: constraints.maxWidth * 0.3),
                child: card(context, "Alarm", Icons.alarm, "OFF"),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget light(num text) {
    return card(context, "Light Status", Icons.lightbulb, text.toString());
  }

  //function
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _configureAndConnect() async {
    String server1 = 'server_1';
    String server2 = 'server_2';
    await _manager_1.initializeMQTTClient(identifier: server1, server: "BBC");
    await _manager_2.initializeMQTTClient(identifier: server2, server: "BBC1");
    _manager_1.connect();
    _manager_2.connect();
  }

  void _initValue() async {
    DeviceAPI deviceAPI = new DeviceAPI(widget.UID);
    // temp + humi
    Feed temp = await deviceAPI.getDevice("7");
    String data = temp.data;
    final sub = data.indexOf("-");
    setState(() {
      temperature = int.parse(data.substring(0, sub));
      humidity = int.parse(data.substring(sub + 1, data.length));
    });
    // soil
    temp = await deviceAPI.getDevice("9");
    setState(() {
      waterLv = int.parse(temp.data);
    });

    // light
    temp = await deviceAPI.getDevice("13");
    setState(() {
      lightLv = int.parse(temp.data);
    });

    // pump
    temp = await deviceAPI.getDevice("11");
    setState(() {
      pumpStart = (temp.data == "1") ? true : false;
    });
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
