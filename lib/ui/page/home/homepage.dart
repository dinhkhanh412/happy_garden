import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:custom_switch/custom_switch.dart';

import 'package:happy_garden/ui/page/home/widget/ImageSwiper.dart';
import 'package:happy_garden/ui/page/home/widget/ElementCard.dart';

import 'package:happy_garden/manage/mqtt/MQTTManager.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final String UID;

  HomeScreen({Key key, this.UID}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MQTTManager _manager = new MQTTManager();

  int _selectedIndex = 0;
  bool status = false;

  @override
  void initState() {
    super.initState();
    _configureAndConnect();
  }

  @override
  Widget build(BuildContext context) {
    //_manager.subScribeTo(_topicTextController.text);
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: Color(0xffF5FDFB),
        body: _buildScroll(_manager, constraints),
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
              width: constraints.maxWidth * 0.25,
            ),
            CustomSwitch(
              activeColor: Color(0xff0C9359),
              value: status,
              onChanged: (value) {
                _manager.publish(status ? '1' : '0');
                print("VALUE : $value");
                setState(() {
                  status = value;
                });
              },
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
                child: card(context, "Humidity", Icons.cloud, "Love"),
              ),
            ),
            GestureDetector(
              onTap: () {
                displayToastMessage("Temperature", context);
              },
              child: Container(
                constraints: BoxConstraints.expand(
                    height: constraints.maxWidth * 0.3, width: constraints.maxWidth * 0.3),
                child: card(context, "Temperature", Icons.thermostat_sharp, "Love"),
              ),
            ),
            GestureDetector(
              onTap: () {
                displayToastMessage("Water Level", context);
              },
              child: Container(
                constraints: BoxConstraints.expand(
                    height: constraints.maxWidth * 0.3, width: constraints.maxWidth * 0.3),
                child: card(context, "Water Level", Icons.eco, "Love"),
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
                child: card(context, "Connectivity", Icons.network_wifi, "Love"),
              ),
            ),
            GestureDetector(
              onTap: () {
                displayToastMessage("Light Status", context);
              },
              child: Container(
                constraints: BoxConstraints.expand(
                    height: constraints.maxWidth * 0.3, width: constraints.maxWidth * 0.6),
                child: light(_manager.currentState.getReceivedText),
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
                displayToastMessage("Status", context);
              },
              child: Container(
                constraints: BoxConstraints.expand(
                    height: constraints.maxWidth * 0.3, width: constraints.maxWidth * 0.6),
                child: cardStat(context, "Light Status", Icons.lightbulb, "Love"),
              ),
            ),
            GestureDetector(
              onTap: () {
                displayToastMessage("Alarm", context);
              },
              child: Container(
                constraints: BoxConstraints.expand(
                    height: constraints.maxWidth * 0.3, width: constraints.maxWidth * 0.3),
                child: card(context, "Alarm", Icons.alarm, "Love"),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget light(String text) {
    return card(context, "Light Status", Icons.lightbulb, text);
  }

  //function
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _configureAndConnect() async {
    String osPrefix = 'Flutter_Android';
    _manager.initializeMQTTClient(identifier: osPrefix);
    _manager.connect();
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
