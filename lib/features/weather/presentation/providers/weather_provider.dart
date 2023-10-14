import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebase_flutter_weather_app/core/error/failures.dart';
import 'package:homebase_flutter_weather_app/core/usecases/usecase.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/entities/weather_search_item_entity.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/usecases/get_cached_weather.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/usecases/get_weather_detail_info.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/usecases/search_weather.dart';
import 'package:homebase_flutter_weather_app/injection_container.dart';

class WeatherNotifier extends ChangeNotifier {
  final GetCachedWeather getCachedWeather;
  final GetWeatherDetailInfo getWeatherDetailInfoByCityName;
  final SearchWeather searchWeatherByCityName;

  WeatherEntity? _cachedWeatherEntity;

  WeatherEntity? get cachedWeather => _cachedWeatherEntity;

  WeatherEntity? _weatherDetailInfo;

  WeatherEntity? get weatherDetailInfo => _weatherDetailInfo;

  List<WeatherSearchItemEntity>? _listWeatherSearchItem;

  List<WeatherSearchItemEntity>? get listWeatherSearchItem =>
      _listWeatherSearchItem;

  String? _errorMsg;

  String? get errorMsg => _errorMsg;

  WeatherNotifier({
    required this.getCachedWeather,
    required this.getWeatherDetailInfoByCityName,
    required this.searchWeatherByCityName,
  });

  void requestToGetCachedWeather() async {
    final result = await getCachedWeather(NoParams());
    result.fold((failure) => null, (result) => _cachedWeatherEntity = result);
    notifyListeners();
  }

  void requestToGetWeatherDetail(String cityName) async {
    final result =
        await getWeatherDetailInfoByCityName(CityNameParam(cityName: cityName));

    result.fold((failure) {
      _errorMsg = _mapFailureToMessage(failure);
    }, (result) {
      _weatherDetailInfo = result;
      requestToGetCachedWeather();
      notifyListeners();
    });
  }

  void requestToSearchWeatherByPlace(String cityName) async {
    final result =
        await searchWeatherByCityName(CityNameParam(cityName: cityName));

    result.fold((failure) {
      _errorMsg = _mapFailureToMessage(failure);
    }, (result) {
      _listWeatherSearchItem = result;
      notifyListeners();
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return "Unexpected error";
    }
  }
}

const SERVER_FAILURE_MESSAGE = "Error occured from the Server";

const CACHE_FAILURE_MESSAGE = "Error occured from the Local Storage";

final weatherProvider = ChangeNotifierProvider.autoDispose<WeatherNotifier>(
    (_) => WeatherNotifier(
        getCachedWeather: sl(),
        getWeatherDetailInfoByCityName: sl(),
        searchWeatherByCityName: sl()));
