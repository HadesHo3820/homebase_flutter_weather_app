import 'package:flutter/material.dart';
import 'package:homebase_flutter_weather_app/gen/assets.gen.dart';

class ErrorOccurredWidget extends StatelessWidget {
  const ErrorOccurredWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.errorOccured.image(),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Sorry, error occurred. Please check your internet and try again.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30, color: Colors.blue, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
