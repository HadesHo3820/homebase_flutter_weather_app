import 'package:homebase_flutter_weather_app/gen/assets.gen.dart';

extension ConvertConditionCodeToIcon on int {
  String iconPath() {
    switch (this) {
      case 1000:
        return Assets.icons.sunny.path;
      case 1003:
        return Assets.icons.partlyCloudy.path;
      case 1006:
        return Assets.icons.cloudy.path;
      case 1009:
        return Assets.icons.overcast.path;
      case 1030:
        return Assets.icons.mist.path;
      case 1063:
      case 1066:
        return Assets.icons.patchySnow.path;
      case 1069:
        return Assets.icons.sleet.path;
      case 1072:
        return Assets.icons.freezing.path;
      case 1087:
        return Assets.icons.thundery.path;
      default:
        return Assets.icons.sunny.path;
    }
  }
}
