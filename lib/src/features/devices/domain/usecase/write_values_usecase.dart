import 'package:zone_app/src/core/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:zone_app/src/core/usecases.dart';
import 'package:zone_app/src/features/devices/domain/entity/device_entity.dart';
import 'package:zone_app/src/features/devices/domain/repository/device_repository.dart';

class WriteValueUseCase extends FutureUseCase<void, WriteValueParams> {
  final DeviceRepository deviceRepository;

  WriteValueUseCase({required this.deviceRepository});

  @override
  Future<Either<Failure, void>> call(WriteValueParams params) {
    return deviceRepository.writeValue(
        params.device, params.field, params.value);
  }
}

class WriteValueParams {
  final DeviceEntity device;
  final String field;
  final String value;

  WriteValueParams({
    required this.device,
    required this.field,
    required this.value,
  });
}
