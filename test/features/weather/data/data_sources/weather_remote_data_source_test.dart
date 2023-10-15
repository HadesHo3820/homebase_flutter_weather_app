import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homebase_flutter_weather_app/core/error/exceptions.dart';
import 'package:homebase_flutter_weather_app/features/weather/data/data_sources/weather_remote_data_source.dart';
import 'package:homebase_flutter_weather_app/features/weather/data/models/weather_model.dart';
import 'package:homebase_flutter_weather_app/features/weather/data/models/weather_search_item_model.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'weather_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Dio>()])
void main() {
  late MockDio mockDio;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSource;
  late DioAdapter dioAdapter;

  setUp(() {
    mockDio = MockDio();
    weatherRemoteDataSource = WeatherRemoteDataSourceImpl(client: mockDio);
    dioAdapter = DioAdapter(dio: mockDio);
    mockDio.httpClientAdapter = dioAdapter;
  });

  const tUrlPath = "https://example.com";

  void setUpMockDioClientSuccess200(Function testFunction) {
    group("With ClientSuccess200 Result", () {
      setUp(() {
        dioAdapter.onGet(
            tUrlPath, (request) => request.reply(200, fixture('weather.json')));
      });

      testFunction();
    });
  }

  void setUpMockDioClientFailure404(Function testFunction) {
    group("With ClientFailure404 Result", () {
      setUp(() {
        dioAdapter.onGet(
            tUrlPath, (request) => request.reply(404, fixture('weather.json')));
      });
    });
  }

  group("getWeatherDetailInfoByName", () {
    const tCityName = "Singapore";
    final tWeatherModel =
        WeatherModel.fromJson(json.decode(fixture("weather.json")));

    const path = "$BASE_URL$CURRENT_END_POINT";
    Map<String, dynamic> tQueryParameters = {'key': API_KEY, 'q': tCityName};
    final tDataResponse = json.decode(fixture("weather.json"));

    test(
        "should perform a Get request on a URL with a city name being the endpoint",
        () {
      // Stubbing
      when(mockDio.get(path, queryParameters: tQueryParameters)).thenAnswer(
          (_) async => Response(
              statusCode: 200,
              data: tDataResponse,
              requestOptions: RequestOptions(path: path)));

      // act
      weatherRemoteDataSource.getWeatherDetailInfoByName(tCityName);

      // assert
      verify(
          mockDio.get(path, queryParameters: {'key': API_KEY, 'q': tCityName}));
    });

    test('should return WeatherModel when the response code is 200 (success)',
        () async {
      when(mockDio.get(path, queryParameters: tQueryParameters)).thenAnswer(
          (_) async => Response(
              statusCode: 200,
              data: tDataResponse,
              requestOptions: RequestOptions(path: path)));

      // act
      final result =
          await weatherRemoteDataSource.getWeatherDetailInfoByName(tCityName);

      expect(result, tWeatherModel);
    });

    test(
        "should throws a ServerException when the response code is 404 or other",
        () {
      when(mockDio.get(path, queryParameters: tQueryParameters)).thenAnswer(
          (_) async => Response(
              statusCode: 400,
              data: tDataResponse,
              requestOptions: RequestOptions(path: path)));

      final call = weatherRemoteDataSource.getWeatherDetailInfoByName;

      // assert
      expect(
          () => call(tCityName), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group("searchWeatherByName", () {
    const tCityName = "Singapore";
    final tListWeatherModel =
        (json.decode(fixture("weather_searched.json")) as List)
            .map((e) => WeatherSearchItemModel.fromJson(e))
            .toList();

    const path = "$BASE_URL$SEARCH_END_POINT";

    Map<String, dynamic> tQueryParameters = {'key': API_KEY, 'q': tCityName};

    final tDataResponse = json.decode(fixture("weather_searched.json"));

    test(
        "should perform a Get request on a URL with a city name being the endpoint",
        () {
      // Stubbing
      when(mockDio.get(path, queryParameters: tQueryParameters)).thenAnswer(
          (_) async => Response(
              statusCode: 200,
              data: tDataResponse,
              requestOptions: RequestOptions(path: path)));

      // act
      weatherRemoteDataSource.searchWeatherByName(tCityName);

      // assert
      verify(
          mockDio.get(path, queryParameters: {'key': API_KEY, 'q': tCityName}));
    });

    test(
        'should return List<WeatherSearchItemModel> when the response code is 200 (success)',
        () async {
      when(mockDio.get(path, queryParameters: tQueryParameters)).thenAnswer(
          (_) async => Response(
              statusCode: 200,
              data: tDataResponse,
              requestOptions: RequestOptions(path: path)));

      // act
      final result =
          await weatherRemoteDataSource.searchWeatherByName(tCityName);

      expect(result, tListWeatherModel);
    });

    test(
        "should throws a ServerException when the response code is 404 or other",
        () {
      when(mockDio.get(path, queryParameters: tQueryParameters)).thenAnswer(
          (_) async => Response(
              statusCode: 400,
              data: tDataResponse,
              requestOptions: RequestOptions(path: path)));

      final call = weatherRemoteDataSource.searchWeatherByName;

      // assert
      expect(
          () => call(tCityName), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
