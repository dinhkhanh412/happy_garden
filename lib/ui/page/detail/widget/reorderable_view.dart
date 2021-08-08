import 'package:flutter/material.dart';
import 'package:happy_garden/ui/page/detail/model/Log.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ReorderableViewPage extends StatefulWidget {
  List<String> item = [];
  @override
  _ReorderableViewPageState createState() => _ReorderableViewPageState();
}

class _ReorderableViewPageState extends State<ReorderableViewPage> {
  Future<List<Log>> futureLog;

  Future<List<Log>> fetchLog() async {
    var url = 'https://happygarden-bev02.herokuapp.com/log/get';

    Map data = {'userId': '61063c60d95daa29e8639f65'};
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      var items = json.decode(response.body)['data']['history'];
      List<Log> lst = [];
      for (var item in items) {
        lst.add(Log(item.toString()));
      }
      return lst;
    } else {
      throw Exception('Failed to load log');
    }
  }

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
        body: Center(
          child: FutureBuilder<List<Log>>(
            future: futureLog,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ReorderableListView(
                  children: <Widget>[
                    for (final items in snapshot.data)
                      Card(
                        key: ValueKey(items.x),
                        elevation: 2,
                        child: ListTile(
                          title: Text(items.x),
                        ),
                      ),
                  ],
                  onReorder: reorderData,
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
