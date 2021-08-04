import 'package:flutter/material.dart';

BottomNavigationBar bottomNavigationBar(int _curentIndex, int _selectedIndex){
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.business),
        label: 'Business',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.school),
        label: 'School',
      ),
    ],
    currentIndex: _curentIndex,
    selectedItemColor: Color(0xff0C9359),
  );
}