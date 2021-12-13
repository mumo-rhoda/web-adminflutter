import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/bloc/SortingBloc.dart';
import 'package:flutter_web_dashboard/helpers/local_navigator.dart';
import 'package:flutter_web_dashboard/helpers/reponsiveness.dart';
import 'package:flutter_web_dashboard/widgets/large_screen.dart';
import 'package:flutter_web_dashboard/widgets/side_menu.dart';

import 'widgets/top_nav.dart';


class SiteLayout extends StatelessWidget {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String searchCriteria = "All";
  final _bloc = SortingBloc();


  @override
  Widget build(BuildContext context) {
    return BlocProvider<SortingBloc>(
        create: (_) => _bloc,
        child: Scaffold(
          key: scaffoldKey,
          extendBodyBehindAppBar: true,
          appBar:  topNavigationBar(context, scaffoldKey, searchCriteria, _bloc),
          drawer: Drawer(
            child: SideMenu(),
          ),
          body: ResponsiveWidget(
            largeScreen: LargeScreen(),
          smallScreen: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: localNavigator(),
          )
          ),
        )

    );
  }
}
