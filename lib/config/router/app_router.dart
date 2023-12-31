import 'package:culturach/presentation/screens/category_screen.dart';
import 'package:culturach/presentation/screens/games_screen.dart';
import 'package:culturach/presentation/screens/home_screen.dart';
import 'package:culturach/presentation/screens/inicial_home_screen.dart';
import 'package:culturach/presentation/screens/introductions_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
        builder: (BuildContext context, GoRouterState state) => InicialHomeScreen(),
        


    ),
    GoRoute(
      path: '/playerselection',
        builder: (BuildContext context, GoRouterState state) => PlayerSelectionScreen(),
        


    ),
     GoRoute(
      path: '/games',
        builder: (BuildContext context, GoRouterState state) => GamesScreen(),
      
        


    ),
     GoRoute(
      path: '/instructions',
        builder: (BuildContext context, GoRouterState state) => InstructionsScreen(),
      
        


    ),

    GoRoute(
      path: '/questions',
      builder: (BuildContext context, GoRouterState state) {
        // Obtenemos la categoría pasada como parámetro extra.
        final category = state.extra as String;
        // Luego, pasamos esta categoría a la pantalla correspondiente.
        return QuestionsScreen(category: category);
      },
    ),


  ]




);
