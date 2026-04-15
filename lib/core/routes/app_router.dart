import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/tenant_selector_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/students/presentation/pages/student_selector_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const TenantSelectorPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) {
        final tenantId = state.extra as String? ?? '';
        return LoginPage(tenantId: tenantId);
      },
    ),
    GoRoute(
      path: '/students',
      builder: (context, state) => const StudentSelectorPage(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardPage(),
    ),
  ],
);
