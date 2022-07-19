import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:zone_app/src/features/devices/data/models/device_model.dart';

abstract class DeviceLocalDataSource {
  Stream<List<DeviceModel>> searchDevices();
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
}
