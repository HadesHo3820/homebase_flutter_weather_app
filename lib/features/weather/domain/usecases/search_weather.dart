import 'package:dartz/dartz.dart';
import 'package:homebase_flutter_weather_app/core/error/failures.dart';
import 'package:homebase_flutter_weather_app/core/usecases/usecase.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/entities/weather_search_item_entity.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/usecases/get_weather_detail_info.dart';

class SearchWeather
    extends UseCase<List<WeatherSearchItemEntity>, CityNameParam> {
  @override
  Future<Either<Failure, List<WeatherSearchItemEntity>>> call(
      CityNameParam params) {
    throw UnimplementedError();
  }
}
