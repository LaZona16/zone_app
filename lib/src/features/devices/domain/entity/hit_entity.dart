class HitEntity {
  final String deviceId;
  final bool wasShooted;
  final int force;
  final Position position;

  HitEntity({
    required this.deviceId,
    required this.force,
    required this.position,
    required this.wasShooted,
  });

  factory HitEntity.empty() {
    return HitEntity(
      force: 0,
      position: Position.center,
      wasShooted: false,
      deviceId: '-1',
    );
  }
}

enum Position { left, center, right }
