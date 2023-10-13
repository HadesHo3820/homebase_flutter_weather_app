import 'package:dartz/dartz.dart';
import 'package:homebase_flutter_weather_app/core/error/exceptions.dart';
import 'package:homebase_flutter_weather_app/core/error/failures.dart';
import 'package:homebase_flutter_weather_app/core/network/network_info.dart';
import 'package:homebase_flutter_weather_app/features/weather/data/data_sources/weather_local_data_source.dart';
import 'package:homebase_flutter_weather_app/features/weather/data/data_sources/weather_remote_data_source.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/entities/weather_search_item_entity.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/repositories/weather_repo_interface.dart';

class WeatherRepoImpl implements WeatherRepoInterface {
  final WeatherRemoteDataSourceInterface remoteDataSource;
  final WeatherLocalDataSourceInterface localDataSource;
  final NetworkInfoInterface networkInfo;

  WeatherRepoImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, WeatherEntity>> getWeatherDetailInfoByName(
      String name) async {
    if (await networkInfo.isConnected) {
      try {
        final weatherEntity =
            await remoteDataSource.getWeatherDetailInfoByName(name);
        localDataSource.cacheLatestWeather(weatherEntity);
        return Right(weatherEntity);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<WeatherSearchItemEntity>>> searchWeatherByName(
      String name) async {
    if (await networkInfo.isConnected) {
      try {
        final listSearchedWeather =
            await remoteDataSource.searchWeatherByName(name);
        return Right(listSearchedWeather);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, WeatherEntity>> getWeatherDetailFromCache() async {
    try {
      final weatherFromCache = await localDataSource.getLastWeather();
      return Right(weatherFromCache);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }
}
