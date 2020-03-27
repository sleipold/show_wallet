import 'package:flutter/material.dart';
import 'package:showwallet/constants/route_names.dart';
import 'package:showwallet/models/post.dart';
import 'package:showwallet/ui/views/cashbox_view.dart';
import 'package:showwallet/ui/views/create_post_view.dart';
import 'package:showwallet/ui/views/debt_view.dart';
import 'package:showwallet/ui/views/fine_catalog_view.dart';
import 'package:showwallet/ui/views/home_view.dart';
import 'package:showwallet/ui/views/login_view.dart';
import 'package:showwallet/ui/views/signup_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginView(),
      );
    case SignUpViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignUpView(),
      );
    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeView(),
      );
    case CreatePostViewRoute:
      var postToEdit = settings.arguments as Post;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CreatePostView(
          editingPost: postToEdit,
        ),
      );
    case CashboxViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CashboxView(),
      );
    case FineCatalogViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: FineCatalogView(),
      );
    case DebtViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: DebtView(),
      );
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}
