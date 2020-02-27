import 'package:flame/sprite.dart';
import 'package:meta/meta.dart';
import 'dart:ui';

/// Describes a Sprite image that will animate on a axis resembling scroll moviment
class ScrollingSprite {
  Sprite _sprite;
  double _width;
  double _height;
  double _spriteWidth;
  double _spriteHeight;
  final double verticalSpeed;
  final double horizontalSpeed;

  ///
  final bool clipToDimensions;

  List<Rect> _chunks = [];

  /// Constructs a [ScrollingSprite] with the following params:
  ///
  /// [spritePath] - Resource path of the sprite
  /// [spriteX] and [spriteY] - X and Y coordinate do be used to map the sprite
  /// [spriteWidth] and [spriteHeight] - Width and height of the mapped sprite
  /// [spriteDestWidth] and [spriteDestHeight] - Destination width and height of the sprite, in case you want to scale its original size
  /// [width] and [height] - Width and height of the total area where the sprites will scroll
  /// [verticalSpeed] and [horizontalSpeed] - Vertical and horizontal speed of the scrolling speed in pixels per second
  /// [clipToDimensions] - Since the sprites are scrolling on an endless manner, the sprite can be draw outside of its
  /// area, by default, the package already clips the area to prevent it from showing, use this flag to change
  /// this behaviour
  ScrollingSprite({
    @required String spritePath,
    double spriteX = 0.0,
    double spriteY = 0.0,
    double spriteWidth,
    double spriteHeight,
    double spriteDestWidth,
    double spriteDestHeight,
    double width,
    double height,
    this.verticalSpeed = 0.0,
    this.horizontalSpeed = 0.0,
    this.clipToDimensions = true,
  }) {
    Sprite.loadSprite(spritePath,
      x: spriteX,
      y: spriteY,
      width: spriteWidth,
      height: spriteHeight,
    ).then((loadedSprite) {
      _sprite = loadedSprite;

      _spriteWidth = spriteDestWidth ?? _sprite.size.x;
      _spriteHeight = spriteDestHeight ?? _sprite.size.y;

      _width = width ?? _spriteWidth;
      _height = height ?? _spriteHeight;

      _calculate();
    });
  }

  set width(double w) {
    _width = w;
    _calculate();
  }
  get width => _width;

  set height(double h) {
    _height = h;
    _calculate();
  }
  get height => _height;

  void _calculate() {
    _chunks = [];
    final columns = (_width / _spriteWidth).ceil() + 1;
    final rows = (_height / _spriteHeight).ceil() + 1;

    for (var y = 0; y < rows; y++) {
      for (var x = 0; x < columns; x++) {
        _chunks.add(
            Rect.fromLTWH(
                (x * _spriteWidth),
                (y * _spriteHeight),
                _spriteWidth,
                _spriteHeight
            )
        );
      }
    }
  }

  void update(double dt) {
    for (var i = 0; i < _chunks.length; i++) {
      Rect _c = _chunks[i];

      if (_c.top > _height && verticalSpeed > 0) {
        _c = _chunks[i] = _c.translate(0, -(height + _spriteHeight));
      } else if (_c.bottom < 0 && verticalSpeed < 0) {
        _c = _chunks[i] = _c.translate(0, height + _spriteHeight);
      }

      if (_c.left > _width && horizontalSpeed > 0) {
        _c = _chunks[i] = _c.translate(-(_width + _spriteWidth), 0);
      } else if (_c.right < 0 && horizontalSpeed < 0) {
        _c = _chunks[i] = _c.translate(_width + _spriteWidth, 0);
      }

      _c = _chunks[i] = _c.translate(horizontalSpeed * dt, verticalSpeed * dt);
    }
  }

  void renderAt(double x, double y, Canvas canvas) {
    if (!loaded()) {
      return;
    }

    if (clipToDimensions) {
      canvas.save();
      canvas.translate(x, y);
      canvas.clipRect(Rect.fromLTWH(0, 0, _width, _height));
    }
    _chunks.forEach((rect) {
      _sprite.renderRect(canvas, rect);
    });
    if (clipToDimensions) {
      canvas.restore();
    }
  }

  bool loaded() => _sprite != null && _sprite.loaded();
}
