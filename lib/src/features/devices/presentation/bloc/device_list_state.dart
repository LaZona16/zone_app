import 'package:equatable/equatable.dart';
import 'package:zone_app/src/features/devices/domain/entity/device_entity.dart';

enum DeviceListStatus { initial, searching, done, error }

class DeviceListState extends Equatable {
  final DeviceListStatus status;
  final String? message;
  final List<DeviceEntity> devices;

  //The page is init
  const DeviceListState.initial()
      : devices = const <DeviceEntity>[],
        message = null,
        status = DeviceListStatus.initial;

  // Loading
  const DeviceListState.searching()
      : devices = const <DeviceEntity>[],
        message = null,
        status = DeviceListStatus.searching;

  //Devices got
  const DeviceListState.done(this.devices)
      : message = null,
        status = DeviceListStatus.done;

  // Error
  const DeviceListState.error(this.message)
      : devices = const <DeviceEntity>[],
        status = DeviceListStatus.error;

  @override
  List<Object?> get props => [message, devices, status];
}
