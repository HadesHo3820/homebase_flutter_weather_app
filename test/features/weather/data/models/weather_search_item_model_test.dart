import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:homebase_flutter_weather_app/features/weather/data/models/weather_search_item_model.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/entities/weather_search_item_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tListWeatherSearch =
      (json.decode(fixture("weather_searched.json")) as List)
          .map((e) => WeatherSearchItemModel.fromJson(e))
          .toList();
  final weatherSearchItemModel = tListWeatherSearch.first;

  group("WeatherSearchModel", () {
    test("should be a subclass of WeatherSearchEntity", () {
      expect(weatherSearchItemModel, isA<WeatherSearchItemEntity>());
    });
  });

  group("WeatherSearchModel.fromJson", () {
    test("should return a valid model matching with Json response", () {
      // arrange
      final Map<String, dynamic> jsonMap =
          (json.decode(fixture("weather_searched.json")) as List).first;

      // act
      final result = WeatherSearchItemModel.fromJson(jsonMap);

      // assert
      expect(result, weatherSearchItemModel);
    });
  });
}
