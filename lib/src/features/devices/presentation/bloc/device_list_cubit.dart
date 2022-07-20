import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zone_app/src/core/usecases.dart';
import 'package:zone_app/src/features/devices/domain/usecase/search_devices_usecase.dart';
import 'package:zone_app/src/features/devices/presentation/bloc/device_list_state.dart';

class DeviceListCubit extends Cubit<DeviceListState> {
  final SearchDeviceUseCase searchDevicesUseCase;

  DeviceListCubit({required this.searchDevicesUseCase})
      : super(const DeviceListState.initial());

  void startSearching() {
    emit(const DeviceListState.searching());
    final result = searchDevicesUseCase.call(NoParams());
    result.fold(
      (l) => emit(
        const DeviceListState.error('Not able to use bluetooth'),
      ),
      (stream) => stream.forEach((element) {
        emit(DeviceListState.done(element));
      }),
    );
  }
}
