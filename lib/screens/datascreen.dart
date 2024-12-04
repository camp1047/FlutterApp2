import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  late Future<List<WeatherData>> _data;

  @override
  void initState() {
    super.initState();
    _data = fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<WeatherData>>(
        future: _data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(
                    'https://openweathermap.org/img/wn/${data[index].icon}.png',
                    width: 50,
                    height: 50,
                  ),
                  title: Text(data[index].city),
                  subtitle: Text(data[index].description),
                  trailing: Text('${data[index].temperature.toStringAsFixed(1)}°C'),
                );
              },
            );
          } else {
            return const Center(child: Text('No weather data available'));
          }
        },
      ),
    );
  }

  Future<List<WeatherData>> fetchWeatherData() async {
    const apiKey = '38a544bc3edfb24fd1314de8c2c293f9';
    const cities = ['London', 'Toronto', 'Ottawa', 'Paris', 'New York', 'Tokyo', 'Mumbai','Moscow','Cairo','Seoul','Delhi'];

    List<WeatherData> weatherData = [];
    for (String city in cities) {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final data = WeatherData(
          city: jsonData['name'],
          description: jsonData['weather'][0]['description'],
          temperature: jsonData['main']['temp'],
          icon: jsonData['weather'][0]['icon'],
        );
        weatherData.add(data);
      } else {
        throw Exception('Failed to load data for $city');
      }
    }
    return weatherData;
  }
}

class WeatherData {
  final String city;
  final String description;
  final double temperature;
  final String icon; 

  WeatherData({
    required this.city,
    required this.description,
    required this.temperature,
    required this.icon,
  });
}
