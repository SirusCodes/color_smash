import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Ball extends CircleComponent {
  Ball({
    required Vector2 position,
    required this.color,
  }) : super(
          position: position,
          anchor: Anchor.center,
          radius: 20,
          paint: Paint()
            ..color = color
            ..style = PaintingStyle.fill
            ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 10),
        );

  final Color color;

  @override
  Future<void> onLoad() {
    add(CircleHitbox());
    return super.onLoad();
  }
}
