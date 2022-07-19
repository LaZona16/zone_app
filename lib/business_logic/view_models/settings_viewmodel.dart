import 'package:flutter/material.dart';
import 'package:zone_app/business_logic/models/bluetooth_device.dart';

import 'package:zone_app/services/bluetooth/bluetooth_service.dart';
import 'package:zone_app/services/service_locator.dart';

class SettingsScreenViewModel with ChangeNotifier {
  final BluetoothServiceApi _bluetoothService =
      serviceLocator<BluetoothServiceApi>();
  Stream<List<DeviceModel>> _devices = const Stream.empty();

  Stream<List<DeviceModel>> get devices => _devices;

  //Search for BE devices
  Future<void> loadData() async {
    _devices = await _bluetoothService.scanBluetoothDevices();
    notifyListeners();
  }

  void clearDevices() {
    _devices = Stream<List<DeviceModel>>.fromIterable(<List<DeviceModel>>[]);
    notifyListeners();
  }
}
