import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:homebase_flutter_weather_app/core/error/exceptions.dart';
import 'package:homebase_flutter_weather_app/features/weather/data/data_sources/weather_local_data_source.dart';
import 'package:homebase_flutter_weather_app/features/weather/data/models/weather_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'weather_local_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late WeatherLocalDataSourceImpl localDataSource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSource =
        WeatherLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group("getLastWeatherModel", () {
    final tWeatherModel =
        WeatherModel.fromJson(json.decode(fixture("weather.json")));

    test(
        "should return WeatherModel from SharedPreferences when there is one in the cache",
        () async {
      // arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture("weather.json"));

      // act
      final result = await localDataSource.getLastWeather();

      // assert
      verify(mockSharedPreferences.getString(CACHED_WEATHER_KEY));
      expect(result, tWeatherModel);
    });

    test("should throw a CacheException when there is not a cached value", () {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      // act
      final call = localDataSource.getLastWeather;

      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group("cacheNumberTrivia", () {
    final tWeatherModel =
        WeatherModel.fromJson(json.decode(fixture("weather.json")));

    test("should call SharedPreferences to cache the data", () {
      // act
      localDataSource.cacheLatestWeather(tWeatherModel);

      // assert
      final expectedJsonString = json.encode(tWeatherModel.toJson());
      verify(mockSharedPreferences.setString(
          CACHED_WEATHER_KEY, expectedJsonString));
    });
  });
}
