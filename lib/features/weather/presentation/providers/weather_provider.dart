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

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  WeatherNotifier({
    required this.getCachedWeather,
    required this.getWeatherDetailInfoByCityName,
    required this.searchWeatherByCityName,
  });

  void requestToGetCachedWeather() async {
    _isLoading = true;
    notifyListeners();

    final result = await getCachedWeather(NoParams());
    result.fold((failure) {
      _errorMsg = _mapFailureToMessage(failure);
    }, (result) => _cachedWeatherEntity = result);
    _isLoading = false;
    notifyListeners();
  }

  void requestToGetWeatherDetail(String cityName) async {
    _isLoading = true;
    notifyListeners();

    final result =
        await getWeatherDetailInfoByCityName(CityNameParam(cityName: cityName));

    result.fold((failure) {
      _errorMsg = _mapFailureToMessage(failure);
      _weatherDetailInfo = null;
    }, (result) {
      _weatherDetailInfo = result;
      _errorMsg = null;
      requestToGetCachedWeather();
    });
    _isLoading = false;

    notifyListeners();
  }

  void requestToSearchWeatherByPlace(String cityName) async {
    _isLoading = true;
    notifyListeners();

    final result =
        await searchWeatherByCityName(CityNameParam(cityName: cityName));

    result.fold((failure) {
      _errorMsg = _mapFailureToMessage(failure);
      _listWeatherSearchItem = null;
    }, (result) {
      _errorMsg = null;
      _listWeatherSearchItem = result;
    });

    _isLoading = false;
    notifyListeners();
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
