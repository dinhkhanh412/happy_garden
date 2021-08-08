import 'package:flutter/material.dart';
import 'package:happy_garden/ui/page/detail/model/Log.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ReorderableViewPage extends StatefulWidget {
  List<String> item = ["Fire"];

  @override
  _ReorderableViewPageState createState() => _ReorderableViewPageState();
}

Future<Log> fetchLog() async {
  var url = 'https://happygarden-bev02.herokuapp.com/log/get';

  Map data = {'userId': '61063c60d95daa29e8639f65'};
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: body);

  if (response.statusCode == 200) {
    var items = json.decode(response.body)['data']['history'];
    for (var item in items) {
      print(item);
    }
  } else {
    throw Exception('Failed to load log');
  }
}

class _ReorderableViewPageState extends State<ReorderableViewPage> {
  Future<Log> futureLog;

  void reorderData(int oldindex, int newindex) {
    setState(() {
      if (newindex > oldindex) {
        newindex -= 1;
      }
      final items = widget.item.removeAt(oldindex);
      widget.item.insert(newindex, items);
    });
  }

  void sorting() {
    setState(() {
      widget.item.sort();
    });
  }

  @override
  void initState() {
    super.initState();
    futureLog = fetchLog();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Sort by name",
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.sort_by_alpha),
                tooltip: "Sort",
                onPressed: sorting),
          ],
        ),
        body: ReorderableListView(
          children: <Widget>[
            for (final items in widget.item)
              Card(
                key: ValueKey(items),
                elevation: 2,
                child: ListTile(
                  title: Text(items),
                ),
              ),
          ],
          onReorder: reorderData,
        ),
      ),
    );
  }
}
