import 'package:flutter/material.dart';
import 'package:homebase_flutter_weather_app/gen/assets.gen.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.notFound.image(),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Sorry, we haven't found the place you want",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30, color: Colors.blue, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
