import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/network/network_status.dart';
import '../core/dependency_injection/injection_container.dart';

/// Widget that shows network connection status
/// 
/// Displays a banner when not connected or checking connection
class ConnectionStatusIndicator extends StatelessWidget {
  const ConnectionStatusIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.createNetworkStatusCubit(),
      child: BlocBuilder<NetworkStatusCubit, NetworkConnectionStatus>(
        builder: (context, networkStatus) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _getHeight(networkStatus),
            child: _buildStatusWidget(context, networkStatus),
          );
        },
      ),
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
  ) {
    switch (status) {
      case NetworkConnectionStatus.connected:
        return const SizedBox.shrink();

      case NetworkConnectionStatus.checking:
        return Container(
          color: Colors.orange,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Checking connection...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );

      case NetworkConnectionStatus.disconnected:
        return Container(
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.wifi_off,
                color: Colors.white,
                size: 16,
              ),
              const SizedBox(width: 8),
              const Text(
                'No internet connection',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  context.read<NetworkStatusCubit>().reconnect();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Retry',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

      case NetworkConnectionStatus.error:
        return Container(
          color: Colors.red.shade800,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.white,
                size: 16,
              ),
              SizedBox(width: 8),
              Text(
                'Connection error',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
    }
  }
}

/// Wrapper widget that includes connection status indicator
/// 
/// Use this to wrap your app or screens to show connection status
class ConnectionStatusWrapper extends StatelessWidget {
  final Widget child;
  
  const ConnectionStatusWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ConnectionStatusIndicator(),
        Expanded(child: child),
      ],
    );
  }
}