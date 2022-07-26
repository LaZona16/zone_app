class DeviceEntity {
  final String name;
  final int strength;
  final String id;
  DeviceEntity({
    required this.id,
    required this.strength,
    required this.name,
  });

  factory DeviceEntity.empty() {
    return DeviceEntity(id: '', strength: 0, name: '');
  }
}
