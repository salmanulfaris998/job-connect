import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jobconnect/app/constants/app_strings.dart';
import 'package:jobconnect/app/theme/colors.dart';
import 'package:jobconnect/app/theme/spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobconnect/core/models/job_card_model.dart';
import 'package:jobconnect/core/providers/bottom_nav_visibility_provider.dart';
import 'package:jobconnect/core/widgets/custom_app_bar.dart';
import 'package:jobconnect/core/widgets/custom_button.dart';
import 'package:jobconnect/features/job/providers/job_detail_provider.dart';

class JobDetailArgs {
  final JobCardModel job;

  const JobDetailArgs({required this.job});
}

class JobDetailScreen extends ConsumerStatefulWidget {
  const JobDetailScreen({super.key, required this.args});

  final JobDetailArgs args;

  @override
  ConsumerState<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends ConsumerState<JobDetailScreen>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bottomNavVisibilityProvider.notifier).hide();
      ref
          .read(jobDetailProvider.notifier)
          .initialize(widget.args.job);
    });
  }

  @override
  void dispose() {
    ref.read(bottomNavVisibilityProvider.notifier).show();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final secondaryTextColor =
        isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText;
    final detailState = ref.watch(jobDetailProvider);
    final job = detailState?.job ?? widget.args.job;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        showBack: true,
        title: job.title,
        actions: [
          IconButton(
            onPressed: () =>
                ref.read(jobDetailProvider.notifier).toggleWishlist(),
            icon: Icon(
              detailState?.isSaved == true ? Iconsax.heart5 : Iconsax.heart,
            ),
            color: detailState?.isSaved == true
                ? AppColors.danger
                : AppColors.darkSecondaryText,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          bottom: AppSpacing.xl * 2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _JobDetailHeaderImage(imageUrl: job.imageUrl),
            const SizedBox(height: AppSpacing.lg),
            JobDetailTitleSection(job: job),
            const SizedBox(height: AppSpacing.md),
            JobDetailPosterInfo(
              secondaryTextColor: secondaryTextColor,
              postedDate: '12 Nov 2025',
              posterName: 'Rahul Kumar',
            ),
            const SizedBox(height: AppSpacing.lg),
            JobDetailInfoCard(
              secondaryTextColor: secondaryTextColor,
              job: job,
            ),
            const SizedBox(height: AppSpacing.xl),
            const JobDetailActionSection(),
          ],
        ),
      ),
    );
  }
}

class _JobDetailHeaderImage extends StatelessWidget {
  const _JobDetailHeaderImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius + 6),
      child: Image.network(
        imageUrl,
        height: 220,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}

class JobDetailTitleSection extends StatelessWidget {
  const JobDetailTitleSection({super.key, required this.job});

  final JobCardModel job;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            job.title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            job.price,
            style: theme.textTheme.titleMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              const Icon(Iconsax.location, size: 16),
              const SizedBox(width: AppSpacing.xs),
              Text(
                job.location,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class JobDetailPosterInfo extends StatelessWidget {
  const JobDetailPosterInfo({
    super.key,
    required this.secondaryTextColor,
    required this.posterName,
    required this.postedDate,
  });

  final Color secondaryTextColor;
  final String posterName;
  final String postedDate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(
          color: AppColors.primary
              .withOpacity(theme.brightness == Brightness.dark ? 0.18 : 0.28),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary
                .withOpacity(theme.brightness == Brightness.dark ? 0.10 : 0.20),
            blurRadius: theme.brightness == Brightness.dark ? 5 : 20,
            spreadRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radius),
            child: Image.network(
              'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=80',
              height: 48,
              width: 48,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                posterName,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.xs / 2),
              Text(
                'Posted on $postedDate',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: secondaryTextColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class JobDetailInfoCard extends StatelessWidget {
  const JobDetailInfoCard({
    super.key,
    required this.secondaryTextColor,
    required this.job,
  });

  final Color secondaryTextColor;
  final JobCardModel job;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(
          color: AppColors.primary
              .withOpacity(theme.brightness == Brightness.dark ? 0.18 : 0.28),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary
                .withOpacity(theme.brightness == Brightness.dark ? 0.10 : 0.20),
            blurRadius: theme.brightness == Brightness.dark ? 5 : 20,
            spreadRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoGrid(job: job),
          const SizedBox(height: AppSpacing.xs / 100),
          Divider(color: secondaryTextColor.withOpacity(0.2), thickness: 0.6),
          const SizedBox(height: AppSpacing.md),
          Text(
            AppStrings.jobDetailDescriptionLabel,
            style: theme.textTheme.bodySmall?.copyWith(
              color: secondaryTextColor,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            AppStrings.jobDetailDescriptionSample,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoGrid extends StatelessWidget {
  const _InfoGrid({required this.job});

  final JobCardModel job;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: 3.2,
      crossAxisSpacing: AppSpacing.md,
      mainAxisSpacing: AppSpacing.sm,
      children: [
        _InfoItem(label: 'Category', value: job.category),
        const _InfoItem(label: 'Duration', value: '2 days'),
        const _InfoItem(label: 'Requirements', value: 'Basic tools required'),
        const _InfoItem(label: 'Applicants', value: '5'),
      ],
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final labelColor =
        isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: labelColor,
          ),
        ),
        const SizedBox(height: AppSpacing.xs / 2),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class JobDetailActionSection extends StatefulWidget {
  const JobDetailActionSection({super.key});

  @override
  State<JobDetailActionSection> createState() => _JobDetailActionSectionState();
}

class _JobDetailActionSectionState extends State<JobDetailActionSection> {
  bool agreed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(
          color: AppColors.primary
              .withOpacity(theme.brightness == Brightness.dark ? 0.18 : 0.28),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary
                .withOpacity(theme.brightness == Brightness.dark ? 0.10 : 0.20),
            blurRadius: theme.brightness == Brightness.dark ? 5 : 20,
            spreadRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: agreed,
                onChanged: (value) => setState(() => agreed = value ?? false),
                activeColor: AppColors.primary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  AppStrings.jobDetailAgreementNotice,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withOpacity(0.75),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          CustomButton(
            label: AppStrings.jobDetailApplyButton,
            height: 56,
            onPressed: agreed
                ? () => context.push('/login')
                : null,
            isDisabled: !agreed,
          ),
        ],
      ),
    );
  }
}
