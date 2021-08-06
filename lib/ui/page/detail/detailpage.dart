import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';

import 'package:happy_garden/ui/page/detail/widget/list_view.dart';
import 'package:happy_garden/ui/page/detail/widget/info_screen.dart';
import 'package:happy_garden/ui/page/detail/widget/reorderable_view.dart';
import 'package:happy_garden/ui/page/detail/widget/settings_screen.dart';

class DesignCourseHomeScreen extends StatefulWidget {
  @override
  _DesignCourseHomeScreenState createState() => _DesignCourseHomeScreenState();
}

class _DesignCourseHomeScreenState extends State<DesignCourseHomeScreen> {
  int cupertinoTabBarValue = 1;
  int cupertinoTabBarValueGetter() => cupertinoTabBarValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            getAppBarUI(),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height,
                    child: DefaultTabController(
                        length: 3,
                        child: Scaffold(
                          appBar: AppBar(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            bottom: TabBar(
                                unselectedLabelColor: Colors.redAccent,
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicator: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Color(0xFF3c4245),
                                      Color(0xFF719192)
                                    ]),
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.redAccent),
                                tabs: [
                                  Tab(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("PLANTS"),
                                    ),
                                  ),
                                  Tab(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("LOG"),
                                    ),
                                  ),
                                  Tab(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("SETTINGS"),
                                    ),
                                  ),
                                ]),
                          ),
                          body: TabBarView(children: [
                            Center(
                              child: Column(
                                children: [
                                  getSearchBarUI(),
                                  Flexible(child: getPopularCourseUI()),
                                ],
                              ),
                            ),
                            ReorderableViewPage(),
                            SettingsScreen(),
                          ]),
                        ))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getPopularCourseUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Text(
                'Your Plants',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  letterSpacing: 0.27,
                ),
              ),
              SizedBox(
                width: 60,
                height: 60,
                child: Icon(Icons.edit, color: Color(0xFF3c4245)),
              )
            ],
          ),
          Flexible(
            child: PopularCourseListView(
              callBack: () {
                moveTo();
              },
            ),
          )
        ],
      ),
    );
  }

  void moveTo() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => CourseInfoScreen(),
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: 64,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor('#F8FAFB'),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(13.0),
                    bottomLeft: Radius.circular(13.0),
                    topLeft: Radius.circular(13.0),
                    topRight: Radius.circular(13.0),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextFormField(
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Search for plant',
                            border: InputBorder.none,
                            helperStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: HexColor('#B9BABC'),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: HexColor('#B9BABC'),
                            ),
                          ),
                          onEditingComplete: () {},
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Icon(Icons.search, color: HexColor('#B9BABC')),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          )
        ],
      ),
    );
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Your Garden',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.27,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
