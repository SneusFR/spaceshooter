import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/src/gestures/events.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:spaceshooter/common/background.dart';
import 'package:spaceshooter/game/protected.dart';
import 'package:spaceshooter/game/shield.dart';
import 'package:spaceshooter/game_manager.dart';

import '../common/enemy.dart';
import 'bullet.dart';
import 'explosion.dart';
import 'medical.dart';
import 'player.dart';

class GameScreen extends Component with HasGameRef<GameManager> {
  static const int playerLevelByScore = 20;
  late Player _player;
  late TextComponent _playerScore;
  late Timer enemySpawner;
  late Timer bulletSpawner;
  int score = 0;
  double cpt = 0.9;

  @override
  Future<void>? onLoad() {
    enemySpawner = Timer(2, onTick: _spawnEnemy, repeat: true);
    bulletSpawner = Timer(1, onTick: _spawnBullet, repeat: true);

    startBgmMusic();
    add(Background(50));


    _playerScore = TextComponent(
        text: "Score : 0",
        position: Vector2(gameRef.size.toRect().width / 2, 10),
        anchor: Anchor.topCenter,
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 48.0,
            color: Colors.white,
          ),
        ));
    add(_playerScore);


    _player = Player(_onPlayerTouch);
    add(_player);
  }

  void _spawnBullet(){
    var bullet = Bullet();
    bullet.position = _player.position.clone();
    add(bullet);
    FlameAudio.play('laser.wav');

  }

  void _spawnEnemy() {
    for (int i = 0; i <= min(score ~/ playerLevelByScore, 2); i++) {
      add(Enemy(_onEnemyTouch));
    }
  }

  void _onPlayerTouch(){
    if (!gameRef.isProtected) {
      gameRef.endGame(score);
    }
    else {
    }
  }

  void _onMedicalTouch(Vector2 position){
    FlameAudio.play('powerUP.wav');

    bulletSpawner.stop();  // Arrête le timer actuel
    bulletSpawner = Timer(cpt, onTick: _spawnBullet, repeat: true);
    bulletSpawner.start();  // Redémarre le timer avec le nouvel intervalle
    cpt -=0.1;

  }

  void _onProtectedTouch(Vector2 position){

  }

  void startBgmMusic() {
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('8bit.mp3');
  }

  void _onShieldTouch(Vector2 position){
    FlameAudio.play('powerUP.wav');

    // Supposons que `isProtected` est la variable protégée
    gameRef.isProtected = true;  // Active le bouclier

    var protected = Protected(_onProtectedTouch, _player);
    protected.position = _player.position.clone();
    add(protected);

    Future.delayed(const Duration(seconds: 10), () {
      gameRef.isProtected = false;  // Désactive le bouclier après 10 secondes
      remove(protected);
    });
  }

  void _onEnemyTouch(Vector2 position){

    var rng = Random();

    int chance = rng.nextInt(5);

    var explosion = Explosion();
    explosion.position = position;
    add(explosion);
    FlameAudio.play('explosion.wav');


    if (chance == 0) {
      var medical = Medical((_onMedicalTouch));
      medical.position = position;
      add(medical);
    }

    if (chance == 1) {
      var shield = Shield((_onShieldTouch));
      shield.position = position;
      add(shield);
    }
    score++;
    _playerScore.text = "Score : $score";

    if (score % playerLevelByScore == 0) {
      bulletSpawner.stop();
      bulletSpawner = Timer(
          min(1 / (score ~/ playerLevelByScore), 1).toDouble(),
          onTick: _spawnBullet,
          repeat: true);
    }
  }

  @override
  void onMount() {
    super.onMount();
    enemySpawner.start();
    bulletSpawner.start();
  }

  @override
  void update(double dt) {
    super.update(dt);
    enemySpawner.update(dt);
    bulletSpawner.update(dt);
  }

  @override
  void onRemove() {
    super.onRemove();
    enemySpawner.stop();
    bulletSpawner.stop();
  }

}