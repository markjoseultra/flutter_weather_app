import 'package:dio/dio.dart';
import 'package:open_weather_app/models/current_weather.dart';

Map<String, dynamic> mockData = {
  "coord": {"lon": 121.0811, "lat": 14.5834},
  "weather": [
    {
      "id": 804,
      "main": "Clouds",
      "description": "overcast clouds",
      "icon": "04n",
    },
  ],
  "base": "stations",
  "main": {
    "temp": 297.45,
    "feels_like": 298.36,
    "temp_min": 297.45,
    "temp_max": 297.45,
    "pressure": 1009,
    "humidity": 93,
    "sea_level": 1009,
    "grnd_level": 1006,
  },
  "visibility": 10000,
  "wind": {"speed": 1.15, "deg": 228, "gust": 1.45},
  "clouds": {"all": 100},
  "dt": 1750698035,
  "sys": {"country": "PH", "sunrise": 1750714100, "sunset": 1750760858},
  "timezone": 28800,
  "id": 1694579,
  "name": "Pasig",
  "cod": 200,
};

class WeatherDatasource {
  Future<CurrentWeather> getWeather({
    required double lng,
    required double lat,
  }) async {
    try {
      // if (kDebugMode) {
      //   return CurrentWeather.fromJson(mockData);
      // }

      const openWeatherApiKey = String.fromEnvironment('OPEN_WEATHER_API_KEY');

      final url =
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lng&units=metric&appid=$openWeatherApiKey';

      final response = await Dio().get(url);

      return CurrentWeather.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
