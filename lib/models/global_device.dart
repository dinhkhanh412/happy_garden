import 'dart:collection';

import 'package:flutter/material.dart';

class GlobalDeviceStatus extends ChangeNotifier {
  /// Internal, private state of the cart.
  /// 0 : light , 1 : pump
  List<bool> _status = [true, true];

  /// An unmodifiable view of the items in the cart.
  // UnmodifiableListView<DeviceAuto> get items => UnmodifiableListView(_items);

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void addDeviceStatus(bool isOn) {
    _status.add(isOn);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  bool getStatus(int idx) {
    return _status[idx];
  }

  void setDeviceStatus(bool isOn, int idx) {
    _status[idx] = isOn;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _status.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
