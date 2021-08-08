import 'package:http/http.dart' as http;
import 'dart:convert';

class ScheduleAPI {
  String userId;
  ScheduleAPI(this.userId);
  Future<dynamic> getSchedule() async {
    String url = 'https://happygarden-bev02.herokuapp.com/schedule/' + userId;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {

      if (response.body.length == 0) return getSchedule();
      return json.decode(response.body)['schedule'];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load device');
    }
  }

  Future<bool> setSchedule(Map scheduleData) async {
    String url = 'https://happygarden-bev02.herokuapp.com/schedule/' + userId;
    print(json.encode(scheduleData));
    final response = await http.post(
      Uri.parse(url),
      headers: {"content-type": "application/json"},
      body: json.encode(scheduleData),
    );
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
}
