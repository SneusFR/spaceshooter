import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:spaceshooter/game_manager.dart';

class ShopShieldButton extends SpriteComponent with HasGameRef<GameManager>, Tappable {
  ShopShieldButton() : super(anchor: Anchor.center);

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    sprite = await Sprite.load('uzi.png');
    size = Vector2(215, 192);
    position = gameRef.size/2;
  }

  @override
  bool onTapUp(TapUpInfo event) {
    gameRef.changeScreen(); // Appeler la méthode pour changer d'écran
    return false;
  }
}

