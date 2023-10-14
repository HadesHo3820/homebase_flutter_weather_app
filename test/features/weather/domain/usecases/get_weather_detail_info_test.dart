import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/repositories/weather_repo_interface.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/usecases/get_weather_detail_info.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_weather_detail_info_test.mocks.dart';

@GenerateNiceMocks([MockSpec<WeatherRepoInterface>()])
void main() {
  late MockWeatherRepoInterface mockRepository;
  late GetWeatherDetailInfo usecase;

  setUp(() {
    mockRepository = MockWeatherRepoInterface();
    usecase = GetWeatherDetailInfo(mockRepository);
  });

  const tCityName = "Singapore";
  const tWeatherEntity = WeatherEntity();

  group("GetWeatherDetail_Usecase", () {
    test("should get weather for the city name from the repository", () async {
      // arrange
      when(mockRepository.getWeatherDetailInfoByName(any))
          .thenAnswer((_) async => const Right(WeatherEntity()));

      // act
      final result = await usecase(const CityNameParam(cityName: tCityName));

      // assert
      expect(result, const Right(tWeatherEntity));

      // Verify that the method has been called on the Repository
      verify(mockRepository.getWeatherDetailInfoByName(tCityName));

      // Verify that only the above method should be called and nothing more
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
