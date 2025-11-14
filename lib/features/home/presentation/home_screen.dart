import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jobconnect/app/constants/app_strings.dart';
import 'package:jobconnect/app/theme/spacing.dart';
import 'package:jobconnect/app/theme/colors.dart';
import 'package:jobconnect/core/models/job_card_model.dart';
import 'package:jobconnect/core/widgets/custom_app_bar.dart';
import 'package:jobconnect/core/widgets/custom_search_field.dart';
import 'package:jobconnect/features/home/presentation/widgets/job_card.dart';
import 'package:jobconnect/features/home/presentation/widgets/home_category_filter.dart';
import 'package:jobconnect/features/home/providers/category_filter_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:jobconnect/features/notifications/providers/notifications_provider.dart';
import 'package:jobconnect/features/wishlist/providers/wishlist_provider.dart';

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

    const jobs = <JobCardModel>[
      JobCardModel(
        imageUrl:
            'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80',
        price: '₹800/day',
        title: 'Painter Needed',
        location: 'Vallapuzha',
        category: 'Skilled',
      ),
      JobCardModel(
        imageUrl:
            'https://images.unsplash.com/photo-1505691938895-1758d7feb511?auto=format&fit=crop&w=800&q=80',
        price: '₹1200/project',
        title: 'Garden Cleanup',
        location: 'Pattambi',
        category: 'Unskilled',
      ),
      JobCardModel(
        imageUrl:
            'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80',
        price: '₹500/hr',
        title: 'House Cleaner',
        location: 'Koppam',
        category: 'Part-time',
      ),
      JobCardModel(
        imageUrl:
            'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80',
        price: '₹1500/day',
        title: 'Delivery Driver',
        location: 'Shoranur',
        category: 'Nearby',
      ),
      JobCardModel(
        imageUrl:
            'https://images.unsplash.com/photo-1526336024174-e58f5cdd8e13?auto=format&fit=crop&w=800&q=80',
        price: '₹700/day',
        title: 'Event Helper',
        location: 'Ottapalam',
        category: 'Nearby',
      ),
      JobCardModel(
        imageUrl:
            'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?auto=format&fit=crop&w=800&q=80',
        price: '₹900/day',
        title: 'Tutor Needed',
        location: 'Cherpulassery',
        category: 'Skilled',
      ),
    ];

    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final gridItemWidth =
        (size.width - (AppSpacing.lg * 2) - AppSpacing.md) / 2;
    final imageHeight = gridItemWidth / 1.2; // AspectRatio 1.2 (w/h)
    final double mainExtent =
        (imageHeight + 100).ceilToDouble(); // image + text area

    final selectedIndex = ref.watch(categoryFilterProvider);
    final selectedCategory = filters[selectedIndex];
    final filteredJobs = selectedCategory.toLowerCase().contains('see')
        ? jobs
        : jobs
            .where((j) =>
                j.category.toLowerCase() == selectedCategory.toLowerCase())
            .toList();

    final notifCount = ref.watch(notificationCountProvider);
    final badgeText = notifCount > 9 ? '9+' : '$notifCount';

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
                  onPressed: () => context.push('/notifications'),
                  icon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(Iconsax.notification, size: 22),
                      if (notifCount > 0)
                        Positioned(
                          right: -2,
                          top: -2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                            decoration: BoxDecoration(
                              color: AppColors.danger,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                            child: Center(
                              child: Text(
                                badgeText,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => context.push('/wishlist'),
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
            sliver: SliverGrid.builder(
              itemCount: filteredJobs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppSpacing.md,
                mainAxisSpacing: AppSpacing.md,
                mainAxisExtent: mainExtent,
              ),
              itemBuilder: (context, index) {
                final job = filteredJobs[index];
                final saved = ref.watch(wishlistContainsProvider(job));
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
