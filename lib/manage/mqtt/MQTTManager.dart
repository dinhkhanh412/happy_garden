import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:happy_garden/manage/mqtt/MQTTAppState.dart';
import 'package:happy_garden/models/Feed.dart';
import 'package:happy_garden/api/device_api.dart';
import 'package:http/http.dart' as http;

Future<String> fetchKey(String server) async {
  if (server == 'dinhkhanh412') {
    return "aio_PrHt51fI5dDoYgZg87UqzAzFltXY";
  } else {
    return "aio_PrHt51fI5dDoYgZg87UqzAzFltXY";
  }
  // final response = await http.get(Uri.parse('http://dadn.esp32thanhdanh.link'));

  // if (response.statusCode == 200) {
  //   // If the server did return a 200 OK response,
  //   // then parse the JSON.
  //   return jsonDecode(response.body)['key' + server].toString();
  // } else {
  //   // If the server did not return a 200 OK response,
  //   // then throw an exception.
  //   throw Exception('Failed to load key');
  // }
}

class MQTTManager extends ChangeNotifier {
  // Private instance of client
  MQTTAppState _currentState = MQTTAppState();
  MqttServerClient _client;
  String _host = 'io.adafruit.com';
  String _user;
  String _key;
  String _identifier;

  String _topic;

  // List<String> splitKey(String str) {
  //   final splitIndex = str.indexOf(":");
  //   List<String> result = [];
  //   result.add(str.substring(0, splitIndex));
  //   result.add(str.substring(splitIndex + 1, str.length));
  //   print(result);
  //   return result;
  // }

  Future<void> initializeMQTTClient({@required String identifier, @required String server}) async {
    // Save the values
    // _key = splitKey(response)[0];
    final Future<String> keyBBC = fetchKey(server);
    _key = await keyBBC;
    // _user = "CSE_" + server;
    // _topic = "CSE_" + server + "/feeds/#";
    _user = server;
    _topic = server + "/feeds/#";
    _identifier = identifier;
    _host = host;
    _client = MqttServerClient(_host, _key);
    _client.port = 1883;
    _client.keepAlivePeriod = 20;
    _client.onDisconnected = onDisconnected;
    _client.secure = false;
    _client.logging(on: true);

    /// Add the successful connection callback
    _client.onConnected = onConnected;
    _client.onSubscribed = onSubscribed;
    _client.onUnsubscribed = onUnsubscribed;

    final MqttConnectMessage connMess = MqttConnectMessage()
        .authenticateAs(_user, _key)
        .withClientIdentifier(_identifier)
        .withWillTopic('willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        //.authenticateAs(username, password)// Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    print('EXAMPLE::Mosquitto client connecting....');
    _client.connectionMessage = connMess;
  }

  String get host => _host;
  MQTTAppState get currentState => _currentState;
  // Connect to the host
  void connect() async {
    assert(_client != null);
    try {
      print('EXAMPLE::Mosquitto start client connecting....');
      _currentState.setAppConnectionState(MQTTAppConnectionState.connecting);
      updateState();
      await _client.connect();
      _client.subscribe(_topic, MqttQos.atLeastOnce);
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      disconnect();
    }
  }

  void disconnect() {
    print('Disconnected');
    _client.disconnect();
  }

  void publish(String message, String topic) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);
    _client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload);
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    print('EXAMPLE::Subscription confirmed for topic $topic');
    _currentState.setAppConnectionState(MQTTAppConnectionState.connectedSubscribed);
    updateState();
  }

  void onUnsubscribed(String topic) {
    print('EXAMPLE::onUnsubscribed confirmed for topic $topic');
    _currentState.clearText();
    _currentState.setAppConnectionState(MQTTAppConnectionState.connectedUnSubscribed);
    updateState();
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    print('EXAMPLE::OnDisconnected client callback - Client disconnection ' + _user);
    if (_client.connectionStatus.returnCode == MqttConnectReturnCode.noneSpecified) {
      print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    }
    _currentState.clearText();
    _currentState.setAppConnectionState(MQTTAppConnectionState.disconnected);
    updateState();
  }

  /// The successful connect callback
  void onConnected() {
    _currentState.setAppConnectionState(MQTTAppConnectionState.connected);
    updateState();
    _client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload;
      final String pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      _currentState.setReceivedText(pt);
      bool cond1 = '/'.allMatches(c[0].topic).length == 2;
      bool cond2 = c[0].topic.indexOf('bk-iot') != -1;
      if (cond1 && cond2) {
        updateState();
        print('EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      }
      print('');
    });
    print('EXAMPLE::OnConnected client callback - Client connection was sucessful ' + _user);
  }

  void subScribeTo(String topic) {
    // Save topic for future use
    //_topic = topic;
    _client.subscribe(topic, MqttQos.atLeastOnce);
  }

  /// Unsubscribe from a topic
  void unSubscribe(String topic) {
    _client.unsubscribe(topic);
  }

  /// Unsubscribe from a topic
  void unSubscribeFromCurrentTopic() {
    _client.unsubscribe(_topic);
  }

  void updateState() {
    //controller.add(_currentState);
    notifyListeners();
  }

  Future<void> publishInputDevice(id, data, userId) async {
    DeviceAPI deviceAPI = new DeviceAPI(userId);
    // if (_currentState.getAppConnectionState !=
    //     MQTTAppConnectionState.connectedSubscribed) {
    //   return;
    // }
    if (((_user == "CSE_BBC") && (id > 10)) || ((_user == "CSE_BBC1") && (id < 11))) {
      return;
    }
    switch (id) {
      case 1:
        String topic = "CSE_BBC/feeds/bk-iot-led";
        Feed feed = Feed(id.toString(), "LED", data, "");
        deviceAPI.setDevice(feed);
        String body = json.encode(feed.toJson());
        publish(body, topic);
        break;
      case 3:
        String topic = "CSE_BBC/feeds/bk-iot-lcd";
        Feed feed = Feed(id.toString(), "LCD", data, "");
        await deviceAPI.setDevice(feed);
        String body = json.encode(feed.toJson());
        publish(body, topic);
        break;
      case 11:
        String topic = "CSE_BBC1/feeds/bk-iot-relay";
        Feed feed = Feed(id.toString(), "RELAY", data, "");
        await deviceAPI.setDevice(feed);
        print("pushed");
        String body = json.encode(feed.toJson());
        publish(body, topic);
        break;
      default:
        return;
    }
  }
}
