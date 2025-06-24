import 'package:flutter/material.dart';
import 'package:open_weather_app/data/coordinate_datasource.dart';
import 'package:open_weather_app/data/weather_datasource.dart';
import 'package:open_weather_app/models/coordinates.dart';
import 'package:open_weather_app/models/current_weather.dart';
import 'package:open_weather_app/presentation/widgets/retry.dart';
import 'package:open_weather_app/presentation/widgets/weather_widget.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  bool isLoading = true;

  String error = "";

  CurrentWeather currentWeather = CurrentWeather();

  WeatherDatasource weatherDatasource = WeatherDatasource();

  GeoService geoService = GeoService();

  Future getData() async {
    try {
      Coord coord = await geoService.getCurrentCoordinates();

      CurrentWeather data = await weatherDatasource.getWeather(
        lng: coord.lon ?? 0.0,
        lat: coord.lat ?? 0.0,
      );

      setState(() {
        isLoading = false;
        currentWeather = data;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        error = e.toString().replaceAll("Exception: ", "");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (!isLoading && error.isNotEmpty) {
      return Retry(
        error: error,
        onRetry: () {
          setState(() {
            isLoading = true;
            error = "";
          });
          getData();
        },
      );
    }

    return WeatherWidget(currentWeather: currentWeather);
  }
}
