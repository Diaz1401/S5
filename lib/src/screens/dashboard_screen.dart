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
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/fuzzy_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
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
              // WQ Score Card (Fuzzy Mamdani)
              Consumer(
                builder: (context, ref, _) {
                  final fuzzy = ref.watch(fuzzyProvider);
                  final label = fuzzy['result']['label'];
                  final score = fuzzy['result']['score'];

                  return Card(
                    color: _labelColor(label).withOpacity(0.1),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Status Kualitas Air',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Text(
                                    'Kategori: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    _labelText(label),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: _labelColor(label),
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Skor: ${score.toStringAsFixed(1)} / 100',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: _labelColor(label),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                label,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
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
                        ref.refresh(weatherProvider);
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
  // pastikan file provider kamu diimpor

  Widget _buildWeatherCard(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherProvider);

    String formatTanggal(String date) {
      final dateTime = DateTime.parse(date);
      final formatter = DateFormat('EEEE, d MMMM yyyy', 'id_ID');
      return formatter.format(dateTime);
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: weatherAsync.when(
          data: (weatherData) {
            final current = weatherData['current'];
            final location = weatherData['location'];
            final forecastDays =
                weatherData['forecast']['forecastday'] as List<dynamic>;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header lokasi
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.blueAccent),
                    const SizedBox(width: 8),
                    Text(
                      '${location['name']}, ${location['region']}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Cuaca saat ini
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${current['temp_c']}°C',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          current['condition']['text'],
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text('Kelembapan: ${current['humidity']}%'),
                        Text('Angin: ${current['wind_kph']} km/jam'),
                        Text('Terasa seperti: ${current['feelslike_c']}°C'),
                      ],
                    ),
                    Image.network(
                      'https:${current['condition']['icon']}',
                      width: 70,
                      height: 70,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.cloud_off, size: 48),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                Text(
                  'Prakiraan Cuaca ${forecastDays.length} Hari ke Depan',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // Daftar prakiraan cuaca
                Column(
                  children: forecastDays.map((day) {
                    final date = formatTanggal(day['date']);
                    final condition = day['day']['condition'];
                    final avgTemp = day['day']['avgtemp_c'];
                    final humidity = day['day']['avghumidity'];
                    final maxTemp = day['day']['maxtemp_c'];
                    final minTemp = day['day']['mintemp_c'];

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: const Color.fromARGB(255, 2, 70, 119),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        leading: Image.network(
                          'https:${condition['icon']}',
                          width: 40,
                          height: 40,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.cloud, size: 32),
                        ),
                        title: Text(
                          date,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        subtitle: Text(
                          '${condition['text']}\n'
                          'Suhu: ${minTemp.toStringAsFixed(1)}°C - ${maxTemp.toStringAsFixed(1)}°C • '
                          'Kelembapan: ${humidity.toStringAsFixed(0)}%',
                        ),
                        trailing: Text(
                          '${avgTemp.toStringAsFixed(1)}°C',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          },
          loading: () =>
              const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          error: (err, _) => Text(
            'Terjadi kesalahan: $err',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }

  Color _labelColor(String label) {
    switch (label) {
      case 'RSR':
        return Colors.green;
      case 'RR':
        return Colors.lightGreen;
      case 'RS':
        return Colors.amber;
      case 'RT':
        return Colors.orange;
      case 'RST':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Konversi singkatan fuzzy ke label lengkap
  String _labelText(String label) {
    switch (label) {
      case 'RSR':
        return 'Risiko Sangat Rendah';
      case 'RR':
        return 'Risiko Rendah';
      case 'RS':
        return 'Risiko Sedang';
      case 'RT':
        return 'Risiko Tinggi';
      case 'RST':
        return 'Risiko Sangat Tinggi';
      default:
        return 'Tidak Diketahui';
    }
  }
}
