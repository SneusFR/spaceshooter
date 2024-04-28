import 'dart:math';
import 'dart:ui';

import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
import 'package:spaceshooter/game/bullet.dart';
import 'package:spaceshooter/game/player.dart';
import 'package:spaceshooter/game_manager.dart';

class Shield extends SpriteComponent with HasGameRef<GameManager>, HasHitboxes, Collidable {
  final double _speed = 250;
  var hitboxRectangle = HitboxRectangle();
  final Function(Vector2) onTouch;
  Shield(this.onTouch);


  @override
  Future<void>? onLoad() async {
    var spriteSheet = SpriteSheet(
        image: await Images().load('shield.png'), srcSize: Vector2(471.0, 471.0));
    sprite = spriteSheet.getSprite(0, 0);  // Supposons que vous voulez le premier sprite de la feuille
    var size = 40.0;
    width = size;
    height = size;
    anchor = Anchor.center;
    addHitbox(hitboxRectangle);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      removeFromParent();
      removeHitbox(hitboxRectangle);
      onTouch.call(other.position);

    }
  }

  void move(Vector2 delta) {
    position.add(delta);
  }

  @override
  void update (double dt) {
    super.update(dt);
    position += Vector2(0,1) * _speed * dt;
    if (position.y > gameRef.size.y) {
      removeFromParent();
      removeHitbox(hitboxRectangle);
    }
  }
}
