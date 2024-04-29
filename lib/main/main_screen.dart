import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/src/gestures/events.dart';
import 'package:spaceshooter/common/background.dart';
import 'package:spaceshooter/game_manager.dart';
import 'package:flutter/material.dart' show TextStyle, Colors;
import 'button.dart';
import 'text.dart';

class MainScreen extends Component with HasGameRef<GameManager> {
  final Function _onStartClicked;
  late TextComponent _playerScore;
  late final ButtonComponent shopButton;



  MainScreen(this._onStartClicked);

  @override
  Future<void>? onLoad() async {
    add(Background(40));
    add(TitleGame());
    add(ButtonComponent()..position = Vector2(100,100));

    _playerScore = TextComponent(
      text: "Score : 0",
      position: Vector2(gameRef.size.toRect().width / 2, 10),
      anchor: Anchor.topCenter,
      textRenderer: TextPaint(
      style: const TextStyle(
      fontSize: 48.0,
      color: Colors.white,
    ),
    ),
    );
    add(_playerScore);
  }

  void onPanStart(DragStartInfo info) {
    if (isMounted) _onStartClicked();
  }

  void setScore(int score) {
    _playerScore.text = "Score : $score";
  }
}