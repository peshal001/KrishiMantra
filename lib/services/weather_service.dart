import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = 'YOUR_OPENWEATHER_API_KEY'; // Replace with your actual OpenWeather API key

  // Method to fetch current weather data by city
  Future<Map<String, dynamic>> fetchWeather(String city) async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric',
        ),
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON data
        return json.decode(response.body);
      } else {
        // If the response is not OK, throw an exception
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
      return {};
    }
  }
}
