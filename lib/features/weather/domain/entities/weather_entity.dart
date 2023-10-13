import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final Location? location;
  final Current? current;

  const WeatherEntity({this.location, this.current});

  @override
  List<Object?> get props => [location, current];
}

class Location {
  String? name;
  String? country;

  Location({this.name, this.country});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['country'] = country;
    return data;
  }
}

class Current {
  String? lastUpdated;
  int? tempC;
  double? tempF;
  int? isDay;
  Condition? condition;

  Current({
    this.lastUpdated,
    this.tempC,
    this.tempF,
    this.isDay,
    this.condition,
  });

  Current.fromJson(Map<String, dynamic> json) {
    lastUpdated = json['last_updated'];
    tempC = json['temp_c'];
    tempF = json['temp_f'];
    isDay = json['is_day'];
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['last_updated'] = lastUpdated;
    data['temp_c'] = tempC;
    data['temp_f'] = tempF;
    data['is_day'] = isDay;
    if (condition != null) {
      data['condition'] = condition!.toJson();
    }
    return data;
  }
}

class Condition {
  String? text;
  int? code;

  Condition({this.text, this.code});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['code'] = code;
    return data;
  }
}
