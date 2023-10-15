import 'package:dio/dio.dart';
import 'package:homebase_flutter_weather_app/constants/strings.dart';
import 'package:homebase_flutter_weather_app/core/error/exceptions.dart';
import 'package:homebase_flutter_weather_app/features/weather/data/models/weather_model.dart';
import 'package:homebase_flutter_weather_app/features/weather/data/models/weather_search_item_model.dart';

abstract class WeatherRemoteDataSourceInterface {
  Future<WeatherModel> getWeatherDetailInfoByName(String name);
  Future<List<WeatherSearchItemModel>> searchWeatherByName(String name);
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSourceInterface {
  final Dio client;
  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getWeatherDetailInfoByName(String name) async {
    final response = await client.get("$BASE_URL$CURRENT_END_POINT",
        queryParameters: {'key': API_KEY, 'q': name});

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<WeatherSearchItemModel>> searchWeatherByName(String name) async {
    final response = await client.get("$BASE_URL$SEARCH_END_POINT",
        queryParameters: {'key': API_KEY, 'q': name});

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => WeatherSearchItemModel.fromJson(e))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
