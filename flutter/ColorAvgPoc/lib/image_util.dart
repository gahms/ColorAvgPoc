import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class ImageUtil {
  Future<Color> imageAverageColor(
      BuildContext context, ImageProvider imageProvider) async {
    final img = await getImage(context, imageProvider);
    return await colorAvg(img);
  }

  Future<Color> colorAvg(ui.Image image) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.rawRgba);

    int totalRed = 0;
    int totalGreen = 0;
    int totalBlue = 0;

    final elementSize = 4;
    final totalPixels = byteData.lengthInBytes / elementSize;
    for (int pixelOffset = 0; pixelOffset < totalPixels; pixelOffset++) {
      final pixelData = byteData.getUint32(elementSize * pixelOffset);
      final red = (pixelData >> 24) & 0xff;
      final green = (pixelData >> 16) & 0xff;
      final blue = (pixelData >> 8) & 0xff;

      totalRed += red;
      totalGreen += green;
      totalBlue += blue;
    }

    final totalPixelsd = totalPixels.toDouble();
    final avgRed = totalRed.toDouble() ~/ totalPixelsd;
    final avgGreen = totalGreen.toDouble() ~/ totalPixelsd;
    final avgBlue = totalBlue.toDouble() ~/ totalPixelsd;
    int alpha = 0xff;

    return Color((alpha << 24) | (avgRed << 16) | (avgGreen << 8) | avgBlue);
  }

  // Copied and adapted from: https://github.com/marcglasberg/image_pixels
  Future<ui.Image> getImage(
      BuildContext buildContext, ImageProvider imageProvider) async {
    ImageConfiguration imageConfiguration =
        createLocalImageConfiguration(buildContext);

    Object key = await imageProvider.obtainKey(imageConfiguration);

    final ImageStreamCompleter completer =
        PaintingBinding.instance.imageCache.putIfAbsent(
      key, // key
      // ignore: invalid_use_of_protected_member
      () => imageProvider.load(key, _decoder), // loader
      onError: null,
    );

    if (completer == null) {
      return null;
    }

    final Completer<ui.Image> myCompleter = Completer();

    _ListenerManager listenerManager =
        _ListenerManager((img) => myCompleter.complete(img));

    ImageListener onImage = listenerManager.onImage;
    ImageErrorListener onError = listenerManager.onError;

    ImageStreamListener listener = ImageStreamListener(
      onImage,
      onError: onError,
      onChunk: null,
    );

    listenerManager.removeListener = () {
      completer.removeListener(listener);
    };

    completer.addListener(listener);

    return myCompleter.future;
  }

  Future<ui.Codec> _decoder(
    Uint8List bytes, {
    bool allowUpscaling,
    int cacheWidth,
    int cacheHeight,
  }) =>
      PaintingBinding.instance.instantiateImageCodec(bytes,
          cacheWidth: cacheWidth, cacheHeight: cacheHeight);
}

// /////////////////////////////////////////////////////////////////////////////////////////////////

/// This is necessary because we want to remove the listener as soon as it's called.
class _ListenerManager {
  _ListenerManager(this.loadCallback);

  VoidCallback removeListener;

  final void Function(ui.Image) loadCallback;

  void onImage(ImageInfo image, bool synchronousCall) {
    loadCallback(image.image);
    removeListener();
  }

  void onError(dynamic exception, StackTrace stackTrace) {
    removeListener();
  }
}

// /////////////////////////////////////////////////////////////////////////////////////////////////
