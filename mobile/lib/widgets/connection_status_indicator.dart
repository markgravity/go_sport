import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/network/network_status.dart';

class ConnectionStatusIndicator extends ConsumerWidget {
  const ConnectionStatusIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final networkStatus = ref.watch(networkStatusProvider);
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _getHeight(networkStatus),
      child: _buildStatusWidget(context, networkStatus, ref),
    );
  }

  double _getHeight(NetworkConnectionStatus status) {
    switch (status) {
      case NetworkConnectionStatus.connected:
        return 0;
      case NetworkConnectionStatus.checking:
      case NetworkConnectionStatus.disconnected:
      case NetworkConnectionStatus.error:
        return 40;
    }
  }

  Widget _buildStatusWidget(
    BuildContext context,
    NetworkConnectionStatus status,
    WidgetRef ref,
  ) {
    switch (status) {
      case NetworkConnectionStatus.connected:
        return const SizedBox.shrink();
      
      case NetworkConnectionStatus.checking:
        return Container(
          color: Colors.orange[100],
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  'Đang kiểm tra kết nối...',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      
      case NetworkConnectionStatus.disconnected:
        return Container(
          color: Colors.red[100],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.wifi_off,
                  color: Colors.red,
                  size: 16,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Không có kết nối mạng',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ref.read(networkStatusProvider.notifier).reset();
                  },
                  child: const Text(
                    'Thử lại',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      
      case NetworkConnectionStatus.error:
        return Container(
          color: Colors.red[100],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 16,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Lỗi kết nối đến máy chủ',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ref.read(networkStatusProvider.notifier).reset();
                  },
                  child: const Text(
                    'Thử lại',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
    }
  }
}

// Connection status app bar for integration into existing screens
class ConnectionStatusAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final AppBar appBar;
  
  const ConnectionStatusAppBar({
    Key? key,
    required this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ConnectionStatusIndicator(),
        appBar,
      ],
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(appBar.preferredSize.height + 40);
  }
}