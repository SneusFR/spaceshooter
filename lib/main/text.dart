import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:spaceshooter/game_manager.dart';

class TitleGame extends SpriteComponent with HasGameRef<GameManager>, Tappable {

  @override
  Future<void>? onLoad() async {

    sprite = await Sprite.load("start.png");
    anchor = Anchor.center;
    position = gameRef.size/2;

    var originalSize = sprite?.originalSize;
    if (originalSize == null) return;
    var width = gameRef.size.toSize().width / 2;
    var height = originalSize.toSize().height * (width / originalSize.toSize().width);
    size = Vector2(width, height);
  }

  @override
  bool onTapUp(TapUpInfo event) {
    gameRef.startGame(); // Appeler la méthode pour changer d'écran
    return false;
  }
}