import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final weatherProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  const apiKey =
      '987a47c5bca14090a8853337250810'; // ganti dengan key WeatherAPI kamu
  const city = 'Sidoarjo'; // bisa ubah sesuai lokasi
  const days = 5; // jumlah hari ke depan

  final url = Uri.parse(
    'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$city&days=$days',
  );

  final response = await http.get(url);

  if (response.statusCode != 200) {
    throw Exception('Failed to load weather data');
  }

  return jsonDecode(response.body);
});
