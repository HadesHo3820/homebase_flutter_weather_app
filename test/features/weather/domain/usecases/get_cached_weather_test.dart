import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homebase_flutter_weather_app/core/usecases/usecase.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/repositories/weather_repo_interface.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/usecases/get_cached_weather.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_cached_weather_test.mocks.dart';

@GenerateNiceMocks([MockSpec<WeatherRepoInterface>()])
void main() {
  late MockWeatherRepoInterface mockRepository;
  late GetCachedWeather usecase;

  setUp(() {
    mockRepository = MockWeatherRepoInterface();
    usecase = GetCachedWeather(mockRepository);
  });

  const tWeatherEntity = WeatherEntity();

  group("GetCachedWeather_Usecase", () {
    test("should get cached weather from the repository", () async {
      // arrange
      when(mockRepository.getWeatherDetailFromCache())
          .thenAnswer((_) async => const Right(WeatherEntity()));

      // act
      final result = await usecase(NoParams());

      // assert
      expect(result, const Right(tWeatherEntity));

      // Verify that the method has been called on the Repository
      verify(mockRepository.getWeatherDetailFromCache());

      // Verify that only the above method should be called and nothing more
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
