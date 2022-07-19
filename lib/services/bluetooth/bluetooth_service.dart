import 'package:zone_app/business_logic/models/bluetooth_device.dart';

abstract class BluetoothServiceApi {
  Stream<List<DeviceModel>> scanBluetoothDevices();
}
