import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/chart_placeholder.dart';
import '../providers/providers.dart';
import '../models/chart_time_range.dart';

class ChartsScreen extends ConsumerWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeRange = ref.watch(chartTimeRangeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Charts')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Water Quality Trends',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),

              // Time range selector
              Row(
                children: [
                  _buildTimeRangeChip(context, ref, ChartTimeRange.day, '24h'),
                  const SizedBox(width: 8),
                  _buildTimeRangeChip(context, ref, ChartTimeRange.week, '7d'),
                  const SizedBox(width: 8),
                  _buildTimeRangeChip(
                    context,
                    ref,
                    ChartTimeRange.month,
                    '30d',
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Chart area
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Legend
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildLegendItem('pH', Colors.blue),
                            _buildLegendItem('Temp', Colors.red),
                            _buildLegendItem('TDS', Colors.green),
                            _buildLegendItem('Turbidity', Colors.orange),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Chart placeholder
                        Expanded(child: ChartPlaceholder(timeRange: timeRange)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeRangeChip(
    BuildContext context,
    WidgetRef ref,
    ChartTimeRange range,
    String label,
  ) {
    final isSelected = ref.watch(chartTimeRangeProvider) == range;

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          ref.read(chartTimeRangeProvider.notifier).state = range;
        }
      },
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}
