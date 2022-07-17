import 'package:flutter/material.dart';
import 'package:zone_app/business_logic/models/bluetooth_device.dart';

import 'package:zone_app/services/bluetooth/bluetooth_service.dart';
import 'package:zone_app/services/service_locator.dart';

class SettingsScreenViewModel with ChangeNotifier {
  final BluetoothServiceApi _bluetoothService =
      serviceLocator<BluetoothServiceApi>();
  List<BluetoothDeviceData> _devices = [];

  List<BluetoothDeviceData> get devices => _devices;

  //Search for BE devices
  Future<void> loadData() async {
    _devices = await _bluetoothService.scanBluetoothDevices();
    notifyListeners();
  }

  void clearData() {
    _devices.clear();
    notifyListeners();
  }
}
