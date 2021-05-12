import 'package:flutter/material.dart';

Padding card(context, String name, IconData icon, String status) {
  return Padding(
    padding: EdgeInsets.all(0.0),
    child: Card(
      child: Column(
        children: [
          SizedBox(height: 5),
          Icon(
            icon,
            color: Color(0xff6CDAC1),
            size: 24,
          ),
          SizedBox(height: 5),
          Text(
            name,
            style: TextStyle(fontSize: 12, fontFamily: "Mulish", color: Color(0xff0C9359)),
          ),
          SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(
                fontSize: 16,
                fontFamily: "Mulish",
                color: Color(0xff0C9359),
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

Padding cardStat(context, String name, IconData icon, String status) {
  return Padding(
    padding: EdgeInsets.all(0.0),
    child: Card(
      child: Column(
        children: [
          SizedBox(height: 5),
          Text(
            "Status",
            style: TextStyle(fontSize: 12, fontFamily: "Mulish", color: Color(0xff0C9359)),
          ),
          SizedBox(height: 5),
        ],
      ),
    ),
  );
}
