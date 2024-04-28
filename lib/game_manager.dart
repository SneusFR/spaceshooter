import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import 'game/game_screen.dart';
import 'main/main_screen.dart';

class GameManager extends FlameGame with HasCollidables, PanDetector {
  late GameScreen _gameScreen;
  late MainScreen _mainScreen;
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

  // redirige l'événement de pan directement à MainScreen, permettant à ce dernier de gérer l'événement.  @override
  void onPanStart(DragStartInfo info) {
  _mainScreen.onPanStart(info);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    _gameScreen.onPanUpdate(info);
  }

  void endGame(int score) {
    remove(_gameScreen);
    _mainScreen.setScore(score);
    FlameAudio.bgm.stop();

    add(_mainScreen);

  }
}
