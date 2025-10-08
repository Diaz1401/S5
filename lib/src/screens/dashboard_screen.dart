import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/status_card.dart';
import '../widgets/parameter_tile.dart';
import 'charts_screen.dart';
import 'alerts_screen.dart';
import 'device_screen.dart';
import 'settings_screen.dart';
import '../providers/dummy_data.dart';
import '../providers/weather_provider.dart';

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
                      value: DummyData.ph.toStringAsFixed(1),
                      unit: '',
                      trend: DummyData.phTrend,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ParameterTile(
                      icon: Icons.thermostat,
                      title: 'Temperature',
                      value: DummyData.temperature.toStringAsFixed(1),
                      unit: '°C',
                      trend: DummyData.tempTrend,
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
                      value: DummyData.tds.toStringAsFixed(1),
                      unit: 'mg/L',
                      trend: DummyData.tdsTrend,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ParameterTile(
                      icon: Icons.visibility,
                      title: 'Turbidity',
                      value: DummyData.turbidity.toStringAsFixed(1),
                      unit: 'NTU',
                      trend: DummyData.turbidityTrend,
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
              _buildWeatherCard(context, ref),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherCard(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: weatherAsync.when(
          data: (weatherData) {
            final current = weatherData['current'];
            final location = weatherData['location'];
            final forecastDays = weatherData['forecast']['forecastday'] as List;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    const Icon(Icons.wb_sunny),
                    const SizedBox(width: 8),
                    Text(
                      'Weather - ${location['name']}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Current weather
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${current['temp_c']}°C',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text('${current['condition']['text']}'),
                        const SizedBox(height: 4),
                        Text('Humidity: ${current['humidity']}%'),
                      ],
                    ),
                    Image.network(
                      'https:${current['condition']['icon']}',
                      width: 64,
                      height: 64,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.cloud_off, size: 48),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                Text(
                  'Forecast (Next ${forecastDays.length} Days)',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),

                // Forecast list
                Column(
                  children: forecastDays.map((day) {
                    final date = day['date'];
                    final condition = day['day']['condition'];
                    final avgTemp = day['day']['avgtemp_c'];
                    final humidity = day['day']['avghumidity'];

                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Image.network(
                        'https:${condition['icon']}',
                        width: 40,
                        height: 40,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.cloud, size: 32),
                      ),
                      title: Text(
                        date,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        '${condition['text']} • Humidity: $humidity%',
                      ),
                      trailing: Text('${avgTemp.toStringAsFixed(1)}°C'),
                    );
                  }).toList(),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Text('Error: $err'),
        ),
      ),
    );
  }
}
