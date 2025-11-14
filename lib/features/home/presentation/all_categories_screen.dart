import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jobconnect/app/constants/app_strings.dart';
import 'package:jobconnect/app/theme/colors.dart';
import 'package:jobconnect/app/theme/spacing.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  static const _categories = <_CategoryItem>[
    _CategoryItem(Icons.miscellaneous_services, 'Skilled\nWork', Color(0xFF2B4A8A)),
    _CategoryItem(Icons.agriculture, 'Unskilled\nWork', Color(0xFF1E6B34)),
    _CategoryItem(Icons.home_repair_service, 'Home\nServices', Color(0xFF6F2CA7)),
    _CategoryItem(Icons.restaurant, 'Cooking', Color(0xFF9E3D1C)),
    _CategoryItem(Icons.local_shipping, 'Delivery /\nDriving', Color(0xFF0E5078)),
    _CategoryItem(Icons.construction, 'Construction', Color(0xFF8E1F1B)),
    _CategoryItem(Icons.school, 'Tutoring', Color(0xFF0A7373)),
    _CategoryItem(Icons.devices_other, 'Tech /\nComputer Services', Color(0xFF1D3AA9)),
    _CategoryItem(Icons.cut, 'Tailoring', Color(0xFF8E1A3B)),
    _CategoryItem(Icons.plumbing, 'Electrical /\nPlumbing', Color(0xFF6C4A1C)),
    _CategoryItem(Icons.child_care, 'Babysitting', Color(0xFF11698E)),
    _CategoryItem(Icons.local_laundry_service, 'Housekeeping', Color(0xFF54751A)),
    _CategoryItem(Icons.language, 'Translation /\nData', Color(0xFF2B2F44)),
    _CategoryItem(Icons.celebration, 'Event &\nWedding Work', Color(0xFFB83280)),
    _CategoryItem(Icons.agriculture_outlined, 'Farming /\nAgricultural Work', Color(0xFF2E7D32)),
    _CategoryItem(Icons.brush, 'Beauty &\nGrooming', Color(0xFFAA3A6A)),
    _CategoryItem(Icons.pets, 'Pet Care', Color(0xFF3E6BA0)),
    _CategoryItem(Icons.computer, 'Freelance /\nOnline', Color(0xFF232D94)),
    _CategoryItem(Icons.shopping_bag, 'Salesman /\nShop Helper /\nStore Staff', Color(0xFF8C4F07)),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final scaffoldColor = theme.scaffoldBackgroundColor;
    final iconColor = isDark ? Colors.white : AppColors.lightText;
    final subtitleColor = isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText;

    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: iconColor, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          AppStrings.allCategoriesTitle,
          style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: iconColor,
              ) ??
              TextStyle(
                color: iconColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.md),
            child: Icon(Iconsax.search_normal, color: subtitleColor, size: 22),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: GridView.builder(
          padding: const EdgeInsets.only(top: AppSpacing.sm),
          itemCount: _categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 22,
            crossAxisSpacing: 18,
            childAspectRatio: 0.82,
          ),
          itemBuilder: (context, index) {
            final item = _categories[index];
            final baseColor = item.color;
            final cardColor = isDark ? baseColor.withOpacity(0.9) : baseColor.withOpacity(0.82);

            return Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius + 10),
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
                      color: Colors.white.withOpacity(isDark ? 0.22 : 0.16),
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
                    item.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      height: 1.3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CategoryItem {
  const _CategoryItem(this.icon, this.title, this.color);

  final IconData icon;
  final String title;
  final Color color;
}
