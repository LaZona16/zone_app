import 'package:flutter/material.dart';
import 'package:zone_app/business_logic/models/bluetooth_device.dart';
import 'package:zone_app/ui/widgets/text_icon.dart';

class DeviceItems extends StatelessWidget {
  final Stream<List<DeviceModel>> devices;

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
        child: StreamBuilder<List<DeviceModel>>(
          stream: devices,
          initialData: const [],
          builder: (context, snapshot) {
            print(snapshot);
            if (snapshot.hasData) {
              return ListView.builder(
                  itemBuilder: (context, index) {
                    return TextIcon(
                      title: snapshot.data![index].name,
                      icon: Icons.bluetooth,
                    );
                  },
                  itemCount: snapshot.data!.length);
            }

            return Text('N');
          },
        ),
      ),
    );
  }
}
