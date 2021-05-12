import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class HomeScreen extends StatefulWidget {
  final String UID;

  HomeScreen({Key key, this.UID}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Container(
          constraints: BoxConstraints.expand(height: 200),
          child: imageSwiper(context),
        ),
      ],
    ));
  }
}

var images = ['images/plant_1.jpg', 'images/plant_2.jpg', 'images/plant_3.jpg'];

Swiper imageSwiper(context) {
  return new Swiper(
    autoplay: true,
    itemBuilder: (BuildContext context, int index) {
      return new Image.asset(images[index]);
    },
    itemCount: images.length,
    viewportFraction: 0.8,
    scale: 0.9,
  );
}
