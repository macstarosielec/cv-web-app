import 'package:web/web.dart' as web;

class VisitTracker {
  static const _key = 'cv_app_visited';

  static bool isFirstVisit() =>
      web.window.localStorage.getItem(_key) == null;

  static void markVisited() =>
      web.window.localStorage.setItem(_key, '1');
}
