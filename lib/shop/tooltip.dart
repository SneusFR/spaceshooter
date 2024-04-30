import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

import '../game_manager.dart';

class TooltipComponent extends PositionComponent with HasGameRef<GameManager> {
  late final TextComponent nameText;
  late final TextComponent priceText;
  late final TextComponent descriptionText;

  TooltipComponent(String nom, int prix, String description, Vector2 position) {
    this.position = Vector2(250,400); // Position du tooltip (à ajuster selon le besoin)
    size = Vector2(300, 150); // Taille du tooltip
    anchor = Anchor.center;

    // Création des composants de texte
    nameText = TextComponent(text: nom, position: Vector2(10, 10));
    priceText = TextComponent(text: '\$${prix}', position: Vector2(10, 40));
    descriptionText = TextComponent(text: description, position: Vector2(10, 70), );

    // Ajout des composants de texte comme enfants
    add(nameText);
    add(priceText);
    add(descriptionText);
  }

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    // Vous pouvez ajouter un fond ici si nécessaire
    add(RectangleComponent(size: size, paint: Paint()..color = const Color(0xAA333333)));
  }
}
