import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zone_app/src/features/devices/domain/entity/device_entity.dart';
import 'package:zone_app/src/features/devices/domain/usecase/write_values_usecase.dart';
import 'package:zone_app/src/features/devices/presentation/bloc/write_value_state.dart';

class WriteValueCubit extends Cubit<WriteValueState> {
  final WriteValueUseCase writeValueUseCase;

  WriteValueCubit({required this.writeValueUseCase})
      : super(WriteValueState.initial());

  Future<void> writeValue(String deviceId, String field, String value) async {
    final result = await writeValueUseCase
        .call(WriteValueParams(deviceId: deviceId, field: field, value: value));

    result.fold(
      (l) => emit(WriteValueState.error('Error sending data', deviceId)),
      (r) => emit(
        WriteValueState.done(deviceId, value),
      ),
    );
  }
}
