import 'package:shared/constants/app_constants.dart';
import 'package:web/web.dart' as web;

class VisitTracker {
  static bool isFirstVisit() =>
      web.window.localStorage.getItem(
        AppConstants.localStorageKeyVisited,
      ) ==
      null;

  static void markVisited() => web.window.localStorage.setItem(
        AppConstants.localStorageKeyVisited,
        '1',
      );
}
