import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/pages/Emergencies/emergencies.dart';
import 'package:flutter_web_dashboard/pages/users/users.dart';
import 'package:flutter_web_dashboard/pages/overview/overview.dart';
import 'package:flutter_web_dashboard/routing/routes.dart';
import 'package:flutter_web_dashboard/pages/dispatchTeam/dispatchTeam.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case overviewPageRoute:
      return _getPageRoute(OverviewPage());
    case usersPageRoute:
      return _getPageRoute(UsersPage());
    case dispatchTeamPageRoute:
      return _getPageRoute(DispatchTeam());
    case emergenciesPageRoute:
      return _getPageRoute(EmergenciesPage());

    default:
      return _getPageRoute(OverviewPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
