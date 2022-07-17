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
            Container(
                child: const Center(
              child: Icon(
                Icons.settings,
                color: Color.fromARGB(85, 0, 181, 0),
              ),
            )),
            const Center(
              child: Text(
                "*Turn On your Smart Phone Bluetooth to sync La Zona Products",
                style: TextStyle(fontSize: 10),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextIcon(
                      icon: Icons.bluetooth,
                      title: "Search for Products",
                      onPressed: () {
                        settingsModel.loadData();
                      },
                    )
                  ],
                )),
            const Divider(
              color: Colors.black,
            ),
            //ListView of Bluetooth Devices
            Consumer<SettingsScreenViewModel>(
              builder: (context, model, child) => Center(
                child: DeviceItems(devices: model.devices),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            //Click to delete
            IconButton(
              onPressed: () {
                settingsModel.clearData();
              },
              icon: Icon(Icons.delete),
            ),
            Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    TextIcon(
                        icon: Icons.check_circle,
                        title: "Synchronized Products.")
                  ],
                )),
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
