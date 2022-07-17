import 'package:zone_app/business_logic/models/bluetooth_device.dart';
import 'package:zone_app/services/bluetooth/bluetooth_service.dart';

class BluetoothServiceFake implements BluetoothServiceApi {
  @override
  Future<List<BluetoothDeviceData>> scanBluetoothDevices() async {
    return [
      BluetoothDeviceData(name: "Disp1"),
      BluetoothDeviceData(name: "Disp2"),
      BluetoothDeviceData(name: "Disp3"),
      BluetoothDeviceData(name: "Disp4"),
      BluetoothDeviceData(name: "Disp5"),
    ];
  }
}
