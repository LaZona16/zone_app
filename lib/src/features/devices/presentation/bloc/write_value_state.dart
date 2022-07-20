import 'package:equatable/equatable.dart';
import 'package:zone_app/src/features/devices/domain/entity/device_entity.dart';

enum WriteValueStatus { initial, done, error }

class WriteValueState extends Equatable {
  final WriteValueStatus status;
  final String? message;
  final DeviceEntity device;
  final String value;
  //The page is init
  WriteValueState.initial()
      : device = DeviceEntity.empty(),
        message = null,
        value = '',
        status = WriteValueStatus.initial;

  // Loading
  const WriteValueState.done(
    this.device,
    this.value,
  )   : message = null,
        status = WriteValueStatus.done;

  // Error
  WriteValueState.error(this.message)
      : device = DeviceEntity.empty(),
        value = '',
        status = WriteValueStatus.error;

  @override
  List<Object?> get props => [message, device, status, value];
}
