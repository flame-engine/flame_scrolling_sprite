import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame_scrolling_sprite/flame_scrolling_sprite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.util.fullScreen();
  final size = await Flame.util.initialDimensions();
  runApp(MyGame(size).widget);
}

class MyGame extends BaseGame {
  final Size size;

  MyGame(this.size) {

    add(ScrollingSpriteComponent(
        spritePath: 'desert/clouds.png',
        width: size.width,
        spriteDestWidth: 640,
        spriteDestHeight: 160,
        y: 40,
        horizontalSpeed: -50,
    ));

    add(ScrollingSpriteComponent(
        spritePath: 'desert/mountains.png',
        width: size.width,
        spriteDestWidth: 640,
        spriteDestHeight: 160,
        y: size.height - 180,
        height: size.height,
        horizontalSpeed: -100,
    ));

    add(ScrollingSpriteComponent(
        spritePath: 'desert/ground.png',
        width: size.width,
        spriteDestWidth: 320,
        spriteDestHeight: 160,
        y: size.height - 160,
        horizontalSpeed: -300,
    ));

    add(AnimationComponent.sequenced(
            192.0,
            64.0,
            'desert/train.png',
            8,
            textureWidth: 96.0,
            textureHeight: 32.0,
    )
        ..y = size.height - 65
        ..x = size.width / 2 - 96
    );

    add(ScrollingSpriteComponent(
        spritePath: 'desert/foreground.png',
        width: size.width,
        spriteDestWidth: 1280,
        spriteDestHeight: 160,
        height: size.height,
        y: size.height - 160,
        horizontalSpeed: -1500,
    ));
  }


  @override
  Color backgroundColor() => const Color(0xFF73acb6);
}

