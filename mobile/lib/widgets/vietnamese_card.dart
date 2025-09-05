import 'package:flutter/material.dart';

/// Vietnamese-optimized card widget for sports app
class VietnameseCard extends StatelessWidget {
  const VietnameseCard({
    super.key,
    required this.child,
    this.title,
    this.vietnameseTitle,
    this.subtitle,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.all(8),
    this.gradient,
    this.onTap,
    this.elevation = 2,
    this.showBorder = false,
  });

  final Widget child;
  final String? title;
  final String? vietnameseTitle;
  final String? subtitle;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final LinearGradient? gradient;
  final VoidCallback? onTap;
  final double elevation;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    Widget cardChild = Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        border: showBorder 
          ? Border.all(color: colorScheme.outline.withValues(alpha: 0.2))
          : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null || vietnameseTitle != null) ...[
            _buildHeader(context),
            const SizedBox(height: 12),
          ],
          child,
        ],
      ),
    );

    if (onTap != null) {
      cardChild = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: cardChild,
      );
    }

    return Container(
      margin: margin,
      child: Card(
        elevation: elevation,
        child: cardChild,
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (vietnameseTitle != null)
          Text(
            vietnameseTitle!,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: gradient != null ? Colors.white : null,
            ),
          ),
        if (title != null && vietnameseTitle != null)
          const SizedBox(height: 2),
        if (title != null)
          Text(
            title!,
            style: theme.textTheme.titleMedium?.copyWith(
              color: gradient != null 
                ? Colors.white.withValues(alpha: 0.9)
                : theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: gradient != null 
                ? Colors.white.withValues(alpha: 0.8)
                : theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ],
    );
  }
}