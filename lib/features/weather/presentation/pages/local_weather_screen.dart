import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:homebase_flutter_weather_app/features/weather/presentation/pages/search_results_screen.dart';
import 'package:homebase_flutter_weather_app/features/weather/presentation/providers/weather_provider.dart';
import 'package:homebase_flutter_weather_app/features/weather/presentation/widgets/search_bar_ui_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WeatherScreen extends HookConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future.delayed(
        const Duration(milliseconds: 200),
        () {
          ref.read(weatherProvider).requestToGetCachedWeather();
        },
      );
      return null;
    });

    ref.listen(weatherProvider, (previous, next) {
      if (previous?.errorMsg != next.errorMsg && next.errorMsg != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.errorMsg!)));
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          print("refresh triggered");
        },
        child: Padding(
          padding:
              const EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 32),
          child: Column(
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    //ref.refresh(weatherProvider);
                    ref.invalidate(weatherProvider);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SearchResultsScreen(),
                    ));
                  },
                  child: SearchBar()),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    final cachedWeather =
                        ref.watch(weatherProvider).cachedWeather;
                    final isLoadingData = ref.watch(weatherProvider).isLoading;
                    if (cachedWeather != null) {
                      return WeatherDetail(
                        weatherEntity: cachedWeather,
                      );
                    } else if (isLoadingData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'Welcome to Weather App.\nTry it now',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget SearchBar() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
    width: double.infinity,
    //height: 50,
    decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: const Row(
      children: [
        Icon(Icons.search),
        SizedBox(
          width: 16,
        ),
        Text('Search for Location')
      ],
    ),
  );
}
