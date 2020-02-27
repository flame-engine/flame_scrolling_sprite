import 'package:flame/sprite.dart';
import 'package:meta/meta.dart';
import 'dart:ui';

class ScrollingSprite {
  Sprite _sprite;
  double _width;
  double _height;
  double _spriteWidth;
  double _spriteHeight;
  final double verticalSpeed;
  final double horizontalSpeed;
  final bool clipToDimensions;

  List<Rect> _chunks = [];

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
