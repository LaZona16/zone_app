import 'dart:convert';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zone_app/src/core/exceptions.dart';
import 'package:zone_app/src/features/devices/data/local/helpers/bluetooth_device_extension.dart';
import 'package:zone_app/src/features/devices/data/models/device_model.dart';
import 'package:zone_app/src/features/devices/data/models/hit_model.dart';
import 'package:zone_app/src/features/devices/data/models/hit_model.dart';
import 'package:zone_app/src/features/devices/domain/entity/hit_entity.dart';

abstract class DeviceLocalDataSource {
  Stream<List<DeviceModel>> searchDevices();
  bool connect(DeviceModel device);
  bool disconnect(DeviceModel device);
  Future<void> writeValue(String deviceId, String field, String value);
  Future<Stream<HitModel>> readValues(String field);
}

class BluetoothDeviceLocalDataSourceImpl extends DeviceLocalDataSource {
  final Map<String, DeviceModel> connectedDevices = <String, DeviceModel>{};

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
    if (!connectedDevices.containsKey(device.id)) {
      connectedDevices[device.id] = device;
    }
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
  Future<void> writeValue(String deviceId, String field, String value) async {
    final device = connectedDevices[deviceId];
    final BluetoothDevice bluedevice = device!.toBluetoothDevice();
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

  @override
  Future<Stream<HitModel>> readValues(String field) async {
    MergeStream<HitModel> mergedStream = MergeStream([]);
    print(connectedDevices);
    connectedDevices.forEach(
      (key, device) async {
        final result = await readDevice(device, field);
        mergedStream = MergeStream([mergedStream, result]);
      },
    );
    return mergedStream;
  }

  @override
  Future<Stream<HitModel>> readDevice(DeviceModel device, String field) async {
    final BluetoothDevice bluedevice = device.toBluetoothDevice();
    final services = await bluedevice.discoverServices();
    if (serviceMaps.containsKey(field)) {
      for (BluetoothService service in services) {
        if (service.uuid.toString() == serviceMaps[field]['serviceUUID']) {
          final characteristics = service.characteristics;
          for (BluetoothCharacteristic characteristic in characteristics) {
            if (characteristic.uuid.toString() ==
                serviceMaps[field]['characteristicUUID']) {
              await characteristic.setNotifyValue(true);
              return characteristic.value.map(
                (event) {
                  if (event.isNotEmpty) {
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
          }
        }
      }
    }
    throw (Exception());
  }
}

final Map serviceMaps = {
  'Wall': {
    'serviceUUID': '0000ffe0-0000-1000-8000-00805f9b34fb',
    'characteristicUUID': '0000ffe1-0000-1000-8000-00805f9b34fb',
  }
};
