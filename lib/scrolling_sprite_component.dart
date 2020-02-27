import 'package:flame/components/component.dart';
import 'package:meta/meta.dart';
import 'dart:ui';

import './scrolling_sprite.dart';

class ScrollingSpriteComponent extends Component {
  ScrollingSprite _sprite;
  double x;
  double y;

  ScrollingSpriteComponent({
    @required String spritePath,
    this.x,
    this.y,
    double spriteX = 0.0,
    double spriteY = 0.0,
    double spriteWidth,
    double spriteHeight,
    double spriteDestWidth,
    double spriteDestHeight,
    double width,
    double height,
    double verticalSpeed = 0.0,
    double horizontalSpeed = 0.0,
    bool clipToDimensions = true,
  }) {
    _sprite = ScrollingSprite(
        spritePath: spritePath,
        spriteX: spriteX,
        spriteY: spriteY,
        spriteWidth: spriteWidth,
        spriteHeight: spriteHeight,
        spriteDestWidth: spriteDestWidth,
        spriteDestHeight: spriteDestHeight,
        width: width,
        height: height,
        verticalSpeed: verticalSpeed,
        horizontalSpeed: horizontalSpeed,
        clipToDimensions: clipToDimensions,
    );
  }

  @override
  void update(double dt) {
    _sprite.update(dt);
  }

  @override
  void render(Canvas canvas) {
    if (_sprite.loaded()) {
      _sprite.renderAt(x, y, canvas);
    }
  }
}
