import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/dashboard/presentation/pages/video_player_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/students/presentation/pages/student_selector_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // ── Auth flow ─────────────────────────────────────────────────────────
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),

    // ── Main app shell (bottom nav) ───────────────────────────────────────
    GoRoute(
      path: '/home',
      builder: (context, state) => const DashboardPage(),
    ),
    GoRoute(
      path: '/dashboard', // legacy compat
      redirect: (_, __) => '/home',
    ),

    // ── Sub-pages ─────────────────────────────────────────────────────────
    GoRoute(
      path: '/video',
      builder: (context, state) => const VideoPlayerPage(),
    ),
    GoRoute(
      path: '/students',
      builder: (context, state) => const StudentSelectorPage(),
    ),
  ],
);
