import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homebase_flutter_weather_app/core/error/failures.dart';
import 'package:homebase_flutter_weather_app/core/usecases/usecase.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/entities/weather_search_item_entity.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/usecases/get_cached_weather.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/usecases/get_weather_detail_info.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/usecases/search_weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCachedWeather getCachedWeather;
  final GetWeatherDetailInfo getWeatherDetailInfoByCityName;
  final SearchWeather searchWeatherByCityName;

  WeatherBloc(
      {required this.getCachedWeather,
      required this.getWeatherDetailInfoByCityName,
      required this.searchWeatherByCityName})
      : super(WeatherInitial()) {
    on<RequestGetCachedWeather>((event, emit) async {
      emit(const WeatherStateLoaded(isLoading: true));
      final cachedWeather = await getCachedWeather(NoParams());
      cachedWeather.fold(
          (failure) =>
              emit(WeatherStateLoaded(error: _mapFailureToMessage(failure))),
          (result) => emit(WeatherStateLoaded(cachedWeather: result)));
    });

    on<SearchWeatherByCityName>((event, emit) async {
      emit(const WeatherStateLoaded(isLoading: true));
      final listItem = await searchWeatherByCityName(
          CityNameParam(cityName: event.cityName));
      listItem.fold(
          (failure) =>
              emit(WeatherStateLoaded(error: _mapFailureToMessage(failure))),
          (result) => emit(WeatherStateLoaded(listSearchItem: result)));
    });

    on<GetWeatherDetailInfoByCityName>((event, emit) async {
      emit(const WeatherStateLoaded(isLoading: true));
      final result = await getWeatherDetailInfoByCityName(
          CityNameParam(cityName: event.cityName));
      result.fold(
          (failure) =>
              emit(WeatherStateLoaded(error: _mapFailureToMessage(failure))),
          (result) => emit(WeatherStateLoaded(weatherDetailInfo: result)));
    });

    on<RefreshCachedWeather>((event, emit) async {
      emit(const WeatherStateLoaded(isLoading: true));
      final result = await getWeatherDetailInfoByCityName(
          CityNameParam(cityName: event.entity.location!.name!));
      result.fold(
          (failure) => emit(WeatherStateLoaded(
              error: _mapFailureToMessage(failure),
              cachedWeather: event.entity)),
          (result) => emit(WeatherStateLoaded(cachedWeather: result)));
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
