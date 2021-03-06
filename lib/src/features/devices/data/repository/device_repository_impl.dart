// ignore: depend_on_referenced_packages
import 'package:async/async.dart';
import 'package:zone_app/src/core/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:zone_app/src/features/devices/data/local/bluetooth_device_local_source.dart';
import 'package:zone_app/src/features/devices/data/models/device_model.dart';
import 'package:zone_app/src/features/devices/data/models/hit_model.dart';
import 'package:zone_app/src/features/devices/domain/entity/device_entity.dart';
import 'package:zone_app/src/features/devices/domain/repository/device_repository.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  final DeviceLocalDataSource localDataSource;

  DeviceRepositoryImpl({required this.localDataSource});

  @override
  Either<Failure, Stream<List<DeviceModel>>> searchDevices() {
    try {
      final result = localDataSource.searchDevices();
      return Right(result);
    } on Exception {
      return Left(BluetoothFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> connect(DeviceEntity device) async {
    try {
      final result = await localDataSource.connect(device as DeviceModel);
      return Right(result);
    } on Exception {
      return Left(BluetoothFailure());
    }
  }

  @override
  Either<Failure, bool> disconnect(DeviceEntity device) {
    try {
      final result = localDataSource.disconnect(device as DeviceModel);
      return Right(result);
    } on Exception {
      return Left(BluetoothFailure());
    }
  }

  @override
  Future<Either<Failure, void>> writeValue(
      String deviceId, String field, String value) async {
    try {
      await localDataSource.writeValue(deviceId, field, value);
      return const Right(null);
    } on Exception {
      return Left(BluetoothFailure());
    }
  }

  @override
  Future<Either<Failure, Stream<HitModel>>> readValues(
      List<DeviceEntity> connectedDevices, String field) async {
    try {
      final streams = List<Stream<HitModel>>.empty(growable: true);
      for (var device in connectedDevices) {
        final stream =
            await localDataSource.readDevice(device as DeviceModel, field);
        streams.add(stream);
      }
      final result = StreamGroup.merge(streams).asBroadcastStream();
      return Right(result);
    } on Exception {
      return Left(BluetoothFailure());
    }
  }
}
