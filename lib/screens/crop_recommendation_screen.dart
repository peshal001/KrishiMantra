import 'package:flutter/material.dart';
import 'package:kri/services/weather_service.dart';

class CropRecommendationScreen extends StatefulWidget {
  @override
  _CropRecommendationScreenState createState() => _CropRecommendationScreenState();
}

class _CropRecommendationScreenState extends State<CropRecommendationScreen> {
  final WeatherService _weatherService = WeatherService();
  Map<String, dynamic> _weatherData = {};

  @override
  void initState() {
    super.initState();
    // Example: Fetch weather data for Kathmandu
    _fetchWeatherData('Kathmandu');
  }

  Future<void> _fetchWeatherData(String city) async {
    var weather = await _weatherService.fetchWeather(city);
    setState(() {
      _weatherData = weather;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crop Recommendation')),
      body: _weatherData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Weather in Kathmandu',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Temperature: ${_weatherData['main']['temp']}°C',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Humidity: ${_weatherData['main']['humidity']}%',
                    style: TextStyle(fontSize: 18),
                  ),
                  // You can add more weather data here (e.g., wind speed, pressure)
                ],
              ),
            ),
    );
  }
}
