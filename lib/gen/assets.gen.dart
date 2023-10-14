/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/cloudy.png
  AssetGenImage get cloudy => const AssetGenImage('assets/icons/cloudy.png');

  /// File path: assets/icons/freezing.png
  AssetGenImage get freezing =>
      const AssetGenImage('assets/icons/freezing.png');

  /// File path: assets/icons/mist.png
  AssetGenImage get mist => const AssetGenImage('assets/icons/mist.png');

  /// File path: assets/icons/not_found.png
  AssetGenImage get notFound =>
      const AssetGenImage('assets/icons/not_found.png');

  /// File path: assets/icons/overcast.png
  AssetGenImage get overcast =>
      const AssetGenImage('assets/icons/overcast.png');

  /// File path: assets/icons/partly_cloudy.png
  AssetGenImage get partlyCloudy =>
      const AssetGenImage('assets/icons/partly_cloudy.png');

  /// File path: assets/icons/patchy_snow.png
  AssetGenImage get patchySnow =>
      const AssetGenImage('assets/icons/patchy_snow.png');

  /// File path: assets/icons/sleet.png
  AssetGenImage get sleet => const AssetGenImage('assets/icons/sleet.png');

  /// File path: assets/icons/sunny.png
  AssetGenImage get sunny => const AssetGenImage('assets/icons/sunny.png');

  /// File path: assets/icons/thundery.png
  AssetGenImage get thundery =>
      const AssetGenImage('assets/icons/thundery.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        cloudy,
        freezing,
        mist,
        notFound,
        overcast,
        partlyCloudy,
        patchySnow,
        sleet,
        sunny,
        thundery
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}
