import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_providers.dart';
import 'providers/favorite_providers.dart';
import 'providers/theme_provider.dart';
import 'screens/profile_screens.dart';

void main() {
  runApp(
    // MultiProvider dipasang paling atas supaya semua layar di bawahnya bisa mengakses data
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ), // Tantangan latihan mandiri
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Mendengarkan perubahan tema (Dark/Light Mode) dari ThemeProvider menggunakan watch
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      title: 'Wisata Candi',
      debugShowCheckedModeBanner: false,

      // Integrasi tantangan ThemeMode berdasarkan materi
      themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,

      // Tema Terang (Light Theme bawaan Anda)
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.deepPurple),
          titleTextStyle: TextStyle(
            color: Colors.deepPurple,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ).copyWith(primary: Colors.deepPurple, surface: Colors.deepPurple[50]),
        useMaterial3: true,
      ),

      // Tema Gelap (Dark Theme) untuk tantangan latihan mandiri
      darkTheme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.deepPurpleAccent),
          titleTextStyle: TextStyle(
            color: Colors.deepPurpleAccent,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      home: const ProfileScreen(),
    );
    }
}
