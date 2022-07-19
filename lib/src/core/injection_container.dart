import 'package:get_it/get_it.dart';
import 'package:zone_app/src/features/devices/data/local/bluetooth_device_local_source.dart';
import 'package:zone_app/src/features/devices/data/repository/device_repository_impl.dart';
import 'package:zone_app/src/features/devices/domain/repository/device_repository.dart';
import 'package:zone_app/src/features/devices/domain/usecase/search_devices_usecase.dart';
import 'package:zone_app/src/features/devices/presentation/bloc/device_list_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory<DeviceLocalDataSource>(
      () => BluetoothDeviceLocalDataSourceImpl());
  sl.registerFactory<DeviceRepository>(
      () => DeviceRepositoryImpl(localDataSource: sl()));

  sl.registerFactory<SearchDeviceUseCase>(
    () => SearchDeviceUseCase(deviceRepository: sl()),
  );
  //Cubits must init as singleton
  sl.registerSingleton<DeviceListCubit>(
      DeviceListCubit(searchDevicesUseCase: sl()));
  //Services must init as factory
}
