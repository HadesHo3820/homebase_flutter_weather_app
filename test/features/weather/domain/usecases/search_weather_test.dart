import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/entities/weather_search_item_entity.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/repositories/weather_repo_interface.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/usecases/get_weather_detail_info.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/usecases/search_weather.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_weather_test.mocks.dart';

@GenerateNiceMocks([MockSpec<WeatherRepoInterface>()])
void main() {
  late MockWeatherRepoInterface mockRepository;
  late SearchWeather usecase;

  setUp(() {
    mockRepository = MockWeatherRepoInterface();
    usecase = SearchWeather(mockRepository);
  });

  const tCityName = "Singapore";
  const tListWeatherSearchEntity = [WeatherSearchItemEntity()];

  group("SearchWeather_UseCase", () {
    test("should get list of weather search items from the repository ",
        () async {
      // arrange
      when(mockRepository.searchWeatherByName(tCityName))
          .thenAnswer((_) async => const Right([WeatherSearchItemEntity()]));

      // act
      final result = await usecase(const CityNameParam(cityName: tCityName));

      // assert
      expect(result, const Right(tListWeatherSearchEntity));

      verify(mockRepository.searchWeatherByName(tCityName));
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
