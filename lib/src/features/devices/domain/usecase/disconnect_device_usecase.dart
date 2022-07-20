import 'package:zone_app/src/core/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:zone_app/src/core/usecases.dart';
import 'package:zone_app/src/features/devices/domain/repository/device_repository.dart';
import 'package:zone_app/src/features/devices/domain/usecase/connect_device_usecase.dart';

class DisconnectDeviceUseCase extends UseCase<void, DeviceParams> {
  final DeviceRepository deviceRepository;

  DisconnectDeviceUseCase({required this.deviceRepository});

  @override
  Either<Failure, bool> call(DeviceParams params) {
    return deviceRepository.disconnect(params.device);
  }
}
