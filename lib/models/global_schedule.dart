import 'dart:collection';

import 'package:happy_garden/models/Device_Auto.dart';
import 'package:flutter/material.dart';

class GlobalSchedule extends ChangeNotifier {
  /// Internal, private state of the cart.
  List<DeviceAuto> _items = [
    DeviceAuto("TEMP-HUMID", "0-0", "0-0", "00:00:00", "23:59:99", false),
    DeviceAuto("SOIL", "0", "0", "00:00:00", "23:59:99", false),
    DeviceAuto("LIGHT", "0", "0", "00:00:00", "23:59:99", false)
  ];

  /// An unmodifiable view of the items in the cart.
  // UnmodifiableListView<DeviceAuto> get items => UnmodifiableListView(_items);

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(DeviceAuto item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  List<DeviceAuto> get listSchedule => _items;

  void setSchedule(DeviceAuto item, int index) {
    _items[index] = item;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  DeviceAuto getDevice(int index) {
    return _items[index];
  }

  /// Removes all items from the cart.
  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
