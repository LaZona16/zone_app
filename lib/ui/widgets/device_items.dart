import 'package:flutter/material.dart';
import 'package:zone_app/business_logic/models/bluetooth_device.dart';
import 'package:zone_app/ui/widgets/text_icon.dart';

class DeviceItems extends StatelessWidget {
  final List<BluetoothDeviceData> devices;

  const DeviceItems({
    Key? key,
    required this.devices,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 35.0,
        maxHeight: 120.0,
      ),
      child: Center(
        child: ListView.builder(
            itemBuilder: (context, index) {
              return TextIcon(
                title: devices[index].name,
                icon: Icons.bluetooth,
              );
            },
            itemCount: devices.length),
      ),
    );
  }
}
