import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:spaceshooter/shop/shop_screen.dart';

import 'game/game_screen.dart';
import 'main/main_screen.dart';

class GameManager extends FlameGame with HasCollidables, HasTappables, HasDraggables {
  late GameScreen _gameScreen;
  late MainScreen _mainScreen;
  late ShopScreen _shopScreen;
  bool isProtected = false; // Initialement, le joueur n'est pas protégé.


  GameManager() {
    _mainScreen = MainScreen(() {
      remove(_mainScreen);
      _gameScreen = GameScreen();
      add (_gameScreen);

    });
  }

  @override
  Future<void>? onLoad() {
    add(_mainScreen);
  }

  void endGame(int score) {
    remove(_gameScreen);
    _mainScreen.setScore(score);
    FlameAudio.bgm.stop();

    add(_mainScreen);

  }

  void changeScreen() {
    remove(_mainScreen);
    _shopScreen = ShopScreen();
    add (_shopScreen);
  }

  void startGame() {
    remove(_mainScreen);
    _gameScreen = GameScreen();
    add (_gameScreen);
  }
}
