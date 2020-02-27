import 'package:flame/components/component.dart';
import 'package:meta/meta.dart';
import 'dart:ui';

import './scrolling_sprite.dart';

class ScrollingSpriteComponent extends Component {
  ScrollingSprite scrollingSprite;
  double x;
  double y;

  ScrollingSpriteComponent({
    this.x,
    this.y,
    this.scrollingSprite
  });

  @override
  void update(double dt) {
    scrollingSprite.update(dt);
  }

  @override
  void render(Canvas canvas) {
    if (scrollingSprite.loaded()) {
      scrollingSprite.renderAt(x, y, canvas);
    }
  }
}
