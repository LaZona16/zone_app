import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zone_app/src/features/devices/domain/usecase/read_values_usecase.dart';
import 'package:zone_app/src/features/devices/presentation/bloc/read_values_state.dart';

class ReadValuesCubit extends Cubit<ReadValuesState> {
  final ReadValuesUseCase readValuesUseCase;

  ReadValuesCubit({required this.readValuesUseCase})
      : super(ReadValuesState.initial());

  Future<void> readValues(String field) async {
    //Emit starting
    emit(ReadValuesState.listening());
    //Call the useCase
    final result = await readValuesUseCase.call(ReadValueParams(field: field));
    //emit the event of error or listening
    result.fold(
        (l) => emit(
              ReadValuesState.error('There was an error listening data'),
            ), (stream) {
      stream.listen(
        (element) {
          emit(ReadValuesState.done(element));
        },
      );
    });
  }
}
