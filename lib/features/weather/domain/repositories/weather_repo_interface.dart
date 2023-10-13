import 'package:dartz/dartz.dart';
import 'package:homebase_flutter_weather_app/core/error/failures.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/entities/weather_search_item_entity.dart';

abstract class WeatherRepoInterface {
  Future<Either<Failure, WeatherEntity>> getWeatherDetailInfoByName(
      String name);
  Future<Either<Failure, List<WeatherSearchItemEntity>>> searchWeatherByName(
      String name);

  Future<Either<Failure, WeatherEntity>> getWeatherDetailFromCache();
}
