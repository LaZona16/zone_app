import 'package:zone_app/src/core/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:zone_app/src/core/usecases.dart';
import 'package:zone_app/src/features/devices/domain/entity/hit_entity.dart';
import 'package:zone_app/src/features/devices/domain/repository/device_repository.dart';

class ReadValuesUseCase
    extends FutureUseCase<Stream<HitEntity>, ReadValueParams> {
  final DeviceRepository deviceRepository;

  ReadValuesUseCase({required this.deviceRepository});

  @override
  Future<Either<Failure, Stream<HitEntity>>> call(ReadValueParams params) {
    return deviceRepository.readValues(params.field);
  }
}

class ReadValueParams {
  final String field;
  ReadValueParams({
    required this.field,
  });
}
