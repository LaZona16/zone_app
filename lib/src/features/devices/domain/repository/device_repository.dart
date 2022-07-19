import 'package:dartz/dartz.dart';
import 'package:zone_app/src/core/failures.dart';
import 'package:zone_app/src/features/devices/data/models/device_model.dart';

abstract class DeviceRepository {
  Either<Failure, Stream<List<DeviceModel>>> searchDevices();
}
