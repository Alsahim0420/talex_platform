import 'package:flutter/widgets.dart';

enum ScreenSize { compact, medium, expanded }

abstract final class AppBreakpoints {
  static const compact = 600.0;
  static const expanded = 1024.0;
}

@immutable
class ResponsiveLayout {
  const ResponsiveLayout._({required this.width, required this.height});

  factory ResponsiveLayout.of(
    BuildContext context,
    BoxConstraints constraints,
  ) {
    final media = MediaQuery.of(context);
    return ResponsiveLayout._(
      width: constraints.hasBoundedWidth
          ? constraints.maxWidth
          : media.size.width,
      height: constraints.hasBoundedHeight
          ? constraints.maxHeight
          : media.size.height,
    );
  }

  final double width;
  final double height;

  ScreenSize get screenSize => width < AppBreakpoints.compact
      ? ScreenSize.compact
      : width < AppBreakpoints.expanded
      ? ScreenSize.medium
      : ScreenSize.expanded;

  bool get isCompact => screenSize == ScreenSize.compact;
  bool get isShort => height < 760;
  double get horizontalPadding => isCompact ? 16 : 24;
  double get verticalPadding => isCompact || isShort ? 24 : 48;
  double get cardPadding => width < 380
      ? 20
      : isCompact
      ? 24
      : 32;
  double get logoSize => width < 360
      ? 38
      : isCompact
      ? 42
      : 48;
  double get logoWidth => width < 360
      ? 190
      : isCompact
      ? 220
      : 250;
  double get logoHeight => width < 360
      ? 55
      : isCompact
      ? 64
      : 72;
  double get cardMaxWidth => 448;
}
