import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:open_weather_app/models/current_weather.dart';

class WeatherWidget extends StatelessWidget {
  final CurrentWeather currentWeather;

  const WeatherWidget({super.key, required this.currentWeather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 400) {
            return TabletScreenLayout(currentWeather: currentWeather);
          }

          return MobileScreenLayout(currentWeather: currentWeather);
        },
      ),
    );
  }
}

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({super.key, required this.currentWeather});

  final CurrentWeather currentWeather;

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.fromMillisecondsSinceEpoch(
      (currentWeather.dt ?? 0) * 1000,
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            SizedBox(
              width: 400,
              height: MediaQuery.sizeOf(context).height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    child: Image.asset(
                      "assets/${currentWeather.weather?.first.icon}.png",
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${currentWeather.main?.temp?.toStringAsFixed(0)} °C",
                        style: TextStyle(fontSize: 80),
                      ),
                      Text(
                        DateTimeFormat.format(
                          currentDate,
                          format: 'l, M j, H:i',
                        ),
                        style: TextStyle(fontSize: 32, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        currentWeather.weather?.first.description
                                ?.toUpperCase() ??
                            "No description",
                        style: TextStyle(fontSize: 24, color: Colors.grey[700]),
                      ),
                      Text(
                        "${currentWeather.weather?.first.main}",
                        style: TextStyle(fontSize: 24, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  Align(child: LocationWidget(currentWeather: currentWeather)),
                ],
              ),
            ),
            if (MediaQuery.sizeOf(context).width < 400)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Today's Highlights",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50.0,
                    ),
                  ),
                  HighlightTile(
                    title: "Wind Speed",
                    value: "${currentWeather.wind?.speed} mph",
                  ),
                  HighlightTile(
                    title: "Wind Gust",
                    value: "${currentWeather.wind?.gust} mph",
                  ),
                  HighlightTile(
                    title: "Wind Deg",
                    value: "${currentWeather.wind?.deg}°",
                  ),
                  HighlightTile(
                    title: "Visibility",
                    value: "${currentWeather.visibility} m",
                  ),
                  HighlightTile(
                    title: "Pressure",
                    value: "${currentWeather.main?.pressure} mbar",
                  ),

                  HighlightTile(
                    title: "Humidity",
                    value: "${currentWeather.main?.humidity}%",
                  ),
                  HighlightTile(
                    title: "Sea Level",
                    value: "${currentWeather.main?.seaLevel} msl",
                  ),
                  HighlightTile(
                    title: "Ground Level",
                    value: "${currentWeather.main?.grndLevel} masl",
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class TabletScreenLayout extends StatelessWidget {
  const TabletScreenLayout({super.key, required this.currentWeather});

  final CurrentWeather currentWeather;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none)),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              MobileScreenLayout(currentWeather: currentWeather),
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 2,
                height: MediaQuery.sizeOf(context).height,
                child: Wrap(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width / 2,
                          child: Text(
                            "Today's Highlights",
                            maxLines: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 50.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    HighlightTile(
                      title: "Wind Speed",
                      value: "${currentWeather.wind?.speed} mph",
                    ),
                    HighlightTile(
                      title: "Wind Gust",
                      value: "${currentWeather.wind?.gust} mph",
                    ),
                    HighlightTile(
                      title: "Wind Deg",
                      value: "${currentWeather.wind?.deg}°",
                    ),
                    HighlightTile(
                      title: "Visibility",
                      value: "${currentWeather.visibility} m",
                    ),
                    HighlightTile(
                      title: "Pressure",
                      value: "${currentWeather.main?.pressure} mbar",
                    ),

                    HighlightTile(
                      title: "Humidity",
                      value: "${currentWeather.main?.humidity}%",
                    ),
                    HighlightTile(
                      title: "Sea Level",
                      value: "${currentWeather.main?.seaLevel} msl",
                    ),
                    HighlightTile(
                      title: "Ground Level",
                      value: "${currentWeather.main?.grndLevel} masl",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HighlightTile extends StatelessWidget {
  const HighlightTile({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: SizedBox(
        height: 200.0,
        width: 200.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: TextStyle(color: Colors.grey)),
              FittedBox(
                child: Text(
                  value,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key, required this.currentWeather});

  final CurrentWeather currentWeather;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/city.jpg"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        currentWeather.name ?? "Unknown Location",
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
