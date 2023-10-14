import 'package:flutter/material.dart';
import 'package:homebase_flutter_weather_app/core/extension.dart';
import 'package:homebase_flutter_weather_app/features/weather/domain/entities/weather_entity.dart';

class WeatherDetail extends StatelessWidget {
  final WeatherEntity weatherEntity;
  const WeatherDetail({
    required this.weatherEntity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locationName = weatherEntity.location!.name;
    final locationCountry = weatherEntity.location!.country;
    final cDegree = weatherEntity.current!.tempC;
    final fDegree = weatherEntity.current!.tempF;
    final condition = weatherEntity.current!.condition!;
    final lastUpdated = weatherEntity.current!.lastUpdated!;

    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue.withOpacity(.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '$locationName, $locationCountry',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),

          Image.asset(
            condition.code!.iconPath(),
          ),
          Text(
            '$cDegree°C | $fDegree°F',
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            '${condition.text}',
            style: const TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Last updated: $lastUpdated',
            style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
          ),

          // Add more weather information here
        ],
      ),
    );
  }
}
