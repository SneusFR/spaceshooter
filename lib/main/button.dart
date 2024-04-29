import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:spaceshooter/game_manager.dart';

class ButtonComponent extends SpriteComponent with HasGameRef<GameManager>, Tappable {
  ButtonComponent() : super(anchor: Anchor.center);

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    sprite = await Sprite.load('shop.png');
    size = Vector2(40.0, 40.0);
    position = Vector2(100, 100);
  }

  @override
  bool onTapUp(TapUpInfo event) {
    gameRef.changeScreen(); // Appeler la méthode pour changer d'écran
    return false;
  }
}

