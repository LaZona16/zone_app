import 'package:get_it/get_it.dart';
import 'package:zone_app/src/features/devices/data/local/bluetooth_device_local_source.dart';
import 'package:zone_app/src/features/devices/data/repository/device_repository_impl.dart';
import 'package:zone_app/src/features/devices/domain/repository/device_repository.dart';
import 'package:zone_app/src/features/devices/domain/usecase/connect_device_usecase.dart';
import 'package:zone_app/src/features/devices/domain/usecase/disconnect_device_usecase.dart';
import 'package:zone_app/src/features/devices/domain/usecase/read_values_usecase.dart';
import 'package:zone_app/src/features/devices/domain/usecase/search_devices_usecase.dart';
import 'package:zone_app/src/features/devices/domain/usecase/write_values_usecase.dart';
import 'package:zone_app/src/features/devices/presentation/bloc/device_list_cubit.dart';
import 'package:zone_app/src/features/devices/presentation/bloc/device_selected_cubit.dart';
import 'package:zone_app/src/features/devices/presentation/bloc/read_values_cubit.dart';
import 'package:zone_app/src/features/devices/presentation/bloc/write_value_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Services
  sl.registerFactory<DeviceLocalDataSource>(
      () => BluetoothDeviceLocalDataSourceImpl());
  sl.registerFactory<DeviceRepository>(
      () => DeviceRepositoryImpl(localDataSource: sl()));
  //Use cases
  sl.registerFactory<SearchDeviceUseCase>(
    () => SearchDeviceUseCase(deviceRepository: sl()),
  );
  sl.registerFactory<ConnectDeviceUseCase>(
    () => ConnectDeviceUseCase(deviceRepository: sl()),
  );
  sl.registerFactory<DisconnectDeviceUseCase>(
    () => DisconnectDeviceUseCase(deviceRepository: sl()),
  );
  sl.registerFactory<WriteValueUseCase>(
    () => WriteValueUseCase(deviceRepository: sl()),
  );
  sl.registerFactory<ReadValuesUseCase>(
    () => ReadValuesUseCase(deviceRepository: sl()),
  );
  //Cubits must init as singleton
  sl.registerSingleton<DeviceListCubit>(
      DeviceListCubit(searchDevicesUseCase: sl()));
  sl.registerSingleton<DeviceSelectedCubit>(DeviceSelectedCubit(
    connectDeviceUseCase: sl(),
    disconnectDeviceUseCase: sl(),
  ));
  sl.registerSingleton<WriteValueCubit>(
      WriteValueCubit(writeValueUseCase: sl()));

  sl.registerSingleton<ReadValuesCubit>(
      ReadValuesCubit(readValuesUseCase: sl()));
}
