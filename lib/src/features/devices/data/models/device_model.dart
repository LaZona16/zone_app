import 'package:zone_app/src/features/devices/domain/entity/device_entity.dart';

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
}
