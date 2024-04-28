import 'dart:math';
import 'dart:ui';

import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
import 'package:spaceshooter/common/enemy.dart';
import 'package:spaceshooter/game/bullet.dart';
import 'package:spaceshooter/game/player.dart';
import 'package:spaceshooter/game_manager.dart';

class Protected extends SpriteComponent with HasGameRef<GameManager>, HasHitboxes, Collidable {
  final double _speed = 250;
  var hitboxRectangle = HitboxRectangle();
  final Function(Vector2) onTouch;
  final Player player;

  Protected(this.onTouch, this.player);


  @override
  Future<void>? onLoad() async {
    var spriteSheet = SpriteSheet(
        image: await Images().load('protected.png'), srcSize: Vector2(470.0, 470.0));
    sprite = spriteSheet.getSprite(0, 0);  // Supposons que vous voulez le premier sprite de la feuille
    var size = 140.0;
    width = size;
    height = size;
    anchor = Anchor.center;
    addHitbox(hitboxRectangle);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (other is Enemy) {
      onTouch.call(other.position);

    }
  }

  void move(Vector2 delta) {
    position.add(delta);
  }

  @override
  void update (double dt) {
    super.update(dt);
    position = player.position.clone(); // Assurez-vous que le champ de protection suit la position du joueur

  }
}
