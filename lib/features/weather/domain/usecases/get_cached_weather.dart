import 'package:dartz/dartz.dart';
import 'package:homebase_flutter_weather_app/core/error/failures.dart';
import 'package:homebase_flutter_weather_app/core/usecases/usecase.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/repositories/weather_repo_interface.dart';

class GetCachedWeather extends UseCase<WeatherEntity, NoParams> {
  final WeatherRepoInterface repository;
  GetCachedWeather(this.repository);

  @override
  Future<Either<Failure, WeatherEntity>> call(NoParams params) {
    return repository.getWeatherDetailFromCache();
  }
}
