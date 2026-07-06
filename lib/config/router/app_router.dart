
import 'package:book_appointment/presentation/screens/appointment/home_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/', 
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    )
  ]
);