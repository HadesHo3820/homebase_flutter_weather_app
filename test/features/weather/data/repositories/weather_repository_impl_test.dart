import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homebase_flutter_weather_app/core/error/exceptions.dart';
import 'package:homebase_flutter_weather_app/core/error/failures.dart';
import 'package:homebase_flutter_weather_app/core/network/network_info.dart';
import 'package:homebase_flutter_weather_app/features/weather/data/data_sources/weather_local_data_source.dart';
import 'package:homebase_flutter_weather_app/features/weather/data/data_sources/weather_remote_data_source.dart';
import 'package:homebase_flutter_weather_app/features/weather/data/models/weather_model.dart';
import 'package:homebase_flutter_weather_app/features/weather/data/repositories/weather_repo_impl.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'weather_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<WeatherRemoteDataSourceInterface>(),
  MockSpec<WeatherLocalDataSourceInterface>(),
  MockSpec<NetworkInfoInterface>(),
])
void main() {
  late MockWeatherRemoteDataSourceInterface remoteDataSource;
  late MockWeatherLocalDataSourceInterface localDataSource;
  late MockNetworkInfoInterface networkInfo;
  late WeatherRepoImpl repository;

  setUp(() {
    remoteDataSource = MockWeatherRemoteDataSourceInterface();
    localDataSource = MockWeatherLocalDataSourceInterface();
    networkInfo = MockNetworkInfoInterface();
    repository = WeatherRepoImpl(
        remoteDataSource: remoteDataSource,
        localDataSource: localDataSource,
        networkInfo: networkInfo);
  });

  const tCityName = "Singapore";
  final tWeatherModel =
      WeatherModel.fromJson(json.decode(fixture("weather.json")));
  final WeatherEntity tWeatherEntity = tWeatherModel;

  void runTestOnline(Function body) {
    group("device is online", () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body) {
    group("device is online", () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group("getWeatherDetailInfo", () {
    runTestOnline(() {
      test(
          "should return remote data when the call to remote data source is successful",
          () async {
        // arrange
        when(remoteDataSource.getWeatherDetailInfoByName(tCityName))
            .thenAnswer((_) async => tWeatherModel);

        // act
        final result = await repository.getWeatherDetailInfoByName(tCityName);

        // assert
        verify(remoteDataSource.getWeatherDetailInfoByName(tCityName));
        expect(result, equals(Right(tWeatherEntity)));
      });

      test(
          "should cache data locally when the call to remote data source is successful",
          () async {
        // arrange
        when(remoteDataSource.getWeatherDetailInfoByName(tCityName))
            .thenAnswer((_) async => tWeatherModel);

        // act
        await repository.getWeatherDetailInfoByName(tCityName);

        //assert
        verify(remoteDataSource.getWeatherDetailInfoByName(tCityName));
        verify(
            localDataSource.cacheLatestWeather(tWeatherEntity as WeatherModel));
      });

      test(
          "should return [ServerFailure] when the call to RemoteDataSource is failed",
          () async {
        // arrange
        when(remoteDataSource.getWeatherDetailInfoByName(tCityName))
            .thenThrow(ServerException());

        // act
        final result = await repository.getWeatherDetailInfoByName(tCityName);

        //assert
        verify(remoteDataSource.getWeatherDetailInfoByName(tCityName));
        // verify any functions of localDataSource is not used so nothing should be cached locally
        verifyZeroInteractions(localDataSource);
        expect(result, equals(const Left(ServerFailure())));
      });
    });

    runTestOffline(() {
      test("should return [ServerFailure] when there is no Network Connection",
          () async {
        // arrange

        // when(remoteDataSource.getWeatherDetailInfoByName(tCityName))
        //     .thenThrow(ServerException());

        // act
        final result = await repository.getWeatherDetailInfoByName(tCityName);

        //assert
        //verify(remoteDataSource.getWeatherDetailInfoByName(tCityName));
        // verify any functions of localDataSource is not used so nothing should be cached locally
        // verifyZeroInteractions(localDataSource);
        expect(result, equals(const Left(ServerFailure())));
      });
    });
  });
}
