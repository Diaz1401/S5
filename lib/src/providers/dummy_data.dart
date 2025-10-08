import '../widgets/parameter_tile.dart';

class DummyData {
  // Nilai parameter air dummy
  static const double ph = 7.4;
  static const double temperature = 29.6; // °C
  static const double tds = 420.0; // mg/L
  static const double turbidity = 12.5; // NTU

  // Skor kualitas air (misalnya untuk StatusCard)
  static const double wqScore = 86.0;

  // Cuaca saat ini
  static const String weatherCondition = "Sunny";
  static const double currentTemp = 31.0;

  // Perkiraan 3 hari ke depan
  static const List<Map<String, dynamic>> forecast = [
    {"day": "Day 1", "icon": "sunny", "temp": 32},
    {"day": "Day 2", "icon": "cloud", "temp": 30},
    {"day": "Day 3", "icon": "rain", "temp": 28},
  ];

  // Arah tren parameter
  static const TrendDirection phTrend = TrendDirection.up;
  static const TrendDirection tempTrend = TrendDirection.neutral;
  static const TrendDirection tdsTrend = TrendDirection.down;
  static const TrendDirection turbidityTrend = TrendDirection.neutral;
}
