import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zone_app/src/features/devices/domain/entity/device_entity.dart';
import 'package:zone_app/src/features/devices/domain/usecase/connect_device_usecase.dart';
import 'package:zone_app/src/features/devices/domain/usecase/disconnect_device_usecase.dart';
import 'package:zone_app/src/features/devices/presentation/bloc/device_state.dart';

class DeviceSelectedCubit extends Cubit<DeviceState> {
  final ConnectDeviceUseCase connectDeviceUseCase;
  final DisconnectDeviceUseCase disconnectDeviceUseCase;
  List<DeviceEntity> connectedDevices = [];

  DeviceSelectedCubit(
      {required this.connectDeviceUseCase,
      required this.disconnectDeviceUseCase})
      : super(DeviceState.initial());

  Future<void> connect(DeviceEntity device) async {
    final result =
        await connectDeviceUseCase.call(DeviceParams(device: device));

    result.fold(
      (l) => emit(DeviceState.error('Error while connecting')),
      (r) {
        connectedDevices.add(device);
        emit(
          DeviceState.done(connectedDevices.length),
        );
      },
    );
  }

  void disconnect(DeviceEntity device) {
    final result = disconnectDeviceUseCase.call(DeviceParams(device: device));

    result.fold(
      (l) => emit(
        DeviceState.error('Error while connecting'),
      ),
      (r) {
        connectedDevices.remove(device);
        emit(
          DeviceState.done(connectedDevices.length),
        );
      },
    );
  }
}
