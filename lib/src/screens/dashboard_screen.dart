import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/status_card.dart';
import '../widgets/parameter_tile.dart';
import 'charts_screen.dart';
import 'alerts_screen.dart';
import 'device_screen.dart';
import 'settings_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pond Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () {
              /* TODO: sync */
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              // decoration: BoxDecoration(color: Colors.green),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TRASI',
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Current Pond: Main Pond', // TODO: get from provider
                    style: TextStyle(
                      // color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              selected: true,
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.show_chart),
              title: const Text('Charts'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChartsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.warning),
              title: const Text('Alerts'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AlertsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.device_hub),
              title: const Text('Device'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DeviceScreen()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // WQ Score Card
              const StatusCard(),
              const SizedBox(height: 24),

              // Parameter tiles
              Text(
                'Water Parameters',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ParameterTile(
                      icon: Icons.water_drop,
                      title: 'pH',
                      value: '—', // TODO: Get from provider
                      unit: '',
                      trend: TrendDirection.neutral,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ParameterTile(
                      icon: Icons.thermostat,
                      title: 'Temperature',
                      value: '—', // TODO: Get from provider
                      unit: '°C',
                      trend: TrendDirection.neutral,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ParameterTile(
                      icon: Icons.opacity,
                      title: 'TDS',
                      value: '—', // TODO: Get from provider
                      unit: 'mg/L',
                      trend: TrendDirection.neutral,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ParameterTile(
                      icon: Icons.visibility,
                      title: 'Turbidity',
                      value: '—', // TODO: Get from provider
                      unit: 'NTU',
                      trend: TrendDirection.neutral,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Quick actions
              Text(
                'Quick Actions',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Sync data
                      },
                      icon: const Icon(Icons.sync),
                      label: const Text('Sync'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Add intervention
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Intervention'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Export data
                      },
                      icon: const Icon(Icons.download),
                      label: const Text('Export'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Weather card
              _buildWeatherCard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.wb_sunny),
                const SizedBox(width: 8),
                Text('Weather', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      '—°C', // TODO: Get from weather provider
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Text('—'), // TODO: Weather condition
                  ],
                ),
                // 3-day forecast placeholder
                Row(
                  children: List.generate(3, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Column(
                        children: [
                          Text(
                            'Day ${index + 1}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 4),
                          const Icon(Icons.wb_sunny, size: 20),
                          const SizedBox(height: 4),
                          const Text('—°'), // TODO: Forecast temp
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
