import 'package:homebase_flutter_weather_app/features/weather/domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({required Location? location, required Current? current})
      : super(current: current, location: location);

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        location: json['location'] != null
            ? Location.fromJson(json['location'])
            : null,
        current:
            json['current'] != null ? Current.fromJson(json['current']) : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (current != null) {
      data['current'] = current!.toJson();
    }
    return data;
  }
}
