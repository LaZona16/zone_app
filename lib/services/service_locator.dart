import 'package:get_it/get_it.dart';
import 'package:zone_app/business_logic/view_models/settings_viewmodel.dart';
import 'package:zone_app/services/bluetooth/bluetooth_service.dart';
import 'package:zone_app/services/bluetooth/bluetooth_service_fake.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator
      .registerLazySingleton<BluetoothService>(() => BluetoothServiceFake());

  serviceLocator.registerFactory<SettingsScreenViewModel>(
      () => SettingsScreenViewModel());
}
