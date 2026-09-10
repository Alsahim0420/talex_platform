import 'dart:async';

import 'package:flutter/material.dart';
import 'package:talex_platform/core/constants/app_radii.dart';

enum AppNotificationType { success, error, info }

final class NotificationService {
  final navigatorKey = GlobalKey<NavigatorState>();
  OverlayEntry? _entry;
  Timer? _timer;

  void success(String message) =>
      show(message, type: AppNotificationType.success);
  void error(String message) => show(message, type: AppNotificationType.error);
  void info(String message) => show(message);

  void show(
    String message, {
    AppNotificationType type = AppNotificationType.info,
  }) {
    final overlay = navigatorKey.currentState?.overlay;
    if (overlay == null || message.trim().isEmpty) return;
    dismiss();
    _entry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.paddingOf(context).top + 20,
        right: 20,
        left: MediaQuery.sizeOf(context).width < 480 ? 20 : null,
        child: _CornerNotification(message: message, type: type),
      ),
    );
    overlay.insert(_entry!);
    _timer = Timer(const Duration(seconds: 4), dismiss);
  }

  void dismiss() {
    _timer?.cancel();
    _timer = null;
    _entry?.remove();
    _entry = null;
  }
}

class _CornerNotification extends StatelessWidget {
  const _CornerNotification({required this.message, required this.type});
  final String message;
  final AppNotificationType type;

  @override
  Widget build(BuildContext context) {
    final (color, icon) = switch (type) {
      AppNotificationType.success => (
        const Color(0xFF18794E),
        Icons.check_circle_outline,
      ),
      AppNotificationType.error => (
        const Color(0xFFB42318),
        Icons.error_outline,
      ),
      AppNotificationType.info => (const Color(0xFF1E2A3D), Icons.info_outline),
    };
    return Material(
      color: Colors.transparent,
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 180),
        tween: Tween(begin: 0, end: 1),
        builder: (context, value, child) => Transform.translate(
          offset: Offset(24 * (1 - value), 0),
          child: Opacity(opacity: value, child: child),
        ),
        child: Align(
          alignment: Alignment.topRight,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: color,
                borderRadius: AppRadii.border,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 18,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: Colors.white, size: 21),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
