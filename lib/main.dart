import 'package:culturach/config/router/app_router.dart';
import 'package:culturach/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
     title: 'x',
     debugShowCheckedModeBanner: false,
     routerConfig: appRouter,
     theme: AppTheme().themeData,
    );
  }
}
