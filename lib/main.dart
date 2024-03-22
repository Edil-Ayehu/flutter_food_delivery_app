
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/auth/login_or_register.dart';
import 'package:flutter_food_delivery_app/models/restaurant.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'themes/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // theme provider
        ChangeNotifierProvider(create: (context) => ThemeProvider()),

        // theme provider
        ChangeNotifierProvider(create: (context) => Restaurant())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const LoginOrRegister(),
    );
  }
}
