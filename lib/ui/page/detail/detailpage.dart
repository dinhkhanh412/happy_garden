import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:happy_garden/ui/page/detail/widget/cupertino_tabbar.dart'
    as CupertinoTabBar;

class DetailScreen extends StatefulWidget {
  DetailScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int cupertinoTabBarValue = 1;
  int cupertinoTabBarValueGetter() => cupertinoTabBarValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
          ],
        ),
      ),
    );
  }
}
