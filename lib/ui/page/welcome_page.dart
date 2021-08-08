import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
          backgroundColor: Color(0xff0C9359),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: constraints.maxHeight * 0.4),
              Text("Welcome to ",
                  style: GoogleFonts.mulish(
                      textStyle: TextStyle(color: Colors.white),
                      fontSize: 26,
                      fontWeight: FontWeight.w900)),
              Text("Happy Garden",
                  style: GoogleFonts.mulish(
                      textStyle: TextStyle(color: Colors.white),
                      fontSize: 32,
                      fontWeight: FontWeight.w900)),
              SizedBox(height: 50),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  minimumSize: MaterialStateProperty.all<Size>(
                      Size(constraints.maxWidth * 0.95, 50)),
                ),
                onPressed: () {},
                child: Text('TextButton'),
              )
            ],
          ));
    });

    throw UnimplementedError();
  }
}
