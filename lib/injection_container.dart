import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:homebase_flutter_weather_app/core/network/network_info.dart';
import 'package:homebase_flutter_weather_app/features/weather/data/data_sources/weather_local_data_source.dart';
import 'package:homebase_flutter_weather_app/features/weather/data/data_sources/weather_remote_data_source.dart';
import 'package:homebase_flutter_weather_app/features/weather/data/repositories/weather_repo_impl.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/repositories/weather_repo_interface.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/usecases/get_cached_weather.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/usecases/get_weather_detail_info.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/usecases/search_weather.dart';
import 'package:homebase_flutter_weather_app/features/weather/presentation/blocs/bloc/weather_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
void init() async {
  //! Features - Weather
  // BLoC
  sl.registerFactory(() => WeatherBloc(
      getCachedWeather: sl(),
      getWeatherDetailInfoByCityName: sl(),
      searchWeatherByCityName: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetCachedWeather(sl()));
  sl.registerLazySingleton(() => GetWeatherDetailInfo(sl()));
  sl.registerLazySingleton(() => SearchWeather(sl()));

  // Repository
  sl.registerLazySingleton<WeatherRepoInterface>(() => WeatherRepoImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  // Data sources
  sl.registerLazySingleton<WeatherRemoteDataSourceInterface>(
      () => WeatherRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<WeatherLocalDataSourceInterface>(
      () => WeatherLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfoInterface>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<Dio>(() => Dio());

  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
}

void initFeatures() {}
