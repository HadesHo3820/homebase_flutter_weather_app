import 'dart:convert';

import 'package:homebase_flutter_weather_app/core/error/exceptions.dart';
import 'package:homebase_flutter_weather_app/features/weather/data/models/weather_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CACHED_WEATHER_KEY = "CACHED_WEATHER_KEY";

abstract class WeatherLocalDataSourceInterface {
  Future<WeatherModel> getLastWeather();
  Future<void> cacheLatestWeather(WeatherModel weatherModel);
}

class WeatherLocalDataSourceImpl implements WeatherLocalDataSourceInterface {
  final SharedPreferences sharedPreferences;

  WeatherLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheLatestWeather(WeatherModel weatherModel) {
    return sharedPreferences.setString(
        CACHED_WEATHER_KEY, json.encode(weatherModel.toJson()));
  }

  @override
  Future<WeatherModel> getLastWeather() {
    final jsonString = sharedPreferences.getString(CACHED_WEATHER_KEY);
    if (jsonString != null) {
      return Future.value(WeatherModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
