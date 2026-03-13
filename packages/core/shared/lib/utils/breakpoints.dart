import 'package:flutter/widgets.dart';

enum ScreenBreakpoint { mobile, tablet, desktop }

class Breakpoints {
  Breakpoints._();

  static const double _mobileMax = 600;
  static const double _tabletMax = 1024;

  static ScreenBreakpoint of(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < _mobileMax) return ScreenBreakpoint.mobile;
    if (width < _tabletMax) return ScreenBreakpoint.tablet;
    return ScreenBreakpoint.desktop;
  }
}
