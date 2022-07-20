import 'package:zone_app/src/core/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:zone_app/src/core/usecases.dart';
import 'package:zone_app/src/features/devices/domain/entity/device_entity.dart';
import 'package:zone_app/src/features/devices/domain/repository/device_repository.dart';

class ConnectDeviceUseCase extends UseCase<void, DeviceParams> {
  final DeviceRepository deviceRepository;

  ConnectDeviceUseCase({required this.deviceRepository});

  @override
  Either<Failure, bool> call(DeviceParams params) {
    return deviceRepository.connect(params.device);
  }
}

class DeviceParams {
  final DeviceEntity device;
  DeviceParams({required this.device});
}
