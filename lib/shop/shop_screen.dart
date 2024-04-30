import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/src/gestures/events.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:spaceshooter/common/background.dart';
import 'package:spaceshooter/game_manager.dart';
import 'package:flutter/material.dart' show TextStyle, Colors;
import 'package:spaceshooter/shop/shopShieldButton.dart';
import 'package:spaceshooter/shop/shopShieldButton2.dart';
import 'package:spaceshooter/shop/shopShieldButton3.dart';

import '../main/button.dart';
import '../main/text.dart';

class ShopScreen extends Component with HasGameRef<GameManager> {
  late final ButtonComponent shopButton;

  @override
  Future<void>? onLoad() async {
    add(Background(40));
    startBgmMusic();
    add(ShopShieldButton());
    add(ShopShieldButton2());
    add(ShopShieldButton3());

  }

  void startBgmMusic() {
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('shop.mp3');
  }
}