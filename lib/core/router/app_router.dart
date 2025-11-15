import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jobconnect/features/auth/presentation/login_screen.dart';
import 'package:jobconnect/features/auth/presentation/onboarding_screen.dart';
import 'package:jobconnect/features/auth/presentation/splash_screen.dart';
import 'package:jobconnect/features/chat/presentation/chat_list_screen.dart';
import 'package:jobconnect/features/home/presentation/home_screen.dart';
import 'package:jobconnect/features/job/presentation/my_jobs_screen.dart';
import 'package:jobconnect/features/job/presentation/job_detail_screen.dart';
import 'package:jobconnect/features/profile/presentation/profile_screen.dart';
import 'package:jobconnect/features/profile/presentation/complete_profile_screen.dart';
import 'package:jobconnect/features/notifications/presentation/notification_screen.dart';
import 'package:jobconnect/features/wishlist/presentation/wishlist_screen.dart';
import 'package:jobconnect/features/job/presentation/category_jobs_screen.dart';

import '../widgets/bottom_nav_bar.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const WelcomeBackLoginScreen(),
      ),
      GoRoute(
        path: '/complete-profile',
        name: 'complete-profile',
        builder: (context, state) => const CompleteProfileScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          final location = state.matchedLocation;
          return BottomNavShell(
            child: child,
            location: location,
          );
        },
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/notifications',
            name: 'notifications',
            builder: (context, state) => const NotificationScreen(),
          ),
          GoRoute(
            path: '/wishlist',
            name: 'wishlist',
            builder: (context, state) => const WishlistScreen(),
          ),
          GoRoute(
            path: '/category',
            name: 'category',
            builder: (context, state) {
              final args = state.extra as CategoryJobsArgs?;
              if (args == null) {
                return const Scaffold(
                  body: Center(child: Text('No category selected')),
                );
              }
              return CategoryJobsScreen(args: args);
            },
          ),
          GoRoute(
            path: '/job-detail',
            name: 'job-detail',
            builder: (context, state) {
              final args = state.extra as JobDetailArgs?;
              if (args == null) {
                return const Scaffold(
                  body: Center(child: Text('Job details unavailable')),
                );
              }
              return JobDetailScreen(args: args);
            },
          ),
          GoRoute(
            path: '/chats',
            name: 'chats',
            builder: (context, state) => const ChatListScreen(),
          ),
          GoRoute(
            path: '/jobs',
            name: 'jobs',
            builder: (context, state) => const MyJobsScreen(),
          ),
          GoRoute(
            path: '/account',
            name: 'account',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  );
});
