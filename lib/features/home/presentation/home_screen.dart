import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jobconnect/app/constants/app_strings.dart';
import 'package:jobconnect/app/theme/spacing.dart';
import 'package:jobconnect/app/theme/colors.dart';
import 'package:jobconnect/core/models/job_card_model.dart';
import 'package:jobconnect/core/widgets/custom_app_bar.dart';
import 'package:jobconnect/core/widgets/custom_search_field.dart';
import 'package:jobconnect/core/providers/bottom_nav_visibility_provider.dart';
import 'package:jobconnect/features/home/presentation/widgets/job_card.dart';
import 'package:jobconnect/features/home/presentation/widgets/home_category_filter.dart';
import 'package:jobconnect/features/home/providers/category_filter_provider.dart';
import 'package:jobconnect/features/job/presentation/category_jobs_screen.dart';
import 'package:jobconnect/features/job/presentation/job_detail_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:jobconnect/features/notifications/providers/notifications_provider.dart';
import 'package:jobconnect/features/wishlist/providers/wishlist_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _navVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bottomNavVisibilityProvider.notifier).show();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    ref.read(bottomNavVisibilityProvider.notifier).show();
    super.dispose();
  }

  void _handleScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    final direction = position.userScrollDirection;
    final canScroll = position.maxScrollExtent > 0;

    if (!canScroll) {
      if (!_navVisible) {
        _navVisible = true;
        ref.read(bottomNavVisibilityProvider.notifier).show();
      }
      return;
    }

    if (direction == ScrollDirection.reverse && _navVisible) {
      _navVisible = false;
      ref.read(bottomNavVisibilityProvider.notifier).hide();
    } else if (direction == ScrollDirection.forward && !_navVisible) {
      _navVisible = true;
      ref.read(bottomNavVisibilityProvider.notifier).show();
    } else if (position.atEdge &&
        position.pixels <= 0 &&
        !_navVisible) {
      _navVisible = true;
      ref.read(bottomNavVisibilityProvider.notifier).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    const filters = <String>[
      'Nearby',
      'Skilled',
      'Unskilled',
      'Part-time',
      'See all',
    ];

    const seeAllCategories = <_SeeAllCategory>[
      _SeeAllCategory('Skilled', Icons.miscellaneous_services, 'Skilled\nWork', Color(0xFF2B4A8A)),
      _SeeAllCategory('Unskilled', Icons.agriculture, 'Unskilled\nWork', Color(0xFF1E6B34)),
      _SeeAllCategory('Home Services', Icons.home_repair_service, 'Home\nServices', Color(0xFF6F2CA7)),
      _SeeAllCategory('Cooking', Icons.restaurant, 'Cooking', Color(0xFF9E3D1C)),
      _SeeAllCategory('Delivery', Icons.local_shipping, 'Delivery /\nDriving', Color(0xFF0E5078)),
      _SeeAllCategory('Construction', Icons.construction, 'Construction', Color(0xFF8E1F1B)),
      _SeeAllCategory('Tutoring', Icons.school, 'Tutoring', Color(0xFF0A7373)),
      _SeeAllCategory('Tech', Icons.devices_other, 'Tech /\nComputer Services', Color(0xFF1D3AA9)),
      _SeeAllCategory('Tailoring', Icons.cut, 'Tailoring', Color(0xFF8E1A3B)),
      _SeeAllCategory('Electrical', Icons.plumbing, 'Electrical /\nPlumbing', Color(0xFF6C4A1C)),
      _SeeAllCategory('Babysitting', Icons.child_care, 'Babysitting', Color(0xFF11698E)),
      _SeeAllCategory('Housekeeping', Icons.local_laundry_service, 'Housekeeping', Color(0xFF54751A)),
      _SeeAllCategory('Translation', Icons.language, 'Translation /\nData', Color(0xFF2B2F44)),
      _SeeAllCategory('Event & Wedding Work', Icons.celebration, 'Event &\nWedding Work', Color(0xFFB83280)),
      _SeeAllCategory('Farming', Icons.agriculture_outlined, 'Farming /\nAgricultural Work', Color(0xFF2E7D32)),
      _SeeAllCategory('Beauty & Grooming', Icons.brush, 'Beauty &\nGrooming', Color(0xFFAA3A6A)),
      _SeeAllCategory('Pet Care', Icons.pets, 'Pet Care', Color(0xFF3E6BA0)),
      _SeeAllCategory('Freelance', Icons.computer, 'Freelance /\nOnline', Color(0xFF232D94)),
      _SeeAllCategory('Sales', Icons.shopping_bag, 'Salesman /\nShop Helper /\nStore Staff', Color(0xFF8C4F07)),
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
    final showCategories = selectedCategory.toLowerCase().contains('see');
    final filteredJobs = showCategories
        ? jobs
        : jobs
            .where((j) =>
                j.category.toLowerCase() == selectedCategory.toLowerCase())
            .toList();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (!_scrollController.hasClients) return;
      final canScroll = _scrollController.position.maxScrollExtent > 0;
      if (!canScroll && !_navVisible) {
        _navVisible = true;
        ref.read(bottomNavVisibilityProvider.notifier).show();
      }
    });

    final notifCount = ref.watch(notificationCountProvider);
    final badgeText = notifCount > 9 ? '9+' : '$notifCount';

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
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
          if (showCategories) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Text(
                  AppStrings.allCategoriesDescription,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.brightness == Brightness.dark
                        ? AppColors.darkSecondaryText
                        : AppColors.lightSecondaryText,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              sliver: SliverGrid.builder(
                itemCount: seeAllCategories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: AppSpacing.sm,
                  mainAxisSpacing: AppSpacing.md,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final item = seeAllCategories[index];
                  final baseColor = item.color;
                  final cardColor = theme.brightness == Brightness.dark
                      ? baseColor.withOpacity(0.92)
                      : baseColor.withOpacity(0.82);

                  return GestureDetector(
                    onTap: () {
                      context.push(
                        '/category',
                        extra: CategoryJobsArgs(category: item.categoryKey, jobs: jobs),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(AppSpacing.cardRadius + 8),
                        boxShadow: [
                          BoxShadow(
                            color: baseColor.withOpacity(0.28),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 46,
                            width: 46,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(
                                  theme.brightness == Brightness.dark ? 0.22 : 0.16),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              item.icon,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            item.displayTitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              height: 1.3,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ] else ...[
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
                    onTap: () => context.push(
                      '/job-detail',
                      extra: JobDetailArgs(job: job),
                    ),
                    onSave: () => ref.read(wishlistProvider.notifier).toggle(job),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SeeAllCategory {
  final String categoryKey;
  final IconData icon;
  final String displayTitle;
  final Color color;

  const _SeeAllCategory(this.categoryKey, this.icon, this.displayTitle, this.color);
}
