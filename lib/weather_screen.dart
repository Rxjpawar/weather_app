// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:weather_app/additional_info.dart';
import 'package:weather_app/hourly_forecast.dart';
import 'dart:ui';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String cityname = 'Mumbai';
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      // String cityname = 'Mumbai';
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityname&appid=1c25037c82db50784f79fc736041ff98&units=metric',
        ),
      );
      // api key is here
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw 'Failed to load weather data';
      }

      //(data['list'][0]['main']['temp']);
      //String currentSky = data['list'][0]['weather'][0]['main'];
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 140, 255),
        elevation: 0,
        leading: PopupMenuButton<String>(
          
          elevation: 1,
          icon: const Icon(Icons.menu, color: Colors.white),
          color: const Color.fromARGB(199, 10, 153, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onSelected: (String selectedCity) {
            setState(() {
              cityname = selectedCity;
            });
          },
          itemBuilder:
              (BuildContext context) => [
                PopupMenuItem(
                  value: 'Mumbai',
                  child: Row(
                    children: const [
                      SizedBox(width: 8),
                      Text(
                        'Mumbai',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'Delhi',
                  child: Row(
                    children: const [
                      SizedBox(width: 8),
                      Text(
                        'Delhi',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'Bangalore',
                  child: Row(
                    children: const [
                      SizedBox(width: 8),
                      Text(
                        'Bangalore',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'Chennai',
                  child: Row(
                    children: const [
                      SizedBox(width: 8),
                      Text(
                        'Chennai',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'Kolkata',
                  child: Row(
                    children: const [
                      SizedBox(width: 8),
                      Text(
                        'Kolkata',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
        ),

        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,

        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
              //  print('Refresh button pressed');
              // Handle settings action
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        // ignore: non_constant_identifier_names
        builder: (Context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error.toString()}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final data = snapshot.data;
          final currentWeather = data?['list']?[0]?['main']?['temp'] ?? 'N/A';
          final currentSky = data?['list'][0]['weather'][0]['main'];
          final currentHumidity = data?['list'][0]['main']['humidity'];
          final currentWindSpeed = data?['list'][0]['wind']['speed'];
          final currentPressure = data?['list'][0]['main']['pressure'];

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 0, 140, 255),
                  const Color.fromARGB(255, 0, 128, 255),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.25),

                                  Colors.white.withOpacity(0.05),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  cityname,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "$currentWeather °C",
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Icon(
                                  currentSky == 'Clouds' || currentSky == 'Rain'
                                      ? Icons.cloud
                                      : Icons.sunny,
                                  size: 64,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  currentSky,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Weather Forecast",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  // weather forecast cards
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...() {
                          DateTime now = DateTime.now();
                          List<dynamic> forecastList = data?['list'] ?? [];

                          // Filter out only future forecasts
                          List<dynamic> futureForecasts =
                              forecastList.where((entry) {
                                DateTime forecastTime = DateTime.parse(
                                  entry['dt_txt'],
                                );
                                return forecastTime.isAfter(now);
                              }).toList();

                          // this showhow 5 future 3-hourly forecasts
                          return List.generate(5, (index) {
                            final entry = futureForecasts[index];

                            return HourlyForecastCard(
                              time: entry['dt_txt']?.substring(11, 16) ?? 'N/A',
                              icon:
                                  (entry['weather'][0]['main'] == 'Clouds' ||
                                          entry['weather'][0]['main'] == 'Rain')
                                      ? Icons.cloud
                                      : Icons.sunny,
                              temperature:
                                  entry['main']['temp'] != null
                                      ? '${entry['main']['temp'].round()}°C'
                                      : 'N/A',
                            );
                          });
                        }(),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // additional weather information
                  Text(
                    "Additional Information",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInfoCard(
                        icon: Icons.water_drop,
                        label: "Humidity",
                        value: currentHumidity.toString(),
                      ),
                      const SizedBox(width: 8),
                      AdditionalInfoCard(
                        icon: Icons.air,
                        label: "Wind Speed",
                        value: currentWindSpeed.toString(),
                      ),
                      const SizedBox(width: 8),
                      AdditionalInfoCard(
                        icon: Icons.beach_access,
                        label: "Preassure",
                        value: currentPressure.toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
