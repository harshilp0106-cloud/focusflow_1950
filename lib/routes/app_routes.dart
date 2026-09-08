import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/focus_session_screen/focus_session_screen.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/insights_screen/insights_screen.dart';
import '../presentation/live_session_timer_screen/live_session_timer_screen.dart';
import '../presentation/onboarding_screen/onboarding_screen.dart';
import '../presentation/rules_screen/rules_screen.dart';
import '../presentation/settings_screen/settings_screen.dart';
import '../widgets/app_scaffold.dart';

class AppRoutes {
  static const String initial = '/';
  static const String onboardingScreen = '/onboarding-screen';
  static const String homeScreen = '/home-screen';
  static const String focusSessionScreen = '/focus-session-screen';
  static const String liveSessionTimerScreen = '/live-session-timer-screen';
  static const String insightsScreen = '/insights-screen';
  static const String rulesScreen = '/rules-screen';
  static const String settingsScreen = '/settings-screen';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.initial,
  routes: [
    GoRoute(
      path: AppRoutes.initial,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const OnboardingScreen(),
        transitionDuration: const Duration(milliseconds: 280),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: AppRoutes.onboardingScreen,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const OnboardingScreen(),
        transitionDuration: const Duration(milliseconds: 280),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              ),
              child: child,
            ),
      ),
    ),
    GoRoute(
      path: AppRoutes.liveSessionTimerScreen,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: LiveSessionTimerScreen(
          sessionType: state.extra != null
              ? (state.extra as Map<String, dynamic>)['sessionType'] as String
              : 'Deep Work',
          durationMinutes: state.extra != null
              ? (state.extra as Map<String, dynamic>)['duration'] as int
              : 25,
        ),
        transitionDuration: const Duration(milliseconds: 350),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(0, 0.04),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ),
                ),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
      ),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppScaffold(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.homeScreen,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: HomeScreen()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.focusSessionScreen,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: FocusSessionScreen()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.insightsScreen,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: InsightsScreen()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.rulesScreen,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: RulesScreen()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.settingsScreen,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: SettingsScreen()),
            ),
          ],
        ),
      ],
    ),
  ],
);
