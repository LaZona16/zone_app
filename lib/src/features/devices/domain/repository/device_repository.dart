import 'package:dartz/dartz.dart';
import 'package:zone_app/src/core/failures.dart';
import 'package:zone_app/src/features/devices/data/models/device_model.dart';
import 'package:zone_app/src/features/devices/domain/entity/device_entity.dart';

abstract class DeviceRepository {
  Either<Failure, Stream<List<DeviceModel>>> searchDevices();

  Either<Failure, bool> connect(DeviceEntity device);

  Either<Failure, bool> disconnect(DeviceEntity device);

  Future<Either<Failure, void>> writeValue(
      DeviceEntity device, String field, String value);
}
