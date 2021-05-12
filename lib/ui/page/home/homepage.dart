import 'package:flutter/material.dart';
import 'package:happy_garden/ui/page/home/widget/ImageSwiper.dart';

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
        body: Column(
          children: <Widget>[
            SizedBox(
              height: constrains.maxHeight * 0.075,
            ),
            Text("Hello User"),
            SizedBox(
              height: constrains.maxHeight * 0.05,
            ),
            Container(
              constraints: BoxConstraints.expand(height: constrains.maxHeight * 0.25),
              child: imageSwiper(context),
            ),
          ],
        ),
        backgroundColor: Color(0xffF5FDFB),
      );
    });
  }
}
