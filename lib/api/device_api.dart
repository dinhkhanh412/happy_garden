import 'package:happy_garden/models/Feed.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class DeviceAPI {
  String userId;
  DeviceAPI(this.userId);
  Future<Feed> getDevice(String id) async {
    String url = 'https://floating-brushlands-28165.herokuapp.com/device/get/' + this.userId + "/" + id;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print(url);
      print("code to here");
      print(response.body);
      print(Feed.fromJson(json.decode(response.body)).data);
      return Feed.fromJson(json.decode(response.body));
    } else {
      print("Bug in line 16");
      throw Exception('Failed to load device');
    }
  }

  Future<bool> setDevice(Feed device) async {
    final response = await http.post(
        Uri.parse('https://floating-brushlands-28165.herokuapp.com/device/updateMode/' + userId),
        body: device.toJson());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      return true;
    } else {
      return false;
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load device');
    }
  }


  Future<dynamic> getAllDevice(String id) async {
    String url = 'https://floating-brushlands-28165.herokuapp.com/device/get/' + userId;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(url);
      print("code to here");
      print(response.body);
      return "None";
      if (response.body.length == 0) return "None";
      return json.decode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load device');
    }
  }
}
