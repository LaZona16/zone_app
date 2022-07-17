import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zone_app/business_logic/view_models/settings_viewmodel.dart';
import 'package:zone_app/services/service_locator.dart';
import 'package:zone_app/ui/widgets/device_items.dart';
import 'package:zone_app/ui/widgets/text_icon.dart';

class SettingsPage extends StatelessWidget {
  SettingsScreenViewModel settingsModel =
      serviceLocator<SettingsScreenViewModel>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsScreenViewModel>(
      create: (context) => settingsModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Settings Bar"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
                "*Turn On your Smart Phone Bluetooth to sync La Zona Products"),
            // Click to search
            IconButton(
              onPressed: () {
                settingsModel.loadData();
              },
              icon: Icon(Icons.start),
            ),
            const TextIcon(icon: Icons.bluetooth, title: "Search for Products"),
            //ListView of Bluetooth Devices
            Consumer<SettingsScreenViewModel>(
              builder: (context, model, child) =>
                  DeviceItems(devices: model.devices),
            ),
            //Click to delete
            IconButton(
              onPressed: () {
                settingsModel.clearData();
              },
              icon: Icon(Icons.delete),
            ),
            // Syncronized products
            // Card of 3 products

            //Default Color

            //Colors
          ],
        ),
      ),
    );
  }
}
