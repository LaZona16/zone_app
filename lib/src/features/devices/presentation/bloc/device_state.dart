import 'package:equatable/equatable.dart';
import 'package:zone_app/src/features/devices/domain/entity/device_entity.dart';

enum DeviceStatus { initial, done, error }

class DeviceState extends Equatable {
  final DeviceStatus status;
  final String? message;
  final DeviceEntity device;
  final bool connected;
  //The page is init
  DeviceState.initial()
      : device = DeviceEntity.empty(),
        message = null,
        connected = false,
        status = DeviceStatus.initial;

  // Loading
  const DeviceState.done(this.device, this.connected)
      : message = null,
        status = DeviceStatus.done;

  // Error
  DeviceState.error(this.message)
      : device = DeviceEntity.empty(),
        connected = false,
        status = DeviceStatus.error;

  @override
  List<Object?> get props => [message, device, status, connected];
}
