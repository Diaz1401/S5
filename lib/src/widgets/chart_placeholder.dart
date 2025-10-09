import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/chart_dummy_data.dart';
import '../models/chart_time_range.dart';

class ChartPlaceholder extends StatelessWidget {
  final ChartTimeRange timeRange;

  const ChartPlaceholder({super.key, required this.timeRange});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        // === Garis grid (latar belakang grafik) ===
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          drawHorizontalLine: true,
          getDrawingHorizontalLine: (value) =>
              FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1),
          getDrawingVerticalLine: (value) =>
              FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1),
        ),

        // === Judul dan label sumbu ===
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 40),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 30),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),

        // === Border (bingkai grafik) ===
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
        ),

        // === Data garis (setiap parameter sensor) ===
        lineBarsData: [
          // pH
          LineChartBarData(
            spots: ChartDummyData.phData[timeRange]!,
            isCurved: true,
            color: Colors.blue,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blue.withOpacity(0.1),
            ),
          ),

          // Suhu
          LineChartBarData(
            spots: ChartDummyData.tempData[timeRange]!,
            isCurved: true,
            color: Colors.red,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.red.withOpacity(0.1),
            ),
          ),

          // TDS
          LineChartBarData(
            spots: ChartDummyData.tdsData[timeRange]!,
            isCurved: true,
            color: Colors.green,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.green.withOpacity(0.1),
            ),
          ),

          // Kekeruhan (Turbidity)
          LineChartBarData(
            spots: ChartDummyData.turbidityData[timeRange]!,
            isCurved: true,
            color: Colors.orange,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.orange.withOpacity(0.1),
            ),
          ),
        ],

        // === Rentang sumbu grafik ===
        minX: 0,
        maxX: ChartDummyData.phData[timeRange]!.last.x,
        minY: 0,
        maxY: 100,
      ),
    );
  }
}
