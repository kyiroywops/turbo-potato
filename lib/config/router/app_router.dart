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
      pageBuilder: (context, state) {
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: InicialHomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },  
    ),
    GoRoute(
      path: '/playerselection',
      pageBuilder: (context, state) {
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: PlayerSelectionScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(CurveTween(curve: Curves.easeInOut));
            return SlideTransition(position: animation.drive(tween), child: child);
          },
        );
      },
    
    ),
    GoRoute(
      path: '/games',
      pageBuilder: (context, state) {
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: GamesScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(CurveTween(curve: Curves.easeInOut));
            return SlideTransition(position: animation.drive(tween), child: child);
          },
        );
      },
    
    ),
     GoRoute(
      path: '/instructions',
      pageBuilder: (context, state) {
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: InstructionsScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(CurveTween(curve: Curves.easeInOut));
            return SlideTransition(position: animation.drive(tween), child: child);
          },
        );
      },
    
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
