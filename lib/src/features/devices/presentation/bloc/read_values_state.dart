import 'package:equatable/equatable.dart';
import 'package:zone_app/src/features/devices/domain/entity/hit_entity.dart';

enum ReadValuesStatus { initial, listening, done, error }

class ReadValuesState extends Equatable {
  final ReadValuesStatus status;
  final String? message;
  final HitEntity hit;

  //The page is init
  ReadValuesState.initial()
      : hit = HitEntity.empty(),
        message = null,
        status = ReadValuesStatus.initial;

  // Loading
  ReadValuesState.listening()
      : hit = HitEntity.empty(),
        message = null,
        status = ReadValuesStatus.listening;

  //Devices got
  const ReadValuesState.done(this.hit)
      : message = null,
        status = ReadValuesStatus.done;

  // Error
  ReadValuesState.error(this.message)
      : hit = HitEntity.empty(),
        status = ReadValuesStatus.error;

  @override
  List<Object?> get props => [message, hit, status];
}
