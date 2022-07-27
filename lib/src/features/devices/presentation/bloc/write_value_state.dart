import 'package:equatable/equatable.dart';

enum WriteValueStatus { initial, done, error }

class WriteValueState extends Equatable {
  final WriteValueStatus status;
  final String? message;
  final String? deviceId;
  final String value;
  //The page is init
  const WriteValueState.initial()
      : deviceId = null,
        message = null,
        value = '',
        status = WriteValueStatus.initial;

  // Loading
  const WriteValueState.done(
    this.deviceId,
    this.value,
  )   : message = null,
        status = WriteValueStatus.done;

  // Error
  const WriteValueState.error(this.message, this.deviceId)
      : value = '',
        status = WriteValueStatus.error;

  @override
  List<Object?> get props => [message, deviceId, status, value];
}
