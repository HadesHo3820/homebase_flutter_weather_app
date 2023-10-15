import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebase_flutter_weather_app/features/weather/presentation/pages/weather_details_screen.dart';
import 'package:homebase_flutter_weather_app/features/weather/presentation/providers/weather_provider.dart';
import 'package:homebase_flutter_weather_app/features/weather/presentation/widgets/error_widget.dart';
import 'package:homebase_flutter_weather_app/features/weather/presentation/widgets/not_found_widget.dart';

class SearchResultsScreen extends ConsumerWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () {
        ref.read(weatherProvider).requestToGetCachedWeather();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search Results'),
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  autofocus: true,
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.search),
                      border: InputBorder.none,
                      hintText: "Search for Location"),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      ref
                          .read(weatherProvider)
                          .requestToSearchWeatherByPlace(value);
                    }
                  },
                ),
              ),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    final listSearchItem =
                        ref.watch(weatherProvider).listWeatherSearchItem;
                    final errorMsg = ref.watch(weatherProvider).errorMsg;
                    final isLoadingData = ref.watch(weatherProvider).isLoading;
                    if (listSearchItem != null) {
                      if (listSearchItem.isNotEmpty) {
                        return ListView.builder(
                          itemCount: listSearchItem.length,
                          itemBuilder: (context, index) => ListTile(
                            title:
                                Text(listSearchItem[index].country ?? "Null"),
                            subtitle:
                                Text(listSearchItem[index].name ?? "Null"),
                            onTap: () {
                              ref
                                  .read(weatherProvider)
                                  .requestToGetWeatherDetail(
                                      listSearchItem[index].name!);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const WeatherDetailsScreen(),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return const NotFoundWidget();
                      }
                    } else if (isLoadingData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (errorMsg != null) {
                      return const ErrorOccurredWidget();
                    }
                    return const Center(
                        child: Text(
                      "Welcome. \nHave a nine day Moahh",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ));
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
