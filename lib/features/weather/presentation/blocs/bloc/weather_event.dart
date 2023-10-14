part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class RequestGetCachedWeather extends WeatherEvent {}

class SearchWeatherByCityName extends WeatherEvent {
  final String cityName;
  const SearchWeatherByCityName(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class GetWeatherDetailInfoByCityName extends WeatherEvent {
  final String cityName;
  const GetWeatherDetailInfoByCityName(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class RefreshCachedWeather extends WeatherEvent {
  final WeatherEntity entity;
  const RefreshCachedWeather(this.entity);
  @override
  List<Object> get props => [entity];
}
