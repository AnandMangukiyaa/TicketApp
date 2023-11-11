
import 'package:flutter_ticket/views/pages/pages.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();


  static const String home = "./home";
  static const String addTicket = "./addTicket";
}

class RouteGenerator {
  RouteGenerator._();
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {

      case Routes.home:
        return MaterialPageRoute(builder: (_) => const MyHomePage(title: 'Dashboard',));
      case Routes.addTicket:
        return MaterialPageRoute(
            builder: (_) => const AddTicketPage());
      default:
        return null;
    }
  }
}
