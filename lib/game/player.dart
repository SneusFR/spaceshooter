import 'dart:math';
import 'dart:ui';

import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:spaceshooter/game_manager.dart';
import 'package:spaceshooter/common/enemy.dart';

class Player extends SpriteAnimationComponent with HasGameRef<GameManager>, HasHitboxes, Collidable, Draggable {
  final VoidCallback onTouch;

  Player(this.onTouch);

  @override
  Future<void>? onLoad() async {
    var spriteSheet = SpriteSheet(
        image: await Images().load('player.png'), srcSize: Vector2(32.0, 48.0));
    animation = spriteSheet.createAnimation(row: 0, stepTime: 0.2);

    position = gameRef.size / 2;
    width = 80;
    height = 120;
    anchor = Anchor.center;

    addHitbox(HitboxRectangle());
  }


  @override
  bool onDragUpdate(int pointerId, DragUpdateInfo info) {

    position.add(info.delta.game);
    return true;
  }


  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (other is Enemy) {
      onTouch.call();
    }
  }
}