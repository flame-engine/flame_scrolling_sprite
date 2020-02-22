import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame_scrolling_sprite/flame_scrolling_sprite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.util.fullScreen();
  final size = await Flame.util.initialDimensions();
  runApp(MyGame(size).widget);
}

class MyGame extends Game {

  ScrollingSprite sprite;
  final Size size;

  MyGame(this.size) {
    sprite = ScrollingSprite(
        spritePath: 'city.png',
        width: size.width,
        horizontalSpeed: -100,

        spriteDestWidth: 300,
        spriteDestHeight: 150,
    );
  }

  @override
  void update(double dt) {
    sprite.update(dt);
  }

  @override
  void render(Canvas canvas) {
    if (sprite.loaded()) {
      sprite.renderAt(0, size.height - 150, canvas);
    }
  }

  @override
  Color backgroundColor() => const Color(0xFF3f3f74);

}

