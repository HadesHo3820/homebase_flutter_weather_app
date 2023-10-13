import 'package:homebase_flutter_weather_app/features/weather/domain/entities/weather_search_item_entity.dart';

class WeatherSearchItemModel extends WeatherSearchItemEntity {
  const WeatherSearchItemModel(
      {required int? id, required String? name, required String? country})
      : super(id: id, name: name, country: country);

  factory WeatherSearchItemModel.fromJson(Map<String, dynamic> json) {
    return WeatherSearchItemModel(
        id: json['id'], country: json['country'], name: json['name']);
  }
}
