import 'package:flutter/material.dart';
import 'package:zone_app/business_logic/models/bluetooth_device.dart';

class DeviceItems extends StatelessWidget {
  final List<BluetoothDevice> devices;

  const DeviceItems({
    Key? key,
    required this.devices,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 35.0,
        maxHeight: 160.0,
      ),
      child: ListView.builder(
          itemBuilder: (context, index) {
            return Text(devices[index].name);
          },
          itemCount: devices.length),
    );
  }
}
