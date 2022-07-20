class HitEntity {
  final bool wasShooted;
  final int force;
  final Position position;

  HitEntity({
    required this.force,
    required this.position,
    required this.wasShooted,
  });

  factory HitEntity.empty() {
    return HitEntity(force: 0, position: Position.center, wasShooted: false);
  }
}

enum Position { left, center, right }
