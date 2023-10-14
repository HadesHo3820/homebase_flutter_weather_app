import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:homebase_flutter_weather_app/core/error/failures.dart';
import 'package:homebase_flutter_weather_app/core/usecases/usecase.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/repositories/weather_repo_interface.dart';

class GetWeatherDetailInfo extends UseCase<WeatherEntity, CityNameParam> {
  final WeatherRepoInterface repository;

  GetWeatherDetailInfo(this.repository);
  @override
  Future<Either<Failure, WeatherEntity>> call(CityNameParam params) {
    return repository.getWeatherDetailInfoByName(params.cityName);
  }
}

class CityNameParam extends Equatable {
  final String cityName;
  const CityNameParam({required this.cityName});

  @override
  List<Object?> get props => [cityName];
}
