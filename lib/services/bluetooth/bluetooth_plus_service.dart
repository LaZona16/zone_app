import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:zone_app/business_logic/models/bluetooth_device.dart';
import 'package:zone_app/services/bluetooth/bluetooth_service.dart';

class BluetoothServicePlus implements BluetoothServiceApi {
  final List<Guid> _ZONE_Services = [
    Guid("0000ffe0-0000-1000-8000-00805f9b34fb"), //ZWall Service
  ];

  @override
  Stream<List<DeviceModel>> scanBluetoothDevices() {
    final FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
    // Start scanning
    flutterBlue.startScan(
        scanMode: ScanMode.lowLatency,
        allowDuplicates: false,
        timeout: const Duration(seconds: 5),
        withServices: _ZONE_Services);

    // Listen to scan results
    return flutterBlue.scanResults.map((event) => event
        .map((e) => DeviceModel(name: '${e.device.name} ${e.device.id}'))
        .toList());
  }
}
