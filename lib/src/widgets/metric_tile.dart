import 'package:flutter/material.dart';

class MetricTile extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final Widget? sparkline;

  const MetricTile({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.sparkline,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.headlineMedium),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(subtitle!, style: Theme.of(context).textTheme.bodySmall),
            ],
            if (sparkline != null) ...[
              const SizedBox(height: 12),
              SizedBox(height: 40, child: sparkline),
            ],
          ],
        ),
      ),
    );
  }
}
