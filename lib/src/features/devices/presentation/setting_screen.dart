import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zone_app/src/core/injection_container.dart';
import 'package:zone_app/src/features/devices/presentation/bloc/device_list_cubit.dart';
import 'package:zone_app/src/features/devices/presentation/bloc/device_list_state.dart';
import 'package:zone_app/src/features/devices/presentation/bloc/device_selected_cubit.dart';
import 'package:zone_app/src/features/devices/presentation/bloc/device_state.dart';
import 'package:zone_app/src/features/devices/presentation/bloc/read_values_cubit.dart';
import 'package:zone_app/src/features/devices/presentation/bloc/read_values_state.dart';
import 'package:zone_app/src/features/devices/presentation/bloc/write_value_cubit.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _writeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              sl<DeviceListCubit>().startSearching();
            },
            child: const Text(
              'Search',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              sl<ReadValuesCubit>().readValues('Wall');
            },
            child: const Text(
              'Listen',
            ),
          ),
          BlocBuilder<DeviceListCubit, DeviceListState>(
            bloc: sl<DeviceListCubit>(),
            builder: (context, state) {
              switch (state.status) {
                case DeviceListStatus.initial:
                  return const Text('Press to init search');
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
                              title: Text(item.name),
                              subtitle: Text(item.id),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: () {
                                      sl<DeviceSelectedCubit>().connect(item);
                                    },
                                    icon: Icon(Icons.add),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      sl<DeviceSelectedCubit>()
                                          .disconnect(item);
                                    },
                                    icon: Icon(Icons.remove),
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
                  return Text('Please add Zone Devices');
                case DeviceStatus.done:
                  return Text('You have ${state.quantity} devices connected');
                case DeviceStatus.error:
                  return Text(state.message.toString());
              }
            },
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: AlertDialog(
                  title: const Text("Write"),
                  content: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _writeController,
                        ),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        // sl<WriteValueCubit>().writeValue(
                        //     sl<DeviceSelectedCubit>().state.device.id,
                        //     'Wall',
                        //     _writeController.value.text);
                        _writeController.clear();
                      },
                      child: const Text('Send'),
                    )
                  ],
                ),
              ),
              BlocBuilder<ReadValuesCubit, ReadValuesState>(
                bloc: sl<ReadValuesCubit>(),
                builder: (context, state) {
                  switch (state.status) {
                    case ReadValuesStatus.initial:
                      return const Text('Press to listen changes');
                    case ReadValuesStatus.listening:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case ReadValuesStatus.done:
                      // Listview
                      final hit = state.hit;
                      return Expanded(
                        child: hit.wasShooted
                            ? Text(
                                'position: ${hit.position.name}, force: ${hit.force} ${hit.deviceId}')
                            : const Text('Please start play'),
                      );
                    case ReadValuesStatus.error:
                      return Text(state.message ?? '',
                          style: const TextStyle(color: Colors.red));
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
