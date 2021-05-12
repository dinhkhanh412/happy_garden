import 'package:flutter/material.dart';
import 'package:happy_garden/ui/page/home/widget/ImageSwiper.dart';
import 'package:happy_garden/ui/page/home/widget/ElementCard.dart';

class HomeScreen extends StatefulWidget {
  final String UID;

  HomeScreen({Key key, this.UID}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                Container(
                  constraints: BoxConstraints.expand(
                      height: constrains.maxWidth * 0.3, width: constrains.maxWidth * 0.3),
                  child: card(context, "Humidity", Icons.cloud, "Love"),
                ),
                Container(
                  constraints: BoxConstraints.expand(
                      height: constrains.maxWidth * 0.3, width: constrains.maxWidth * 0.3),
                  child: card(context, "Temperature", Icons.thermostat_sharp, "Love"),
                ),
                Container(
                  constraints: BoxConstraints.expand(
                      height: constrains.maxWidth * 0.3, width: constrains.maxWidth * 0.3),
                  child: card(context, "Water Level", Icons.eco, "Love"),
                )
              ],
            ),
            SizedBox(
              height: constrains.maxHeight * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  constraints: BoxConstraints.expand(
                      height: constrains.maxWidth * 0.3, width: constrains.maxWidth * 0.3),
                  child: card(context, "Connectivity", Icons.network_wifi, "Love"),
                ),
                Container(
                  constraints: BoxConstraints.expand(
                      height: constrains.maxWidth * 0.3, width: constrains.maxWidth * 0.6),
                  child: card(context, "Light Status", Icons.lightbulb, "Love"),
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
                Container(
                  constraints: BoxConstraints.expand(
                      height: constrains.maxWidth * 0.3, width: constrains.maxWidth * 0.6),
                  child: cardStat(context, "Light Status", Icons.lightbulb, "Love"),
                ),
                Container(
                  constraints: BoxConstraints.expand(
                      height: constrains.maxWidth * 0.3, width: constrains.maxWidth * 0.3),
                  child: card(context, "Alarm", Icons.alarm, "Love"),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
