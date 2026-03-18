// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'admin_content_router.dart';

/// generated route for
/// [DashboardPage]
class DashboardRoute extends PageRouteInfo<DashboardRouteArgs> {
  DashboardRoute({
    VoidCallback? onSignOut,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         DashboardRoute.name,
         args: DashboardRouteArgs(onSignOut: onSignOut, key: key),
         initialChildren: children,
       );

  static const String name = 'DashboardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DashboardRouteArgs>(
        orElse: () => const DashboardRouteArgs(),
      );
      return DashboardPage(onSignOut: args.onSignOut, key: args.key);
    },
  );
}

class DashboardRouteArgs {
  const DashboardRouteArgs({this.onSignOut, this.key});

  final VoidCallback? onSignOut;

  final Key? key;

  @override
  String toString() {
    return 'DashboardRouteArgs{onSignOut: $onSignOut, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! DashboardRouteArgs) return false;
    return onSignOut == other.onSignOut && key == other.key;
  }

  @override
  int get hashCode => onSignOut.hashCode ^ key.hashCode;
}
