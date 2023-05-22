import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';

import '../game.dart';

class Ball extends CircleComponent with DragCallbacks, HasGameRef<ColorSmash> {
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
  Vector2? initalPosition;

  @override
  Future<void> onLoad() {
    add(CircleHitbox());
    return super.onLoad();
  }

  @override
  void onDragStart(DragStartEvent event) {
    initalPosition = position.clone();
    super.onDragStart(event);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position.add(event.delta);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    _launchBall();
    super.onDragEnd(event);
  }

  void _launchBall() {
    final velocity = (initalPosition! - position) * 5;
    add(
      MoveEffect.by(
        velocity,
        SpeedEffectController(
          LinearEffectController(1),
          speed: velocity.length,
        ),
      ),
    );
  }
}
