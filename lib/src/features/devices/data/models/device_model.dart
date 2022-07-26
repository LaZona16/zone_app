import 'package:zone_app/src/features/devices/domain/entity/device_entity.dart';
import 'dart:math';

class DeviceModel extends DeviceEntity {
  DeviceModel({
    required String name,
    required int strength,
    required String id,
  }) : super(
          id: id,
          name: name,
          strength: strength,
        );

  static List<DeviceModel> generateFakeDevices() {
    Random random = new Random();
    final fakeDevices = <DeviceModel>[
      DeviceModel(
        id: '3D:D0:47:54:74:2A',
        name: 'ZWall Fake 1',
        strength: random.nextInt(100) * -1,
      ),
      DeviceModel(
        id: 'F2:70:28:6A:65:9E',
        name: 'ZWall Fake 2',
        strength: random.nextInt(100) * -1,
      ),
      DeviceModel(
        id: 'F0:A3:FC:A9:41:46',
        name: 'ZWall Fake 3',
        strength: random.nextInt(100) * -1,
      ),
      DeviceModel(
        id: '37:8D:DF:62:E6:B9',
        name: 'ZWall Fake 4',
        strength: random.nextInt(100) * -1,
      ),
      DeviceModel(
        id: 'E3:7C:7B:5C:0B:C5',
        name: 'ZWall Fake 5',
        strength: random.nextInt(100) * -1,
      ),
    ];
    return fakeDevices;
  }
}
