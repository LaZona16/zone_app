import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zone_app/src/core/injection_container.dart';
import 'package:zone_app/src/features/devices/presentation/bloc/device_list_cubit.dart';
import 'package:zone_app/src/features/devices/presentation/bloc/device_list_state.dart';
import 'package:zone_app/src/features/devices/presentation/bloc/device_selected_cubit.dart';
import 'package:zone_app/src/features/devices/presentation/bloc/device_state.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            const Icon(
              Icons.settings,
              color: Color.fromRGBO(0, 181, 0, 1),
              size: 40,
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          // ElevatedButton(
          //   onPressed: () {
          //     sl<DeviceListCubit>().startSearching();
          //   },
          //   child: const Text(
          //     'Search',
          //     style: TextStyle(),
          //   ),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     sl<ReadValuesCubit>().readValues(
          //       sl<DeviceSelectedCubit>().connectedDevices,
          //       'Wall',
          //     );
          //   },
          //   child: const Text(
          //     'Listen',
          //   ),
          // ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "*Turn On your Smart Phone Bluetooth to sync La Zona Products",
            style: TextStyle(
              color: Color.fromRGBO(78, 78, 78, 1),
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              RawMaterialButton(
                fillColor: const Color.fromRGBO(0, 181, 0, 1),
                onPressed: () {
                  sl<DeviceListCubit>().startSearching();
                },
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.bluetooth,
                  color: Color.fromRGBO(24, 24, 24, 1),
                  size: 30,
                ),
              ),
              const Text(
                "Search for Products.",
                style: TextStyle(
                    color: Color.fromRGBO(0, 181, 0, 1),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Divider(
            color: Color.fromRGBO(78, 78, 78, 1),
            thickness: 5,
          ),
          BlocBuilder<DeviceListCubit, DeviceListState>(
            bloc: sl<DeviceListCubit>(),
            builder: (context, state) {
              switch (state.status) {
                case DeviceListStatus.initial:
                  return const Text(
                    'Press to init search',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  );
                case DeviceListStatus.searching:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case DeviceListStatus.done:
                  final items = state.devices;
                  return Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return ListTile(
                              leading: const Icon(
                                Icons.bluetooth,
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),
                              title: Text(
                                item.name,
                                style: const TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                              subtitle: Text(
                                item.id,
                                style: const TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: () {
                                      sl<DeviceSelectedCubit>().connect(item);
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      sl<DeviceSelectedCubit>()
                                          .disconnect(item);
                                    },
                                    icon: const Icon(
                                      Icons.remove,
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                    ),
                                  )
                                ],
                              ));
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: items.length),
                  );
                case DeviceListStatus.error:
                  return Text(state.message ?? '',
                      style: const TextStyle(color: Colors.red));
              }
            },
          ),
          BlocBuilder<DeviceSelectedCubit, DeviceState>(
            bloc: sl<DeviceSelectedCubit>(),
            builder: (context, state) {
              switch (state.status) {
                case DeviceStatus.initial:
                  return const Text(
                    'Please add Zone Devices',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  );
                case DeviceStatus.done:
                  return Text(
                    'You have ${state.quantity} devices connected',
                    style: const TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  );
                case DeviceStatus.error:
                  return Text(state.message.toString());
              }
            },
          ),
          const Divider(
            color: Color.fromRGBO(78, 78, 78, 1),
            thickness: 5,
          ),
          Container(
            margin: const EdgeInsets.only(left: 25, top: 10),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    right: 25,
                  ),
                  child: const Icon(
                    Icons.check_circle_outline_sharp,
                    color: Color.fromRGBO(0, 181, 0, 1),
                    size: 40,
                  ),
                ),
                const Text(
                  "Synchronized Products.",
                  style: TextStyle(
                      color: Color.fromRGBO(0, 181, 0, 1),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
