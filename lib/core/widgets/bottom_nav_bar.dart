import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jobconnect/app/theme/colors.dart';
import 'package:jobconnect/core/providers/bottom_nav_visibility_provider.dart';

class BottomNavShell extends ConsumerWidget {
  const BottomNavShell({
    super.key,
    required this.child,
    required this.location,
    this.unreadCount = 5,
  });

  final Widget child;
  final String location;
  final int unreadCount;

  static const items = <_NavItem>[
    _NavItem(Iconsax.home, 'Home', '/home'),
    _NavItem(Iconsax.message, 'Chats', '/chats'),
    _NavItem(Iconsax.briefcase, 'My Jobs', '/jobs'),
    _NavItem(Iconsax.user, 'Account', '/account'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = items.indexWhere(
      (e) => location == e.route || location.startsWith('${e.route}/'),
    );
    final showNavBar = ref.watch(bottomNavVisibilityProvider);

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          child,
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: IgnorePointer(
              ignoring: !showNavBar,
              child: AnimatedSlide(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeInOut,
                offset: showNavBar ? Offset.zero : const Offset(0, 1.1),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: showNavBar ? 1.0 : 0.0,
                  child: _FloatingNavBar(
                    currentIndex: index >= 0 ? index : 0,
                    unread: unreadCount,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingNavBar extends StatelessWidget {
  const _FloatingNavBar({
    required this.currentIndex,
    required this.unread,
  });

  final int currentIndex;
  final int unread;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Container(
        height: 80,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
              color: AppColors.primary.withOpacity(isDark ? 0.6 : 0.6),
              width: 1),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(isDark ? 0.35 : 0.35),
              blurRadius: isDark ? 13 : 11,
              spreadRadius: 1,
              offset: const Offset(0, 0),
            ),
            if (!isDark)
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavButton(
                item: BottomNavShell.items[0],
                index: 0,
                current: currentIndex,
                unread: 0),
            _NavButton(
                item: BottomNavShell.items[1],
                index: 1,
                current: currentIndex,
                unread: unread), // 👈 badge here
            _NavButton(
                item: BottomNavShell.items[2],
                index: 2,
                current: currentIndex,
                unread: 0),
            _NavButton(
                item: BottomNavShell.items[3],
                index: 3,
                current: currentIndex,
                unread: 0),
          ],
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.item,
    required this.index,
    required this.current,
    required this.unread,
  });

  final _NavItem item;
  final int index;
  final int current;
  final int unread;

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF0066FF);
    final bool active = current == index;

    return GestureDetector(
      onTap: () => context.go(item.route),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: EdgeInsets.symmetric(
              horizontal: active ? 18 : 14,
              vertical: 10,
            ),
            decoration: active
                ? BoxDecoration(
                    color: primaryBlue,
                    borderRadius: BorderRadius.circular(30),
                  )
                : null,
            child: Row(
              children: [
                Icon(
                  item.icon,
                  size: 23,
                  color: active ? Colors.white : Colors.grey.shade500,
                ),
                if (active) ...[
                  const SizedBox(width: 6),
                  Text(
                    item.label,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ],
            ),
          ),

          /// 🔴 UNREAD BADGE (Only for Chats)
          if (unread > 0)
            Positioned(
              right: active ? -4 : -6,
              top: -4,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.red.shade600,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: active ? primaryBlue : Colors.white,
                    width: 1,
                  ),
                ),
                child: Text(
                  unread.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final String route;
  const _NavItem(this.icon, this.label, this.route);
}
