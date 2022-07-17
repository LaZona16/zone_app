import 'package:flutter/material.dart';
import 'package:zone_app/business_logic/models/bluetooth_device.dart';

import 'package:zone_app/services/bluetooth/bluetooth_service.dart';
import 'package:zone_app/services/service_locator.dart';

class SettingsScreenViewModel with ChangeNotifier {
  final BluetoothService _bluetoothService = serviceLocator<BluetoothService>();
  List<BluetoothDevice> _devices = [];

  List<BluetoothDevice> get devices => _devices;

  //Search for BE devices
  void loadData() {
    _devices = _bluetoothService.getBluetoothDevices();
    notifyListeners();
  }

  void clearData() {
    _devices.clear();
    notifyListeners();
  }
}
