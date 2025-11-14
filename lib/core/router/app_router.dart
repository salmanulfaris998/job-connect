import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jobconnect/features/auth/presentation/onboarding_screen.dart';
import 'package:jobconnect/features/auth/presentation/splash_screen.dart';
import 'package:jobconnect/features/chat/presentation/chat_list_screen.dart';
import 'package:jobconnect/features/home/presentation/home_screen.dart';
import 'package:jobconnect/features/job/presentation/my_jobs_screen.dart';
import 'package:jobconnect/features/profile/presentation/profile_screen.dart';
import 'package:jobconnect/features/notifications/presentation/notification_screen.dart';
import 'package:jobconnect/features/wishlist/presentation/wishlist_screen.dart';
import 'package:jobconnect/features/home/presentation/all_categories_screen.dart';

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
            path: '/categories',
            name: 'categories',
            builder: (context, state) => const AllCategoriesScreen(),
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
