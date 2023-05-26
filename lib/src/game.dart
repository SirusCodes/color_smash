import 'dart:async';
import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'components/ball.dart';
import 'components/wall.dart';

class ColorSmash extends FlameGame with HasCollisionDetection {
  static const double wallThickness = 20;
  static const List<Color> colors = [
    Color(0xFF00FF00),
    Color(0xFF0000FF),
    Color(0xFFFF0000),
    Color(0xFFFFFF00),
  ];

  @override
  FutureOr<void> onLoad() {
    final walls = [
      // right wall
      Wall(
        position: Vector2(size.x - wallThickness, size.y / 2),
        size: Vector2(wallThickness, size.y),
        color: colors[0],
      ),
      // left wall
      Wall(
        position: Vector2(wallThickness, size.y / 2),
        size: Vector2(wallThickness, size.y),
        color: colors[1],
      ),
      // top wall
      Wall(
        position: Vector2(size.x / 2, wallThickness),
        size: Vector2(size.x, wallThickness),
        color: colors[2],
      ),
      // bottom wall
      Wall(
        position: Vector2(size.x / 2, size.y - wallThickness),
        size: Vector2(size.x, wallThickness),
        color: colors[3],
      ),
    ];

    addAll(walls);
    addBallToGame();
  }

  void addBallToGame() {
    final color = colors[Random().nextInt(colors.length)];
    add(Ball(position: Vector2(size.x / 2, size.y / 2), color: color));
  }

  void gameOver() {}
}
