import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'routes/app_router.dart'; // ✅ this is your router file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: MaterialApp.router(
                title: 'Solar Monitor',
                debugShowCheckedModeBanner: false,
                routerConfig: AppRouter.router,
                theme: ThemeData(
                  primaryColor: const Color(0xFF4CAF50),
                  scaffoldBackgroundColor: const Color(0xFF1E3D59),
                  textTheme: GoogleFonts.poppinsTextTheme(
                    Theme.of(context).textTheme,
                  ),
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: const Color(0xFF4CAF50),
                    brightness: Brightness.dark,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
