import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:spaceshooter/game_manager.dart';
import 'package:spaceshooter/shop/tooltip.dart';

class ShopShieldButton2 extends SpriteComponent with HasGameRef<GameManager>, Tappable {
  ShopShieldButton2() : super(anchor: Anchor.center);

  TooltipComponent? currentTooltip;

  var prix = 500;
  var nom = "Marteau de sang";
  var description = "Son nom parle pour lui";

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    sprite = await Sprite.load('marteau.png');
    size = Vector2(115, 92);
    position = Vector2(245, 100);
  }

  @override
  bool onTapUp(TapUpInfo event) {
    if (currentTooltip != null) {
      // Retire le tooltip si déjà affiché
      gameRef.remove(currentTooltip!);
      currentTooltip = null;
      return true;
    } else {
      // Crée et affiche un nouveau tooltip
      var tooltip = TooltipComponent(nom, prix, description, event.eventPosition.game);
      gameRef.add(tooltip);
      currentTooltip = tooltip;
      return true;
    }
  }

  @override
  bool onTapDown(TapDownInfo event) {
    // Supprime tous les tooltips existants
    gameRef.children.whereType<TooltipComponent>().forEach(gameRef.remove);
    return true;
  }
}

