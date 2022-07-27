import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zone_app/src/features/devices/domain/entity/device_entity.dart';
import 'package:zone_app/src/features/devices/domain/usecase/connect_device_usecase.dart';
import 'package:zone_app/src/features/devices/domain/usecase/disconnect_device_usecase.dart';
import 'package:zone_app/src/features/devices/presentation/bloc/device_state.dart';

class DeviceSelectedCubit extends Cubit<DeviceState> {
  final ConnectDeviceUseCase connectDeviceUseCase;
  final DisconnectDeviceUseCase disconnectDeviceUseCase;
  final Map<String, DeviceEntity> _connectedDevices = {};

  DeviceSelectedCubit(
      {required this.connectDeviceUseCase,
      required this.disconnectDeviceUseCase})
      : super(const DeviceState.initial());

  Future<void> connect(DeviceEntity device) async {
    final result =
        await connectDeviceUseCase.call(DeviceParams(device: device));

    result.fold(
      (l) => emit(const DeviceState.error('Error while connecting')),
      (r) {
        _connectedDevices[device.id] = device;
        emit(
          DeviceState.done(_connectedDevices.length),
        );
      },
    );
  }

  void disconnect(DeviceEntity device) {
    final result = disconnectDeviceUseCase.call(DeviceParams(device: device));

    result.fold(
      (l) => emit(
        const DeviceState.error('Error while connecting'),
      ),
      (r) {
        _connectedDevices.removeWhere(
          (key, _) => key == device.id,
        );
        emit(
          DeviceState.done(_connectedDevices.length),
        );
      },
    );
  }

  List<DeviceEntity> get connectedDevices {
    return _connectedDevices.entries.map((e) => e.value).toList();
  }
}
