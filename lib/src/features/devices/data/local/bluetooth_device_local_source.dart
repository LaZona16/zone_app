import 'dart:convert';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:zone_app/src/core/exceptions.dart';
import 'package:zone_app/src/features/devices/data/local/helpers/bluetooth_device_extension.dart';
import 'package:zone_app/src/features/devices/data/models/device_model.dart';
import 'package:zone_app/src/features/devices/data/models/hit_model.dart';
import 'package:zone_app/src/features/devices/domain/entity/hit_entity.dart';

abstract class DeviceLocalDataSource {
  Stream<List<DeviceModel>> searchDevices();
  Future<bool> connect(DeviceModel device);
  bool disconnect(DeviceModel device);
  Future<void> writeValue(String deviceId, String field, String value);
  Future<Stream<HitModel>> readDevice(DeviceModel device, String field);
}

class BluetoothDeviceLocalDataSourceImpl extends DeviceLocalDataSource {
  final Map<String, DeviceModel> connectedDevices = <String, DeviceModel>{};

  @override
  Stream<List<DeviceModel>> searchDevices() {
    FlutterBluePlus flutterBluePlus = FlutterBluePlus.instance;
    List<Guid> zoneServices = [];
    _serviceMaps.forEach(
      (key, value) {
        zoneServices.add(Guid(value['serviceUUID']));
      },
    );
    flutterBluePlus.startScan(
        scanMode: ScanMode.lowLatency,
        allowDuplicates: false,
        timeout: const Duration(seconds: 5),
        withServices: zoneServices);

    return flutterBluePlus.scanResults.map((event) => event
        .map((e) => DeviceModel(
              name: e.device.name,
              strength: e.rssi,
              id: e.device.id.id,
            ))
        .toList());
  }

  @override
  Future<bool> connect(DeviceModel device) async {
    final bluetoothDevice = device.toBluetoothDevice();
    await bluetoothDevice
        .connect()
        .onError((error, stackTrace) => throw UnableToConnectException());
    if (!connectedDevices.containsKey(device.id)) {
      connectedDevices[device.id] = device;
    }
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
  Future<void> writeValue(String deviceId, String field, String value) async {
    final device = connectedDevices[deviceId];
    final BluetoothDevice bluedevice = device!.toBluetoothDevice();
    if (_serviceMaps.containsKey(field)) {
      BluetoothCharacteristic characteristic =
          await _getBluetoothCharacteristic(bluedevice, field);
      await characteristic.write(utf8.encode(value));
    }
  }

  @override
  Future<Stream<HitModel>> readDevice(DeviceModel device, String field) async {
    final BluetoothDevice bluedevice = device.toBluetoothDevice();
    if (_serviceMaps.containsKey(field)) {
      BluetoothCharacteristic characteristic =
          await _getBluetoothCharacteristic(bluedevice, field);
      await characteristic.setNotifyValue(true);
      return characteristic.value.map(
        (event) {
          if (event.isNotEmpty || event.length > 2) {
            int force = event.elementAt(2);
            int pos = event.elementAt(1);
            Position position = Position.center;
            if (pos == 49 || pos == 50) {
              position = Position.left;
            }
            if (pos == 52 || pos == 53) {
              position = Position.right;
            }
            return HitModel(
              force: force,
              shooted: true,
              position: position,
              id: device.id,
            );
          }

          HitModel hit = HitModel(
            force: 0,
            shooted: false,
            position: Position.center,
            id: '-1',
          );
          return hit;
        },
      );
    }
    throw (Exception());
  }
}

Future<BluetoothCharacteristic> _getBluetoothCharacteristic(
    BluetoothDevice device, String field) async {
  final services = await device.discoverServices();
  final service = services.firstWhere((service) =>
      service.uuid.toString() == _serviceMaps[field]['serviceUUID']);

  return service.characteristics.first;
}

class BluetoothDeviceFakeImpl extends DeviceLocalDataSource {
  @override
  Stream<List<DeviceModel>> searchDevices() async* {
    final fakeDevices = DeviceModel.generateFakeDevices();
    await Future.delayed(const Duration(seconds: 1));
    yield fakeDevices;
  }

  @override
  Future<bool> connect(DeviceModel device) async {
    await Future.delayed(const Duration(microseconds: 100));
    return true;
  }

  @override
  bool disconnect(DeviceModel device) {
    return true;
  }

  @override
  Future<Stream<HitModel>> readDevice(DeviceModel device, String field) {
    // TODO: implement readDevice
    throw UnimplementedError();
  }

  @override
  Future<void> writeValue(String deviceId, String field, String value) {
    // TODO: implement writeValue
    throw UnimplementedError();
  }
}

final Map _serviceMaps = {
  'Wall': {
    'serviceUUID': '0000ffe0-0000-1000-8000-00805f9b34fb',
    'characteristicUUID': '0000ffe1-0000-1000-8000-00805f9b34fb',
  }
};
