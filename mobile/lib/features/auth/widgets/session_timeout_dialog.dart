import 'dart:async';
import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

class SessionTimeoutDialog extends StatefulWidget {
  final int remainingMinutes;
  final VoidCallback onExtendSession;
  final VoidCallback onLogout;

  const SessionTimeoutDialog({
    super.key,
    required this.remainingMinutes,
    required this.onExtendSession,
    required this.onLogout,
  });

  @override
  State<SessionTimeoutDialog> createState() => _SessionTimeoutDialogState();
}

class _SessionTimeoutDialogState extends State<SessionTimeoutDialog> {
  late int _remainingSeconds;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.remainingMinutes * 60;
    _startCountdown();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
        // Auto-logout when time runs out
        Navigator.of(context).pop();
        widget.onLogout();
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return PopScope(
      canPop: false, // Prevent dismissal by back button
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(
              Icons.timer,
              color: Colors.orange.shade600,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              l10n.sessionTimeout,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.sessionTimeoutMessage,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.access_time,
                    color: Colors.orange.shade600,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _formatTime(_remainingSeconds),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _countdownTimer?.cancel();
              Navigator.of(context).pop();
              widget.onLogout();
            },
            child: Text(
              l10n.logoutNow,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _countdownTimer?.cancel();
              Navigator.of(context).pop();
              widget.onExtendSession();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E5BDA),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              l10n.extendSession,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Factory method to show session timeout dialog
  // ignore: unused_element
  static Future<void> show(
    BuildContext context, {
    required int remainingMinutes,
    required VoidCallback onExtendSession,
    required VoidCallback onLogout,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SessionTimeoutDialog(
        remainingMinutes: remainingMinutes,
        onExtendSession: onExtendSession,
        onLogout: onLogout,
      ),
    );
  }
}