import 'package:flutter/material.dart';

class ReorderableViewPage extends StatefulWidget {
  List<String> item = [
    "Fire",
    "Water",
    "Air",
    "Earth",
  ];
  @override
  _ReorderableViewPageState createState() => _ReorderableViewPageState();
}

class _ReorderableViewPageState extends State<ReorderableViewPage> {
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
