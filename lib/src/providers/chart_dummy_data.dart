import 'package:fl_chart/fl_chart.dart';
import '../models/chart_time_range.dart'; // tambahkan ini

class ChartDummyData {
  static Map<ChartTimeRange, List<FlSpot>> phData = {
    ChartTimeRange.day: [
      FlSpot(0, 7.1),
      FlSpot(4, 7.3),
      FlSpot(8, 7.5),
      FlSpot(12, 7.2),
      FlSpot(16, 7.4),
      FlSpot(20, 7.3),
    ],
    ChartTimeRange.week: [
      FlSpot(0, 7.2),
      FlSpot(1, 7.4),
      FlSpot(2, 7.5),
      FlSpot(3, 7.3),
      FlSpot(4, 7.2),
      FlSpot(5, 7.4),
      FlSpot(6, 7.5),
    ],
    ChartTimeRange.month: List.generate(
      30,
      (i) => FlSpot(i.toDouble(), 7.0 + (i % 3) * 0.2),
    ),
  };

  static Map<ChartTimeRange, List<FlSpot>> tempData = {
    ChartTimeRange.day: [
      FlSpot(0, 28),
      FlSpot(4, 29),
      FlSpot(8, 30),
      FlSpot(12, 31),
      FlSpot(16, 30),
      FlSpot(20, 29),
    ],
    ChartTimeRange.week: [
      FlSpot(0, 29),
      FlSpot(1, 30),
      FlSpot(2, 31),
      FlSpot(3, 30),
      FlSpot(4, 29),
      FlSpot(5, 30),
      FlSpot(6, 31),
    ],
    ChartTimeRange.month: List.generate(
      30,
      (i) => FlSpot(i.toDouble(), 28 + (i % 5)),
    ),
  };

  static Map<ChartTimeRange, List<FlSpot>> tdsData = {
    ChartTimeRange.day: [
      FlSpot(0, 400),
      FlSpot(4, 410),
      FlSpot(8, 420),
      FlSpot(12, 415),
      FlSpot(16, 405),
      FlSpot(20, 398),
    ],
    ChartTimeRange.week: [
      FlSpot(0, 420),
      FlSpot(1, 410),
      FlSpot(2, 430),
      FlSpot(3, 415),
      FlSpot(4, 405),
      FlSpot(5, 400),
      FlSpot(6, 395),
    ],
    ChartTimeRange.month: List.generate(
      30,
      (i) => FlSpot(i.toDouble(), 400 + (i % 4) * 5),
    ),
  };

  static Map<ChartTimeRange, List<FlSpot>> turbidityData = {
    ChartTimeRange.day: [
      FlSpot(0, 10),
      FlSpot(4, 12),
      FlSpot(8, 15),
      FlSpot(12, 13),
      FlSpot(16, 11),
      FlSpot(20, 10),
    ],
    ChartTimeRange.week: [
      FlSpot(0, 11),
      FlSpot(1, 12),
      FlSpot(2, 14),
      FlSpot(3, 13),
      FlSpot(4, 12),
      FlSpot(5, 11),
      FlSpot(6, 13),
    ],
    ChartTimeRange.month: List.generate(
      30,
      (i) => FlSpot(i.toDouble(), 10 + (i % 5)),
    ),
  };
}
