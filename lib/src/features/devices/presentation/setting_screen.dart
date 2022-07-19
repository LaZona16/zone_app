import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zone_app/src/core/injection_container.dart';
import 'package:zone_app/src/features/devices/presentation/bloc/device_list_cubit.dart';
import 'package:zone_app/src/features/devices/presentation/bloc/device_list_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
                  return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return ListTile(
                          title: Text(item.name),
                          subtitle: Text(item.id),
                          trailing: Text(
                            item.strength.toString(),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: items.length);
                case DeviceListStatus.error:
                  return Text(state.message ?? '',
                      style: const TextStyle(color: Colors.red));
              }
            },
          )
        ],
      ),
    );
  }
}
