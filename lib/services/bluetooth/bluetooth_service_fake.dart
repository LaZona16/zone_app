import 'package:zone_app/business_logic/models/bluetooth_device.dart';
import 'package:zone_app/services/bluetooth/bluetooth_service.dart';

class BluetoothServiceFake implements BluetoothService {
  @override
  List<BluetoothDevice> getBluetoothDevices() {
    return [
      BluetoothDevice(name: "Disp1"),
      BluetoothDevice(name: "Disp2"),
      BluetoothDevice(name: "Disp3"),
      BluetoothDevice(name: "Disp4"),
      BluetoothDevice(name: "Disp5"),
    ];
  }
}
