import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jobconnect/app/theme/colors.dart';
import 'package:jobconnect/core/models/job_card_model.dart';

class JobCard extends StatelessWidget {
  final JobCardModel job;
  final VoidCallback? onTap;
  final VoidCallback? onSave;
  final bool? saved;

  const JobCard({
    super.key,
    required this.job,
    this.onTap,
    this.onSave,
    this.saved,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = theme.cardColor;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final textColorPrimary = isDark ? AppColors.darkText : AppColors.lightText;
    final textColorSecondary =
        isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText;
    final savedState = saved ?? job.isSaved;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: borderColor, width: 0.8),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(isDark ? 0.10 : 0.20),
              blurRadius: isDark ? 5 : 20,
              spreadRadius: 1,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE SECTION
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1.2,
                    child: CachedNetworkImage(
                      imageUrl: job.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                          border: Border.all(
                            color: cardColor,
                            width: 8,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ❤️ Save Button
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: onSave,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withOpacity(0.12)
                              : Colors.black.withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          savedState ? Icons.favorite : Icons.favorite_border,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // TEXT SECTION
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 4),
              child: Text(
                job.price,
                style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: textColorPrimary,
                      fontSize: 18,
                    ) ??
                    TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: textColorPrimary,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                job.title,
                style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: textColorPrimary,
                    ) ??
                    TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: textColorPrimary,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(height: 2),

            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 12),
              child: Text(
                job.location,
                style: theme.textTheme.bodyMedium?.copyWith(
                      color: textColorSecondary,
                      fontSize: 13,
                    ) ??
                    TextStyle(
                      fontSize: 13,
                      color: textColorSecondary,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
