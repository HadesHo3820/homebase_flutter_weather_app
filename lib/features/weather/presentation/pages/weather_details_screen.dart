import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebase_flutter_weather_app/features/weather/presentation/providers/weather_provider.dart';
import 'package:homebase_flutter_weather_app/features/weather/presentation/widgets/search_bar_ui_widget.dart';

class WeatherDetailsScreen extends StatelessWidget {
  const WeatherDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Details'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final weatherDetailInfo =
              ref.watch(weatherProvider).weatherDetailInfo;
          if (weatherDetailInfo != null) {
            return Padding(
              padding: const EdgeInsets.only(
                  right: 16, left: 16, top: 16, bottom: 32),
              child: WeatherDetail(
                weatherEntity: weatherDetailInfo,
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
