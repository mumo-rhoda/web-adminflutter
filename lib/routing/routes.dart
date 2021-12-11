const rootRoute = "/";

const overviewPageDisplayName = "Overview";
const overviewPageRoute = "/overview";

const usersPageDisplayName = "Users";
const usersPageRoute = "/Users";

const emergenciesPageDisplayName = "Emergencies";
const emergenciesPageRoute = "/emergencies";

const dispatchTeamPageDisplayName = "DispatchTeams";
const dispatchTeamPageRoute = "/dispatchTeams";

const authenticationPageDisplayName = "Log out";
const authenticationPageRoute = "/auth";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItemRoutes = [
  MenuItem(overviewPageDisplayName, overviewPageRoute),
  MenuItem(usersPageDisplayName, usersPageRoute),
  MenuItem(emergenciesPageDisplayName, emergenciesPageRoute),
  MenuItem(dispatchTeamPageDisplayName, dispatchTeamPageRoute),
  MenuItem(authenticationPageDisplayName, authenticationPageRoute),
];
