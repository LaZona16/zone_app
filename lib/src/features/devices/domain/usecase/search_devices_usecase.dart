import 'package:zone_app/src/core/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:zone_app/src/core/usecases.dart';
import 'package:zone_app/src/features/devices/domain/entity/device_entity.dart';
import 'package:zone_app/src/features/devices/domain/repository/device_repository.dart';

class SearchDeviceUseCase extends UseCase<void, NoParams> {
  final DeviceRepository deviceRepository;

  SearchDeviceUseCase({required this.deviceRepository});

  @override
  Either<Failure, Stream<List<DeviceEntity>>> call(NoParams params) {
    return deviceRepository.searchDevices();
  }
}
