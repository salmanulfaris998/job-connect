import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jobconnect/app/constants/app_strings.dart';
import 'package:jobconnect/app/theme/colors.dart';
import 'package:jobconnect/app/theme/spacing.dart';
import 'package:jobconnect/core/widgets/custom_app_bar.dart';
import 'package:jobconnect/core/widgets/custom_search_field.dart';
import 'package:jobconnect/features/home/presentation/widgets/home_category_filter.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const filters = <String>[
      'Nearby',
      'Skilled',
      'Unskilled',
      'Part-time',
      'See all',
    ];

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0,
            floating: true,
            snap: true,
            pinned: false,
            toolbarHeight: 0,
            collapsedHeight: 0,
            expandedHeight: 56,
            flexibleSpace: CustomAppBar(
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Iconsax.location, size: 20),
                  SizedBox(width: 6),
                  Text(
                    'Kerala',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              title: const SizedBox.shrink(),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Iconsax.notification, size: 22),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Iconsax.heart, size: 22),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: FractionallySizedBox(
                      widthFactor: 0.88,
                      child: CustomSearchField(
                        hintText: AppStrings.searchjob,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  HomeCategoryFilter(
                    categories: filters,
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            sliver: SliverList.builder(
              itemCount: 8,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                    bottom: index == 7 ? 0 : AppSpacing.md,
                  ),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.08),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Suggested Job #${index + 1}',
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Short description about this opportunity goes here to demonstrate scrolling content.',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
