import 'package:flutter/material.dart';

enum TrendDirection { up, down, neutral }

class ParameterTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String unit;
  final TrendDirection trend;
  final String? lastUpdate;

  const ParameterTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.unit,
    required this.trend,
    this.lastUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                _buildTrendIcon(),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(value, style: Theme.of(context).textTheme.headlineMedium),
                if (unit.isNotEmpty) ...[
                  const SizedBox(width: 4),
                  Text(unit, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ],
            ),

            if (lastUpdate != null) ...[
              const SizedBox(height: 8),
              Text(
                'Updated: $lastUpdate',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTrendIcon() {
    IconData trendIcon;
    Color trendColor;

    switch (trend) {
      case TrendDirection.up:
        trendIcon = Icons.trending_up;
        trendColor = Colors.green;
        break;
      case TrendDirection.down:
        trendIcon = Icons.trending_down;
        trendColor = Colors.red;
        break;
      case TrendDirection.neutral:
        trendIcon = Icons.trending_flat;
        trendColor = Colors.grey;
        break;
    }

    return Icon(trendIcon, size: 16, color: trendColor);
  }
}
