import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobconnect/app/theme/colors.dart';
import 'package:jobconnect/app/theme/spacing.dart';
import 'package:jobconnect/features/home/providers/category_filter_provider.dart';
import 'package:go_router/go_router.dart';

class HomeCategoryFilter extends ConsumerWidget {
  final List<String> categories;
  final EdgeInsetsGeometry padding;

  const HomeCategoryFilter({
    super.key,
    required this.categories,
    this.padding = const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(categoryFilterProvider);
    final notifier = ref.read(categoryFilterProvider.notifier);

    final filterColors = Theme.of(context).extension<FilterChipColors>() ??
        const FilterChipColors(
          activeBackground: AppColors.primary,
          inactiveBackground: AppColors.darkFilterChip,
          inactiveText: Colors.white70,
          activeText: Colors.white,
        );

    return SizedBox(
      height: 45,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: padding,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final bool active = index == selectedIndex;

          return GestureDetector(
            onTap: () {
              notifier.select(index);

              // If See All is clicked → navigate or open modal
              if (categories[index].toLowerCase().contains("see")) {
                context.push('/categories');
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: active
                    ? filterColors.activeBackground
                    : filterColors.inactiveBackground,
                borderRadius: BorderRadius.circular(60),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: active
                      ? filterColors.activeText
                      : filterColors.inactiveText,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
