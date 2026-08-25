import 'dart:async';
import 'dart:js_interop';

import 'package:talex_platform/core/error/exceptions.dart';
import 'package:web/web.dart' as web;

Future<T> monitorGooglePopup<T>(Future<T> Function() openPopup) async {
  var windowLostFocus = false;
  final popupClosed = Completer<T>();

  final JSFunction onBlur = (web.Event _) {
    windowLostFocus = true;
  }.toJS;
  final JSFunction onFocus = (web.Event _) {
    if (!windowLostFocus || popupClosed.isCompleted) return;
    Future<void>.delayed(const Duration(milliseconds: 600), () {
      if (!popupClosed.isCompleted) {
        popupClosed.completeError(
          const ServerException(
            'Cerraste la ventana de Google antes de completar el inicio de sesión.',
          ),
        );
      }
    });
  }.toJS;

  web.window.addEventListener('blur', onBlur);
  web.window.addEventListener('focus', onFocus);
  try {
    return await Future.any([openPopup(), popupClosed.future]);
  } finally {
    web.window.removeEventListener('blur', onBlur);
    web.window.removeEventListener('focus', onFocus);
  }
}
