//import 'dart:js';
//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repro/models/playlist_provider.dart';
import 'package:repro/theme/light_mode.dart';
import 'package:repro/theme/theme_provider.dart';
import 'pages/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => PlaylistProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
