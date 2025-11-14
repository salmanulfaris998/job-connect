import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobconnect/app/theme/spacing.dart';
import 'package:jobconnect/app/theme/colors.dart';
import 'package:jobconnect/core/models/job_card_model.dart';
import 'package:jobconnect/core/widgets/custom_app_bar.dart';
import 'package:jobconnect/features/home/presentation/widgets/job_card.dart';
import 'package:jobconnect/features/wishlist/providers/wishlist_provider.dart';

class CategoryJobsArgs {
  final String category;
  final List<JobCardModel> jobs;

  const CategoryJobsArgs({required this.category, required this.jobs});
}

class CategoryJobsScreen extends ConsumerWidget {
  const CategoryJobsScreen({super.key, required this.args});

  final CategoryJobsArgs args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final gridItemWidth = (size.width - (AppSpacing.lg * 2) - AppSpacing.md) / 2;
    final imageHeight = gridItemWidth / 1.2;
    final double mainExtent = (imageHeight + 100).ceilToDouble();

    final filteredJobs = args.jobs
        .where((job) => job.category.toLowerCase() == args.category.toLowerCase())
        .toList();

    final subtitleColor =
        theme.brightness == Brightness.dark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        showBack: true,
        centerTitle: true,
        title: args.category,
      ),
      body: filteredJobs.isEmpty
          ? Center(
              child: Text(
                'No jobs available for ${args.category}',
                style: theme.textTheme.bodyMedium?.copyWith(color: subtitleColor),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
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
    );
  }
}
