import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_garden/manage/mqtt/MQTTAppState.dart';
import 'package:happy_garden/models/Device_Auto.dart';
import 'package:happy_garden/models/global_device.dart';

import 'package:happy_garden/ui/page/home/widget/ImageSwiper.dart';
import 'package:happy_garden/ui/page/home/widget/ElementCard.dart';

import 'package:happy_garden/manage/mqtt/MQTTManager.dart';
import 'package:happy_garden/api/device_api.dart';
import 'package:happy_garden/models/Feed.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
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
  bool isLoading = true;
  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

  bool connectivity = false;
  num temperature = 0;
  num humidity = 0;
  num waterLv = 0;
  num lightLv = 0;
  bool pumpStart = false;
  bool lightOn = false;

  BoxConstraints constraints;

  @override
  void initState() {
    _initValue();
    _configureAndConnect();
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

        case 1:
          {
            setState(() {
              lightOn = int.parse(data) == 1 ? true : false;
              var deviceStatus = context.read<GlobalDeviceStatus>();
              deviceStatus.setDeviceStatus(lightOn, 0);
            });
            break;
          }
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
              var deviceStatus = context.read<GlobalDeviceStatus>();
              deviceStatus.setDeviceStatus(pumpStart, 1);

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
    if (isLoading) {
      return MaterialApp(
          title: "This is a StatafulWidget",
          home: Scaffold(
              body: Align(
            alignment: Alignment.center,
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 10,
              ),
              Text(
                "Please wait....",
                style: GoogleFonts.mulish(
                  color: Colors.green,
                  fontSize: 18.0,
                ),
              )
            ]),
          )));
    }
    //_manager.subScribeTo(_topicTextController.text);
    return LayoutBuilder(builder: (context, constraints) {
      this.constraints = constraints;
      return Scaffold(
        backgroundColor: Color(0xffF5FDFB),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
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
                  //Center Row contents horizontally,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        displayToastMessage("Connectivity", context);
                      },
                      child: Container(
                        constraints: BoxConstraints.expand(
                            height: constraints.maxWidth * 0.3, width: constraints.maxWidth * 0.3),
                        child: card(context, "Kết nối", Icons.network_wifi,
                            connectivity ? "Online" : "Offline"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showBottomSheet(constraints);
                      },
                      child: Container(
                          constraints: BoxConstraints.expand(
                              height: constraints.maxWidth * 0.3,
                              width: constraints.maxWidth * 0.6),
                          child: card(context, "MÁY BƠM", Icons.add_alarm_rounded,
                              pumpStart ? "ĐANG CHẠY" : "TẮT")),
                    ),
                  ],
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        displayToastMessage("Độ ẩm", context);
                      },
                      child: Container(
                        constraints: BoxConstraints.expand(
                            height: constraints.maxWidth * 0.3, width: constraints.maxWidth * 0.3),
                        child: card(context, "Độ ẩm", Icons.cloud, humidity.toString()),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        displayToastMessage("Nhiệt độ", context);
                      },
                      child: Container(
                        constraints: BoxConstraints.expand(
                            height: constraints.maxWidth * 0.3, width: constraints.maxWidth * 0.3),
                        child: card(context, "Nhiệt độ", Icons.thermostat_sharp,
                            temperature.toString() + "°C"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        displayToastMessage("Độ ẩm đất", context);
                      },
                      child: Container(
                        constraints: BoxConstraints.expand(
                            height: constraints.maxWidth * 0.3, width: constraints.maxWidth * 0.3),
                        child: card(context, "Độ ẩm đất", Icons.eco, waterLv.toString()),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //Center Row contents horizontally,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showMaterialModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            context: context,
                            builder: (context) =>
                                bottomSheet(context, constraints, true));
                      },
                      child: Container(
                          constraints: BoxConstraints.expand(
                              height: constraints.maxWidth * 0.3,
                              width: constraints.maxWidth * 0.6),
                          child: card(context, "Đèn LED", Icons.add_alarm_rounded,
                              lightOn ? "BẬT" : "TẮT")),
                    ),
                    GestureDetector(
                      onTap: () {
                        displayToastMessage("Cường độ sáng", context);
                      },
                      child: Container(
                          constraints: BoxConstraints.expand(
                              height: constraints.maxWidth * 0.3,
                              width: constraints.maxWidth * 0.3),
                          child:
                              card(context, "Cường độ sáng", Icons.lightbulb, lightLv.toString())),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),

      );
    });
  }

  void sendLight(bool isOn) {
    _manager_1.publishInputDevice(1, isOn ? "1" : "0");
    setState(() {
      lightOn = isOn;
    });
  }

  void sendPump(bool isOn) {
    _manager_2.publishInputDevice(11, isOn ? "1" : "0");
    setState(() {
      pumpStart = isOn;
    });
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
    dynamic allDevice = await deviceAPI.getAllDevice(widget.UID);

    print(allDevice[0].toString());
    Feed temp = new Feed.fromJson(allDevice[0]);

    String data = temp.data;
    final sub = data.indexOf("-");
    setState(() {
      temperature = int.parse(data.substring(0, sub));
      humidity = int.parse(data.substring(sub + 1, data.length));
    });
    // soil
    // temp = await deviceAPI.getDevice("9");
    temp = new Feed.fromJson(allDevice[1]);
    setState(() {
      waterLv = int.parse(temp.data);
    });

    // light
    // temp = await deviceAPI.getDevice("13");
    temp = new Feed.fromJson(allDevice[2]);
    // print(temp.data);
    setState(() {
      lightLv = int.parse(temp.data);
    });

    // pump
    // temp = await deviceAPI.getDevice("11");
    temp = new Feed.fromJson(allDevice[3]);
    setState(() {
      pumpStart = (temp.data == "1") ? true : false;
    });


    temp = new Feed.fromJson(allDevice[4]);
    setState(() {
      lightOn = (temp.data == "1") ? true : false;
    });

    var deviceStatus = context.read<GlobalDeviceStatus>();
    deviceStatus.setDeviceStatus(pumpStart, 1);
    deviceStatus.setDeviceStatus(lightOn, 0);
    setState(() {
      connectivity = true;
      isLoading = false;
    });
  }


  void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        print(_time);
      });
    }
  }

  Column bottomSheet(BuildContext context, BoxConstraints constrains, bool isLed) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(height: 20),
        Row(
          children: [
            SizedBox(width: 10),
            Text(
              isLed? "Bật/Tắt đèn LED:" : "Bật/Tắt máy bơm:",
              style: TextStyle(fontSize: 18, fontFamily: "Mulish"),
            ),
            SizedBox(
              width: constrains.maxWidth * 0.2,
            ),
            Consumer<GlobalDeviceStatus>(
              builder: (context, status, child) {
                return CustomSwitch(
                  activeColor: Color(0xff0C9359),
                  value: isLed ? lightOn : pumpStart,
                  onChanged: (value) {
                    var deviceStatus = context.read<GlobalDeviceStatus>();
                    deviceStatus.setDeviceStatus(value, isLed ? 0 : 1);
                    isLed ? sendLight(value) : sendPump(value);
                    setState(() {
                      if (isLed) lightOn =  value;
                      else pumpStart = value;
                    });
                  },
                );
              },
            )
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            SizedBox(width: 10),
            Text(
              "Chế độ tự động:",
              style: TextStyle(fontSize: 18, fontFamily: "Mulish"),
            ),
            SizedBox(
              width: constrains.maxWidth * 0.2,
            ),
          ],
        ),

        SizedBox(height: 50),
        ExpansionPanelList(
          animationDuration: Duration(seconds: 2),
          elevation: 2,

        ),
      ],
    );
  }

  void showBottomSheet(BoxConstraints constraints ){
    showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (context) =>
            bottomSheet(context, constraints, false));
  }
}


displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
