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
  int cupertinoTabBarVValue = 0;
  int cupertinoTabBarVValueGetter() => cupertinoTabBarVValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B292B),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: const BoxConstraints.expand(height: 10.0),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: CupertinoTabBar.CupertinoTabBar(
                cupertinoTabBarVValue == 0
                    ? const Color(0xFF943855)
                    : cupertinoTabBarVValue == 1
                        ? const Color(0xFF207561)
                        : cupertinoTabBarVValue == 2
                            ? const Color(0xFFf0dd92)
                            : const Color(0xFF4f81c7),
                cupertinoTabBarVValue == 0
                    ? const Color(0xFFeb7070)
                    : cupertinoTabBarVValue == 1
                        ? const Color(0xFF589167)
                        : cupertinoTabBarVValue == 2
                            ? const Color(0xFFffffc5)
                            : const Color(0xFF64c4ed),
                [
                  Text(
                    "PLANTS",
                    style: TextStyle(
                      color: cupertinoTabBarVValue == 2
                          ? Colors.black
                          : Colors.white,
                      fontSize: 18.75,
                      fontWeight: FontWeight.w400,
                      fontFamily: "SFProRounded",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "LOG",
                    style: TextStyle(
                      color: cupertinoTabBarVValue == 2
                          ? Colors.black
                          : Colors.white,
                      fontSize: 18.75,
                      fontWeight: FontWeight.w400,
                      fontFamily: "SFProRounded",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "SETTINGS",
                    style: TextStyle(
                      color: cupertinoTabBarVValue == 2
                          ? Colors.black
                          : Colors.white,
                      fontSize: 18.75,
                      fontWeight: FontWeight.w400,
                      fontFamily: "SFProRounded",
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                cupertinoTabBarVValueGetter,
                (int index) {
                  setState(() {
                    cupertinoTabBarVValue = index;
                  });
                },
                useSeparators: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
