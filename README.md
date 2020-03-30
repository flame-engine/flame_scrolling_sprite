[![Pub](https://img.shields.io/pub/v/flame_scrolling_sprite.svg?style=popout)](https://pub.dartlang.org/packages/flame_scrolling_sprite)
![Build Status](https://img.shields.io/github/workflow/status/flame-engine/flame_scrolling_sprite/Test/master?label=tests)

# Flame Scrolling Sprite

Flame Scrolling Sprite is a [Flame](https://github.com/flame-engine/flame) package to make it easy to render sprites that scrolls and repeat itself forever given a velocity.

This can be used to create things like an scrolling background, or even create scenes, bellow you can see one example of this:

![train](https://user-images.githubusercontent.com/835641/75399796-fdf51180-58db-11ea-92ef-f7cee92c99ef.gif)

This package can be used by using the plain class `ScrollingSprite` or the `ScrollingSpriteComponent`, they do example the same thing, but the later can be used together with Flame component system.

Bellow you can find all the parameters that the classes receives

```dart
    //// Resource path of the sprite
    @required String spritePath,

    //// X and Y coordinate do be used to map the sprite
    double spriteX = 0.0,
    double spriteY = 0.0,

    //// Width and height of the mapped sprite
    double spriteWidth,
    double spriteHeight,

    //// Destination width and height of the sprite, in case you want to scale its original size
    double spriteDestWidth,
    double spriteDestHeight,

    //// Width and height of the total area where the sprites will scroll
    double width,
    double height,

    //// Vertical and horizontal speed of the scrolling speed in pixels per second
    this.verticalSpeed = 0.0,
    this.horizontalSpeed = 0.0,

    //// Since the sprites are scrolling on an endless manner, the sprite can be draw outside of its
    //// area, by default, the package already clips the area to prevent it from showing, use this flag to change
    //// this behaviour
    this.clipToDimensions = true,
```

When using the `ScrollingSpriteComponent` the same paramenters above apply to it, and additionally, you can inform the `x` and `y` where the area will place placed.

For a live example of this running, please refer to the [example](/example) folder.
