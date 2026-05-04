
import 'package:go_router/go_router.dart';
import 'package:myapp/screens/booking_history_screen.dart';
import 'package:myapp/screens/class_list_screen.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/login_screen.dart';

final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/class_list',
      builder: (context, state) => const ClassListScreen(),
    ),
    GoRoute(
      path: '/booking_history',
      builder: (context, state) => const BookingHistoryScreen(),
    ),
  ],
);
