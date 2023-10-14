import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:homebase_flutter_weather_app/features/weather/data/models/weather_model.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/entities/weather_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tWeatherModel =
      WeatherModel.fromJson(json.decode(fixture("weather.json")));

  group("WeatherModel", () {
    test("should be a subclass of WeatherEntity", () {
      expect(tWeatherModel, isA<WeatherEntity>());
    });
  });

  group("WeatherModel.fromJson", () {
    test("should return a valid model matching with Json response", () {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture("weather.json"));

      // act
      final result = WeatherModel.fromJson(jsonMap);

      // assert
      expect(result, tWeatherModel);
    });
  });

  group("WeatherModel.toJson", () {
    test("should return a Json map containing the proper data", () {
      // act
      final result = tWeatherModel.toJson();

      final expectedJsonMap =
          WeatherModel.fromJson(json.decode(fixture("weather.json"))).toJson();

      // assert
      expect(result, expectedJsonMap);
    });
  });
}
