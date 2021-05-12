import 'package:flutter/material.dart';
import 'package:happy_garden/ui/page/home/widget/ImageSwiper.dart';
import 'package:happy_garden/ui/page/home/widget/ElementCard.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  final String UID;

  HomeScreen({Key key, this.UID}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return Scaffold(
        backgroundColor: Color(0xffF5FDFB),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: constrains.maxHeight * 0.085,
            ),
            Row(
              children: [
                SizedBox(
                  width: constrains.maxWidth * 0.075,
                ),
                Text(
                  "Hello user",
                  style: TextStyle(fontSize: 24, fontFamily: "Mulish"),
                ),
              ],
            ),
            SizedBox(
              height: constrains.maxHeight * 0.025,
            ),
            Container(
              constraints: BoxConstraints.expand(height: constrains.maxHeight * 0.25),
              child: imageSwiper(context, constrains),
            ),
            SizedBox(
              height: constrains.maxHeight * 0.05,
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
                        height: constrains.maxWidth * 0.3, width: constrains.maxWidth * 0.3),
                    child: card(context, "Humidity", Icons.cloud, "Love"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    displayToastMessage("Temperature", context);
                  },
                  child: Container(
                    constraints: BoxConstraints.expand(
                        height: constrains.maxWidth * 0.3, width: constrains.maxWidth * 0.3),
                    child: card(context, "Temperature", Icons.thermostat_sharp, "Love"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    displayToastMessage("Water Level", context);
                  },
                  child: Container(
                    constraints: BoxConstraints.expand(
                        height: constrains.maxWidth * 0.3, width: constrains.maxWidth * 0.3),
                    child: card(context, "Water Level", Icons.eco, "Love"),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: constrains.maxHeight * 0.01,
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
                        height: constrains.maxWidth * 0.3, width: constrains.maxWidth * 0.3),
                    child: card(context, "Connectivity", Icons.network_wifi, "Love"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    displayToastMessage("Light Status", context);
                  },
                  child: Container(
                    constraints: BoxConstraints.expand(
                        height: constrains.maxWidth * 0.3, width: constrains.maxWidth * 0.6),
                    child: card(context, "Light Status", Icons.lightbulb, "Love"),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: constrains.maxHeight * 0.01,
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
                        height: constrains.maxWidth * 0.3, width: constrains.maxWidth * 0.6),
                    child: cardStat(context, "Light Status", Icons.lightbulb, "Love"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    displayToastMessage("Alarm", context);
                  },
                  child: Container(
                    constraints: BoxConstraints.expand(
                        height: constrains.maxWidth * 0.3, width: constrains.maxWidth * 0.3),
                    child: card(context, "Alarm", Icons.alarm, "Love"),
                  ),
                ),
              ],
            ),
          ],
        ),
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
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
