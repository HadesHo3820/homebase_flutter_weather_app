import 'package:equatable/equatable.dart';

class WeatherSearchItemEntity extends Equatable {
  final int? id;
  final String? name;
  final String? country;

  const WeatherSearchItemEntity({
    this.id,
    this.name,
    this.country,
  });

  @override
  List<Object?> get props => [id, name, country];
}
