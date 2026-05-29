import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:puri/presentation/screens/splash.dart';

dynamic lat,long;
class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/loginRoute";
  static const String homePageRoute = "/homePage";
  static const String templePagehome = "/templehome";

}
class RouteGenerator
{
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashView());
      // case Routes.homePageRoute:
      //   return MaterialPageRoute(builder: (_) => HomePage());
      // case Routes.templePagehome:
      //   return MaterialPageRoute(builder: (_) => TemplesHome());
       // next same route should be
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: Text("No route Fond"),
          ),
          body: Center(child: Text("No route Found")),
        ));
  }
}

