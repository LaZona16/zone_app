import 'package:zone_app/src/features/devices/domain/entity/hit_entity.dart';

class HitModel extends HitEntity {
  HitModel(
      {required int force, required bool shooted, required Position position})
      : super(
          force: force,
          position: position,
          wasShooted: shooted,
        );
}
