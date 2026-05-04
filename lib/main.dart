
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/class_list_screen.dart';
import 'package:myapp/screens/history_screen.dart';
import 'package:myapp/screens/login_screen.dart';
import 'package:myapp/providers/room_provider.dart';
import 'package:myapp/screens/room_detail_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RoomProvider(),
      child: const MyApp(),
    ),
  );
}

final GoRouter _router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/class_list',
      builder: (context, state) => const ClassListScreen(),
    ),
    GoRoute(
      path: '/history',
      builder: (context, state) => const HistoryScreen(),
    ),
    GoRoute(
      path: '/room/:roomId',
      builder: (context, state) {
        final roomId = state.pathParameters['roomId']!;
        return RoomDetailScreen(roomId: roomId);
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primarySeedColor = Colors.blue;

    final TextTheme appTextTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);

    final ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primarySeedColor,
        brightness: Brightness.light,
      ),
      textTheme: appTextTheme,
    );

    final ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primarySeedColor,
        brightness: Brightness.dark,
      ),
      textTheme: appTextTheme,
    );

    return MaterialApp.router(
      title: 'Booking Ruangan',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system, // Default to system theme
      routerConfig: _router,
    );
  }
}
