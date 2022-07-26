import 'package:equatable/equatable.dart';
import 'package:zone_app/src/features/devices/domain/entity/device_entity.dart';

enum DeviceStatus { initial, done, error }

class DeviceState extends Equatable {
  final DeviceStatus status;
  final String? message;
  final int quantity;
  //The page is init
  DeviceState.initial()
      : quantity = 0,
        message = null,
        status = DeviceStatus.initial;

  // Done
  const DeviceState.done(this.quantity)
      : message = null,
        status = DeviceStatus.done;

  // Error
  DeviceState.error(this.message)
      : quantity = 0,
        status = DeviceStatus.error;

  @override
  List<Object?> get props => [message, quantity, status];
}
