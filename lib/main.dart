import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/di/injection.dart';
import 'core/theme/app_theme.dart';
import 'features/ideas/presentation/pages/ideas_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  configureDependencies();
  
  runApp(const BrainstormApp());
}

class BrainstormApp extends StatelessWidget {
  const BrainstormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Idea Flow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: ThemeMode.system,
      home: const IdeasPage(),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final baseTheme = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorSchemeSeed: const Color(0xFF6200EE), 
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.outfitTextTheme(baseTheme.textTheme),
    );
  }
}