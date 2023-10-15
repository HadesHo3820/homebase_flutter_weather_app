import 'package:dio/dio.dart';
import 'package:homebase_flutter_weather_app/core/error/exceptions.dart';
import 'package:homebase_flutter_weather_app/features/weather/data/models/weather_model.dart';
import 'package:homebase_flutter_weather_app/features/weather/data/models/weather_search_item_model.dart';

const String BASE_URL = "http://api.weatherapi.com/v1";
const String API_KEY = "699e68b23e214618b52115246231110";
const String SEARCH_END_POINT = "/search.json";
const String CURRENT_END_POINT = "/current.json";

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
