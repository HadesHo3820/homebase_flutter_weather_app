import 'package:dartz/dartz.dart';
import 'package:homebase_flutter_weather_app/core/error/failures.dart';
import 'package:homebase_flutter_weather_app/core/usecases/usecase.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/entities/weather_entity.dart';

class GetCachedWeather extends UseCase<WeatherEntity, NoParams> {
  @override
  Future<Either<Failure, WeatherEntity>> call(NoParams params) {
    throw UnimplementedError();
  }
}
