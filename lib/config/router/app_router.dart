import 'package:culturach/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
        builder: (BuildContext context, GoRouterState state) => PlayerSelectionScreen(),
        


    ),


  ]




);
