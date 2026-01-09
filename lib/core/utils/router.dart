import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rightflair/core/constants/route.dart';
import 'package:rightflair/feature/choose_username/page/choose_username_page.dart';
import 'package:rightflair/feature/authentication/pages/forgot_password_page.dart';
import 'package:rightflair/feature/authentication/pages/login_page.dart';
import 'package:rightflair/feature/authentication/pages/welcome_page.dart';
import 'package:rightflair/feature/navigation/page/navigation_page.dart';

import '../../feature/authentication/pages/register_page.dart';

final GoRouter router = GoRouter(
  initialLocation: RouteConstants.NAVIGATION,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: RouteConstants.WELCOME,
      name: RouteConstants.WELCOME,
      builder: (context, state) => WelcomePage(),
    ),
    GoRoute(
      path: RouteConstants.REGISTER,
      name: RouteConstants.REGISTER,
      builder: (context, state) => RegisterPage(),
    ),
    GoRoute(
      path: RouteConstants.CHOOSE_USERNAME,
      name: RouteConstants.CHOOSE_USERNAME,
      builder: (context, state) => ChooseUsernamePage(),
    ),
    GoRoute(
      path: RouteConstants.LOGIN,
      name: RouteConstants.LOGIN,
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: RouteConstants.FORGOT_PASSWORD,
      name: RouteConstants.FORGOT_PASSWORD,
      builder: (context, state) => ForgotPasswordPage(),
    ),
    
    GoRoute(
      path: RouteConstants.NAVIGATION,
      name: RouteConstants.NAVIGATION,
      builder: (context, state) => const NavigationPage(),
    ),
  ],

  errorBuilder: (context, state) => Scaffold(
    body: Center(child: Text('Sayfa bulunamadı: ${state.matchedLocation}')),
  ),
);
