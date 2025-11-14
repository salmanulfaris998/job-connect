import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jobconnect/app/theme/colors.dart';
import 'package:jobconnect/app/theme/spacing.dart';
import 'package:jobconnect/features/notifications/providers/notifications_provider.dart';
import 'package:jobconnect/core/widgets/custom_app_bar.dart';
import 'package:jobconnect/app/constants/app_strings.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  String _formatSince(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final items = ref.watch(notificationsProvider);
    final notifier = ref.read(notificationsProvider.notifier);

    return Scaffold(
      appBar: CustomAppBar(
        showBack: true,
        centerTitle: true,
        title: AppStrings.notificationsTitle,
        actions: [
          if (items.isNotEmpty)
            TextButton(
              onPressed: notifier.clearAll,
              child: Text(
                AppStrings.notificationsClearAll,
                style: TextStyle(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: items.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Iconsax.notification,
                    size: 56,
                    color: theme.brightness == Brightness.dark
                        ? AppColors.darkSecondaryText
                        : AppColors.lightSecondaryText,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const SizedBox(height: AppSpacing.sm),
                  const SizedBox(height: 6),
                  Text(
                    AppStrings.notificationsEmptyTitle,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    AppStrings.notificationsEmptySubtitle,
                    style: TextStyle(
                      color: theme.brightness == Brightness.dark
                          ? AppColors.darkSecondaryText
                          : AppColors.lightSecondaryText,
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                final n = items[index];
                return Dismissible(
                  key: ValueKey(n.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    decoration: BoxDecoration(
                      color: AppColors.danger.withOpacity(0.13),
                      borderRadius: BorderRadius.circular(AppSpacing.radius),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    alignment: Alignment.centerRight,
                    child: const Icon(Iconsax.trash, color: AppColors.danger),
                  ),
                  onDismissed: (_) => notifier.removeById(n.id),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(AppSpacing.radius),
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.darkBorder
                            : AppColors.lightBorder,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(
                              Theme.of(context).brightness == Brightness.dark ? 0.10 : 0.20),
                          blurRadius: Theme.of(context).brightness == Brightness.dark ? 5 : 20,
                          spreadRadius: 1,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      leading: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                        child: const Icon(Iconsax.notification, color: Colors.white, size: 20),
                      ),
                      title: Text(
                        n.title,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(
                        n.body,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? AppColors.darkSecondaryText
                                  : AppColors.lightSecondaryText,
                            ),
                      ),
                      trailing: Text(
                        _formatSince(n.timestamp),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
