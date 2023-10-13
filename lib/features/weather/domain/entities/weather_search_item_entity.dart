import 'package:equatable/equatable.dart';

class WeatherSearchItemEntity extends Equatable {
  final int? id;
  final String? name;
  final String? country;

  const WeatherSearchItemEntity({
    required this.id,
    required this.name,
    required this.country,
  });

  @override
  List<Object?> get props => [int, name, country];
}
