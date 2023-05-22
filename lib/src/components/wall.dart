import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Wall extends RectangleComponent {
  Wall({
    required Vector2 position,
    required Vector2 size,
    required this.color,
  }) : super(
          position: position,
          anchor: Anchor.center,
          size: size,
          paint: Paint()
            ..color = color
            ..style = PaintingStyle.fill
            ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 10),
        );

  final Color color;

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox());
  }
}
