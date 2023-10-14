part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherStateLoaded extends WeatherState {
  final bool? isLoading;
  final WeatherEntity? cachedWeather;
  final WeatherEntity? weatherDetailInfo;
  final String? error;
  final List<WeatherSearchItemEntity>? listSearchItem;
  const WeatherStateLoaded(
      {this.isLoading,
      this.cachedWeather,
      this.weatherDetailInfo,
      this.error,
      this.listSearchItem});

  @override
  List<Object?> get props =>
      [isLoading, cachedWeather, weatherDetailInfo, error, listSearchItem];
}
