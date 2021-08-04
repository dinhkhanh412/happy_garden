import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:happy_garden/ui/page/detail/widget/cupertino_tabbar.dart'
    as CupertinoTabBar;

var COLORS = [
  Color(0xFFEF7A85),
  Color(0xFFFF90B3),
  Color(0xFFFFC2E2),
  Color(0xFFB892FF),
  Color(0xFFB892FF)
];

class DetailScreen extends StatefulWidget {
  DetailScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var data = [
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/200?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/100?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/150?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/125?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/175?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/225?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/250?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/350?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/275?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/300?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/325?random"
    }
  ];

  int cupertinoTabBarValue = 1;
  int cupertinoTabBarValueGetter() => cupertinoTabBarValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CupertinoTabBar.CupertinoTabBar(
            const Color(0xFF207561),
            const Color(0xFF719192),
            [
              const Text(
                "PLANTS",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.75,
                  fontWeight: FontWeight.w400,
                  fontFamily: "SFProRounded",
                ),
                textAlign: TextAlign.center,
              ),
              const Text(
                "LOG",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.75,
                  fontWeight: FontWeight.w400,
                  fontFamily: "SFProRounded",
                ),
                textAlign: TextAlign.center,
              ),
              const Text(
                "SETTINGS",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.75,
                  fontWeight: FontWeight.w400,
                  fontFamily: "SFProRounded",
                ),
                textAlign: TextAlign.center,
              ),
            ],
            cupertinoTabBarValueGetter,
            (int index) {
              setState(() {
                cupertinoTabBarValue = index;
              });
            },
            useSeparators: true,
          ),
          Container(
            constraints: const BoxConstraints.expand(height: 20.0),
          ),
          new Transform.translate(
            offset:
                new Offset(0.0, MediaQuery.of(context).size.height * 0.1050),
            child: new ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(0.0),
              scrollDirection: Axis.vertical,
              primary: true,
              itemCount: data.length,
              itemBuilder: (BuildContext content, int index) {
                return AwesomeListItem(
                    title: data[index]["title"],
                    content: data[index]["content"],
                    color: data[index]["color"],
                    image: data[index]["image"]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height / 4.75);
    p.lineTo(0.0, size.height / 3.75);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class AwesomeListItem extends StatefulWidget {
  String title;
  String content;
  Color color;
  String image;

  AwesomeListItem({this.title, this.content, this.color, this.image});

  @override
  _AwesomeListItemState createState() => new _AwesomeListItemState();
}

class _AwesomeListItemState extends State<AwesomeListItem> {
  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Container(width: 10.0, height: 190.0, color: widget.color),
        new Expanded(
          child: new Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  widget.title,
                  style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: new Text(
                    widget.content,
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
        new Container(
          height: 150.0,
          width: 150.0,
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              new Transform.translate(
                offset: new Offset(50.0, 0.0),
                child: new Container(
                  height: 100.0,
                  width: 100.0,
                  color: widget.color,
                ),
              ),
              new Transform.translate(
                offset: Offset(10.0, 20.0),
                child: new Card(
                  elevation: 20.0,
                  child: new Container(
                    height: 120.0,
                    width: 120.0,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            width: 10.0,
                            color: Colors.white,
                            style: BorderStyle.solid),
                        image: DecorationImage(
                          image: NetworkImage(widget.image),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
