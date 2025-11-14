import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jobconnect/app/theme/colors.dart';
import 'package:jobconnect/app/theme/spacing.dart';
import 'package:jobconnect/core/widgets/custom_app_bar.dart';
import 'package:jobconnect/features/home/presentation/widgets/job_card.dart';
import 'package:jobconnect/features/wishlist/providers/wishlist_provider.dart';
import 'package:jobconnect/app/constants/app_strings.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final items = ref.watch(wishlistProvider);
    final notifier = ref.read(wishlistProvider.notifier);

    final size = MediaQuery.of(context).size;
    final gridItemWidth = (size.width - (AppSpacing.lg * 2) - AppSpacing.md) / 2;
    final imageHeight = gridItemWidth / 1.2; // AspectRatio 1.2 (w/h)
    final double mainExtent = (imageHeight + 100).ceilToDouble(); // image + text area

    return Scaffold(
      appBar: CustomAppBar(
        showBack: true,
        centerTitle: true,
        title: AppStrings.wishlistTitle,
        actions: [
          if (items.isNotEmpty)
            TextButton(
              onPressed: notifier.clear,
              child: Text(
                AppStrings.wishlistClearAll,
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
                    Iconsax.heart,
                    size: 56,
                    color: theme.brightness == Brightness.dark
                        ? AppColors.darkSecondaryText
                        : AppColors.lightSecondaryText,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const Text(
                    AppStrings.wishlistEmptyTitle,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    AppStrings.wishlistEmptySubtitle,
                    style: TextStyle(
                      color: theme.brightness == Brightness.dark
                          ? AppColors.darkSecondaryText
                          : AppColors.lightSecondaryText,
                    ),
                  ),
                ],
              ),
            )
          : CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.md,
                  ),
                  sliver: SliverGrid.builder(
                    itemCount: items.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppSpacing.md,
                      mainAxisSpacing: AppSpacing.md,
                      mainAxisExtent: mainExtent,
                    ),
                    itemBuilder: (context, index) {
                      final job = items[index];
                      final saved = true; // Items here are saved
                      return JobCard(
                        job: job,
                        saved: saved,
                        onSave: () => ref.read(wishlistProvider.notifier).toggle(job),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
