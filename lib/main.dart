import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'src/game.dart';

void main() {
  runApp(SafeArea(child: GameWidget(game: ColorSmash())));
}
