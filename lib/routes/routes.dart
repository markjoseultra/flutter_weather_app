import 'package:flutter/material.dart';
import 'package:open_weather_app/presentation/pages/auth_page.dart';
import 'package:open_weather_app/presentation/pages/weather_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/'),
          builder: (_) => const AuthPage(),
        );
      case '/main':
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/main'),
          builder: (_) => const WeatherPage(),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return const Scaffold(body: Center(child: Text("Error Route!")));
      },
    );
  }
}
