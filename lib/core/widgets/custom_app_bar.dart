import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.leading,
    this.title = '',
    this.subtitle,
    this.showBack = false,
    this.centerTitle = false,
    this.showSearch = false,
    this.showNotification = false,
    this.showFavorite = false,
    this.profileImage,
    this.actions = const [],
    this.onBack,
    this.onSearch,
    this.onNotification,
    this.onFavorite,
  });

  final Widget? leading;
  final Object? title;
  final String? subtitle;

  final bool showBack;
  final bool centerTitle;

  final bool showSearch;
  final bool showNotification;
  final bool showFavorite;

  final String? profileImage;

  final VoidCallback? onBack;
  final VoidCallback? onSearch;
  final VoidCallback? onNotification;
  final VoidCallback? onFavorite;

  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final hasLeading = showBack || leading != null;
    final topPadding = MediaQuery.paddingOf(context).top;
    final backgroundColor = theme.scaffoldBackgroundColor;

    Widget? titleContent;
    if (title is Widget) {
      titleContent = title as Widget;
    } else if (title is String && (title as String).isNotEmpty) {
      titleContent = Text(
        title as String,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      );
    }

    final subtitleContent = subtitle != null
        ? Text(
            subtitle!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
          )
        : null;

    final overlayStyle = (theme.brightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark)
        .copyWith(
      statusBarColor: backgroundColor,
      statusBarIconBrightness:
          theme.brightness == Brightness.dark ? Brightness.light : Brightness.dark,
      statusBarBrightness: theme.brightness,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Container(
        color: backgroundColor,
        padding: EdgeInsets.only(
          top: topPadding,
          left: 20,
          right: 12,
          bottom: 12,
        ),
        child: Row(
            children: [
              if (showBack)
                GestureDetector(
                  onTap: onBack ?? () => Navigator.pop(context),
                  child: const Icon(Iconsax.arrow_left, size: 24),
                )
              else if (leading != null)
                leading!,

              if (hasLeading) const SizedBox(width: 12),

              Expanded(
                child: Align(
                  alignment:
                      centerTitle ? Alignment.center : Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: centerTitle
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (titleContent != null) titleContent,
                      if (subtitleContent != null) subtitleContent,
                    ],
                  ),
                ),
              ),

              if (showSearch)
                IconButton(
                  onPressed: onSearch,
                  icon: const Icon(Iconsax.search_normal),
                ),

              if (showNotification)
                IconButton(
                  onPressed: onNotification,
                  icon: const Icon(Iconsax.notification),
                ),

              if (showFavorite)
                IconButton(
                  onPressed: onFavorite,
                  icon: const Icon(Iconsax.heart),
                ),

              if (profileImage != null)
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(profileImage!),
                ),

              ...actions,
            ],
          ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
