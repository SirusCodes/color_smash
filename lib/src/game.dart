import 'dart:async';

import 'package:color_smash/src/components/wall.dart';
import 'package:flame/game.dart';

import 'package:flutter/material.dart';

class ColorSmash extends FlameGame with HasCollisionDetection {
  static const double wallThickness = 10;

  @override
  FutureOr<void> onLoad() {
    final walls = [
      // right wall
      Wall(
        position: Vector2(size.x - 0, size.y / 2),
        size: Vector2(wallThickness, size.y),
        color: const Color(0xFF00FF00),
      ),
      // left wall
      Wall(
        position: Vector2(0, size.y / 2),
        size: Vector2(wallThickness, size.y),
        color: const Color(0xFF0000FF),
      ),
      // top wall
      Wall(
        position: Vector2(size.x / 2, 0),
        size: Vector2(size.x, wallThickness),
        color: const Color(0xFFFF0000),
      ),
      // bottom wall
      Wall(
        position: Vector2(size.x / 2, size.y - 0),
        size: Vector2(size.x, wallThickness),
        color: const Color(0xFFFFFF00),
      ),
    ];

    addAll(walls);
  }

  @override
  bool get debugMode => true;
}
