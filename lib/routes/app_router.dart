import 'package:go_router/go_router.dart';
import 'package:myapp/screens/calender_screen.dart';
import 'package:myapp/screens/solar_screen.dart';
import '../screens/welcome_screen.dart';
import '../screens/signin_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/home_screen.dart';
import '../screens/solar_data_screen.dart';
import '../screens/efficiency_screen.dart';
import '../screens/cleaning_screen.dart';
import '../screens/photo_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const WelcomeScreen()),
      GoRoute(
        path: '/calender',
        builder: (context, state) => const CalenderScreen(),
      ),
      GoRoute(
        path: '/signin',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/solar-data',
        builder: (context, state) => const SolarChartPage(),
      ),
      GoRoute(
        path: '/efficiency',
        builder: (context, state) => const EfficiencyScreen(),
      ),
      GoRoute(
        path: '/cleaning',
        builder: (context, state) => const CleaningScreen(),
      ),
      GoRoute(path: '/photo', builder: (context, state) => const PhotoScreen()),
    ],
  );
}
