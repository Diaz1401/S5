import 'package:flutter/material.dart';
import '../providers/providers.dart';

class SyncProgressWidget extends StatelessWidget {
  final SyncStatus status;
  final VoidCallback? onRetry;
  final VoidCallback? onCancel;

  const SyncProgressWidget({
    super.key,
    required this.status,
    this.onRetry,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStatusIcon(),
        const SizedBox(height: 24),

        Text(
          _getStatusTitle(),
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),

        Text(
          _getStatusDescription(),
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),

        _buildActionButtons(context),
      ],
    );
  }

  Widget _buildStatusIcon() {
    switch (status) {
      case SyncStatus.syncing:
        return const SizedBox(
          width: 80,
          height: 80,
          child: CircularProgressIndicator(strokeWidth: 6),
        );
      case SyncStatus.success:
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_circle, color: Colors.green, size: 48),
        );
      case SyncStatus.error:
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.error, color: Colors.red, size: 48),
        );
      case SyncStatus.idle:
      default:
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.sync, color: Colors.grey, size: 48),
        );
    }
  }

  String _getStatusTitle() {
    switch (status) {
      case SyncStatus.syncing:
        return 'Syncing Data...';
      case SyncStatus.success:
        return 'Sync Complete';
      case SyncStatus.error:
        return 'Sync Failed';
      case SyncStatus.idle:
      default:
        return 'Ready to Sync';
    }
  }

  String _getStatusDescription() {
    switch (status) {
      case SyncStatus.syncing:
        return 'Downloading water quality data from sensor device. Please wait...';
      case SyncStatus.success:
        return 'All data has been successfully synchronized with the sensor device.';
      case SyncStatus.error:
        return 'Failed to sync data. Please check your connection and try again.';
      case SyncStatus.idle:
      default:
        return 'Tap sync to download the latest water quality measurements.';
    }
  }

  Widget _buildActionButtons(BuildContext context) {
    switch (status) {
      case SyncStatus.syncing:
        return ElevatedButton(
          onPressed: onCancel,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
          child: const Text('Cancel'),
        );
      case SyncStatus.success:
        return ElevatedButton(
          onPressed: onCancel, // Close/Done action
          child: const Text('Done'),
        );
      case SyncStatus.error:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(onPressed: onCancel, child: const Text('Cancel')),
            const SizedBox(width: 16),
            ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        );
      case SyncStatus.idle:
      default:
        return ElevatedButton(
          onPressed: onRetry, // Start sync action
          child: const Text('Start Sync'),
        );
    }
  }
}
