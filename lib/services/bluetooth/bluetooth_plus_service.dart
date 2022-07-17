import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:zone_app/business_logic/models/bluetooth_device.dart';
import 'package:zone_app/services/bluetooth/bluetooth_service.dart';

class BluetoothServicePlus implements BluetoothServiceApi {
  Guid _ZONE_SERVICE = Guid("0000ffe0-0000-1000-8000-00805f9b34fb");

  final List<BluetoothDevice> _devicesList = [];

  @override
  Future<List<BluetoothDeviceData>> scanBluetoothDevices() async {
    await _searchZoneProducts();

    return Future<List<BluetoothDeviceData>>.value(_getDevicesWithNames());
  }

  _searchZoneProducts() async {
    FlutterBluePlus _flutterBlue = FlutterBluePlus.instance;
    print(_flutterBlue.isScanning);
    // Start scanning
    _flutterBlue.startScan(timeout: const Duration(seconds: 4));

    // Listen to scan results
    _flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        _addDeviceToList(r.device);
      }
    });

    // Stop scanning
    _flutterBlue.stopScan();
  }

  List<BluetoothDeviceData> _getDevicesWithNames() {
    return _devicesList
        .map((e) => BluetoothDeviceData(name: '${e.name} ${e.id}'))
        .toList();
  }

  _addDeviceToList(final BluetoothDevice device) {
    if (!_devicesList.contains(device) && device.name.contains('Z')) {
      _devicesList.add(device);
    }
  }
}
