import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:chat_master/core/utils/app_strings.dart';

class AppRoutes {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static pageRoute(Widget screen, {RouteSettings? settings}) {
    return CupertinoPageRoute(settings: settings, builder: (_) => screen);
  }

  static Route<dynamic> undefinedRoute() {
    return CupertinoPageRoute(
      builder: ((context) =>
          const Scaffold(body: Center(child: Text(AppStrings.noRouteFound)))),
    );
  }

  static Route? onGenerateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      // ================ App Features ==================

      // ================ App Features ==================
      //
      // ================ Auth Features ==================

      // ================ Auth Features ==================
      //
      // ================ Home Features ==================

      // ================ Home Features ==================
      //
      // ================ Favorites Features ==================
      // ================ Favorites Features ==================
      //
      // ================ Notifications Features ==================
      // ================ Notifications Features ==================
      //
      // ================ Cart Features ==================
      // ================ Cart Features ==================
      //
      // ================ Order Features ==================
      // ================ Order Features ==================
      //
      // ================ Settings Features ==================
      // ================ Settings Features ==================
      //
      // ================ Profile Features ==================
      // ================ Profile Features ==================
      //
      default:
        return undefinedRoute();
    }
  }
}

Future<dynamic> goTo(routesNames, {Object? args}) async {
  AppRoutes.navigatorKey.currentState!.pushNamed(routesNames, arguments: args);
}

Future<dynamic> back({Object? args}) async =>
    AppRoutes.navigatorKey.currentState!.pop(args);

Future<dynamic> goAndFinish(routesNames, {Object? args}) async {
  AppRoutes.navigatorKey.currentState!
      .pushNamedAndRemoveUntil(routesNames, (route) => false, arguments: args);
}

Future<dynamic> popAndPush(routesNames, {Object? args}) async {
  AppRoutes.navigatorKey.currentState!
      .popAndPushNamed(routesNames, arguments: args);
}

Future<dynamic> popAndPushNew(routesNames, {required Object? args}) async {
  AppRoutes.navigatorKey.currentState!
      .popAndPushNamed(routesNames, arguments: args);
}
