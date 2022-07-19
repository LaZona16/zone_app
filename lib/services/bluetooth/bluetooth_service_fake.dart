import 'package:zone_app/business_logic/models/bluetooth_device.dart';
import 'package:zone_app/services/bluetooth/bluetooth_service.dart';

class BluetoothServiceFake implements BluetoothServiceApi {
  @override
  Stream<List<DeviceModel>> scanBluetoothDevices() {
    return Stream<List<DeviceModel>>.fromIterable(
      <List<DeviceModel>>[
        List<DeviceModel>.generate(
            10, (int i) => DeviceModel(name: 'Device${i}')),
      ],
    );
  }
}
