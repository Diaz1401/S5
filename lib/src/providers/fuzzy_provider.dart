// lib/src/providers/fuzzy_provider.dart
// Provider yang memanggil FuzzyEvaluator menggunakan DummyData (default).
// Ganti sumber data di bagian "DATA SOURCE" untuk menggunakan sensor nyata.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/fuzzy_evaluator.dart';
import '../providers/dummy_data.dart'; // sesuaikan path

final fuzzyProvider = Provider<Map<String, dynamic>>((ref) {
  // ===== DATA SOURCE =====
  // Untuk saat ini menggunakan DummyData. Ganti di sini jika ingin pakai data sensor:
  //
  // final ph = sensorData.ph;
  // final temp = sensorData.temperature;
  // final tds = sensorData.tds;
  // final turb = sensorData.turbidity;
  //
  // cukup replace variabel di bawah ini.
  final ph = DummyData.ph;
  final temp = DummyData.temperature;
  final tds = DummyData.tds;
  final turb = DummyData.turbidity;
  // =========================

  final result = FuzzyEvaluator.evaluate(
    ph: ph,
    temperature: temp,
    tds: tds,
    turbidity: turb,
  );

  // return tambahan untuk debugging
  return {
    'input': {'ph': ph, 'temperature': temp, 'tds': tds, 'turbidity': turb},
    'result': result,
  };
});
