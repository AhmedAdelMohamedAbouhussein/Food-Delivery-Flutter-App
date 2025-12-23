import 'package:final_proj/core/resources/app_colors.dart';
import 'package:final_proj/features/home/cart_screen.dart';
import 'package:final_proj/features/home/checkout_screen.dart';
import 'package:final_proj/features/home/home_content.dart';
import 'package:final_proj/features/home/profile_screen.dart';
import 'package:final_proj/features/home/search_screen.dart';
import 'package:final_proj/features/home/signin_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();
  static const String signupRoute = '/';
  static const String homeRoute = '/home';
  static const String browseRoute = '/browse';
  static const String profileRoute = '/profile';
  static const String orderRoute = '/order';
  static const String checkoutRoute = '/checkout';
}

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.signupRoute:
        return MaterialPageRoute(builder: (context) => const SigninScreen());

      case Routes.homeRoute:
        return MaterialPageRoute(builder: (context) => const HomeContent());

      case Routes.profileRoute:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());

      case Routes.browseRoute:
        return MaterialPageRoute(builder: (context) => const SearchScreen());

        case Routes.checkoutRoute:
        return MaterialPageRoute(builder: (context) => const CheckoutScreen());


      case Routes.orderRoute:
      // Since CartScreen now uses CartManager internally,
      // we don't need to pass arguments here anymore.
        return MaterialPageRoute(
          builder: (context) => const CartScreen(),
        );

      default:
        return _undefinedRoute();
    }
  }

  static Route<dynamic> _undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: const Center(
          child: Text('Route not defined'),
        ),
      ),
    );
  }
}