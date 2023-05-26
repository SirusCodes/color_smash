import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/experimental.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

import '../game.dart';
import 'wall.dart';

class Ball extends CircleComponent
    with DragCallbacks, HasGameRef<ColorSmash>, CollisionCallbacks {
  static const ballRaduis = 20.0;

  Ball({
    required Vector2 position,
    required this.color,
  }) : super(
          position: position,
          anchor: Anchor.center,
          radius: ballRaduis,
          paint: Paint()
            ..color = color
            ..style = PaintingStyle.fill
            ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 10),
        );

  final Color color;

  late final double shootSpeed;

  late final Vector2 movementDirection;

  @override
  Future<void> onLoad() {
    add(CircleHitbox());
    return super.onLoad();
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    final center = gameRef.size / 2;

    final vecFromCenter = event.canvasPosition - center;

    if (vecFromCenter.length2 > 100 * 100) {
      return;
    }

    position = event.canvasPosition;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    _launchBall();
    super.onDragEnd(event);
  }

  void _launchBall() {
    final center = gameRef.size / 2;

    movementDirection = center - position;
    if (movementDirection.length2 < 100) return;
    shootSpeed = movementDirection.length * 10;
    add(
      MoveEffect.by(
        movementDirection * center.length,
        SpeedEffectController(
          LinearEffectController(1),
          speed: shootSpeed,
        ),
      ),
    );

    gameRef.addBallToGame();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Wall) {
      removeWhere((component) => component is MoveEffect);

      if (other.color == color) {
        _ballColide();
        return;
      }

      gameRef.gameOver();
    }
    super.onCollision(intersectionPoints, other);
  }

  void _ballColide() {
    add(SequenceEffect([
      OpacityEffect.to(0, EffectController(duration: .2)),
      RemoveEffect(),
    ]));

    gameRef.add(
      ParticleSystemComponent(
        particle: Particle.generate(
          count: 5,
          lifespan: 1,
          generator: (i) => AcceleratedParticle(
            position: position.clone() +
                Vector2(
                  ballRaduis * Random().nextDouble(),
                  ballRaduis * Random().nextDouble(),
                ),
            acceleration: -movementDirection,
            speed: (Vector2.random() - Vector2.random()) * shootSpeed / 3,
            child: CircleParticle(
              radius: Random().nextDouble() * 5,
              paint: Paint()
                ..color = color
                ..style = PaintingStyle.fill
                ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 1),
            ),
          ),
        ),
      ),
    );
  }
}
