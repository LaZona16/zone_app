import 'dart:convert';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:zone_app/src/core/exceptions.dart';
import 'package:zone_app/src/features/devices/data/local/helpers/bluetooth_device_extension.dart';
import 'package:zone_app/src/features/devices/data/models/device_model.dart';

abstract class DeviceLocalDataSource {
  Stream<List<DeviceModel>> searchDevices();

  bool connect(DeviceModel device);
  bool disconnect(DeviceModel device);
  Future<void> writeValue(DeviceModel device, String field, String value);
}

class BluetoothDeviceLocalDataSourceImpl extends DeviceLocalDataSource {
  final List<Guid> _ZONE_Services = [
    Guid("0000ffe0-0000-1000-8000-00805f9b34fb"), //ZWall Service
  ];

  @override
  Stream<List<DeviceModel>> searchDevices() {
    FlutterBluePlus flutterBluePlus = FlutterBluePlus.instance;

    flutterBluePlus.startScan(
        scanMode: ScanMode.lowLatency,
        allowDuplicates: false,
        timeout: const Duration(seconds: 5),
        withServices: _ZONE_Services);

    return flutterBluePlus.scanResults.map((event) => event
        .map((e) => DeviceModel(
              name: e.device.name,
              strength: e.rssi,
              id: e.device.id.id,
            ))
        .toList());
  }

  @override
  bool connect(DeviceModel device) {
    final bluetoothDevice = device.toBluetoothDevice();
    bluetoothDevice
        .connect()
        .onError((error, stackTrace) => throw UnableToConnectException());
    return true;
  }

  @override
  bool disconnect(DeviceModel device) {
    final bluetoothDevice = device.toBluetoothDevice();
    bluetoothDevice
        .disconnect()
        .onError((error, stackTrace) => throw UnableToConnectException());
    return true;
  }

  @override
  Future<void> writeValue(
      DeviceModel device, String field, String value) async {
    final BluetoothDevice bluedevice = device.toBluetoothDevice();
    final services = await bluedevice.discoverServices();
    if (serviceMaps.containsKey(field)) {
      for (BluetoothService service in services) {
        if (service.uuid.toString() == serviceMaps[field]['serviceUUID']) {
          final characteristics = service.characteristics;
          for (BluetoothCharacteristic characteristic in characteristics) {
            if (characteristic.uuid.toString() ==
                serviceMaps[field]['characteristicUUID']) {
              await characteristic.write(utf8.encode(value));
            }
          }
        }
      }
    }
  }
}

final Map serviceMaps = {
  'Wall': {
    'serviceUUID': '0000ffe0-0000-1000-8000-00805f9b34fb',
    'characteristicUUID': '0000ffe1-0000-1000-8000-00805f9b34fb',
  }
};
