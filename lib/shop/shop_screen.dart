import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/src/gestures/events.dart';
import 'package:spaceshooter/common/background.dart';
import 'package:spaceshooter/game_manager.dart';
import 'package:flutter/material.dart' show TextStyle, Colors;
import 'package:spaceshooter/shop/shopShieldButton.dart';
import '../main/button.dart';
import '../main/text.dart';

class ShopScreen extends Component with HasGameRef<GameManager> {
  late TextComponent _playerScore;
  late final ButtonComponent shopButton;

  @override
  Future<void>? onLoad() async {
    add(Background(40));
    add(ShopShieldButton());
  }
}