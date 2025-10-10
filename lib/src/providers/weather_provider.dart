import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

final weatherProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  const apiKey = '987a47c5bca14090a8853337250810';

  // === 1. Minta izin lokasi ===
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Layanan lokasi tidak aktif.');
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Izin lokasi ditolak.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception('Izin lokasi ditolak permanen.');
  }

  // === 2. Ambil koordinat pengguna ===
  final position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  final lat = position.latitude;
  final lon = position.longitude;

  // === 3. Panggil API dengan lang=id ===
  final url = Uri.parse(
    'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$lat,$lon&days=3&lang=id&aqi=no&alerts=no',
  );

  final response = await http.get(url);
  if (response.statusCode != 200) {
    throw Exception('Gagal mengambil data cuaca');
  }

  return json.decode(response.body);
});
