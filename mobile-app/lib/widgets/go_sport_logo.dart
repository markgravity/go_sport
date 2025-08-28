import 'package:flutter/material.dart';

/// Go Sport branded logo widget with customizable size and style
class GoSportLogo extends StatelessWidget {
  const GoSportLogo({
    super.key,
    this.size = 120,
    this.showText = true,
    this.variant = LogoVariant.primary,
  });

  final double size;
  final bool showText;
  final LogoVariant variant;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo Icon
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            gradient: _getLogoGradient(colorScheme),
            borderRadius: BorderRadius.circular(size * 0.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: size * 0.15,
                spreadRadius: 2,
                offset: Offset(0, size * 0.05),
              ),
            ],
          ),
          child: Center(
            child: _buildLogoIcon(context),
          ),
        ),
        
        if (showText) ...[
          SizedBox(height: size * 0.15),
          _buildLogoText(context),
        ],
      ],
    );
  }

  Widget _buildLogoIcon(BuildContext context) {
    final iconSize = size * 0.5;
    final colorScheme = Theme.of(context).colorScheme;
    
    return Stack(
      alignment: Alignment.center,
      children: [
        // Background circle for contrast
        Container(
          width: iconSize * 1.2,
          height: iconSize * 1.2,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            shape: BoxShape.circle,
          ),
        ),
        
        // Main sport icon
        Icon(
          Icons.sports_soccer,
          size: iconSize,
          color: _getIconColor(Theme.of(context).colorScheme),
        ),
        
        // Accent overlay
        Positioned(
          top: iconSize * 0.1,
          right: iconSize * 0.1,
          child: Container(
            width: iconSize * 0.3,
            height: iconSize * 0.3,
            decoration: BoxDecoration(
              color: colorScheme.secondary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.star,
              size: iconSize * 0.2,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoText(BuildContext context) {
    final textSize = size * 0.25;
    final theme = Theme.of(context);
    
    return Column(
      children: [
        Text(
          'Go Sport',
          style: TextStyle(
            fontSize: textSize,
            fontWeight: FontWeight.w800,
            color: _getTextColor(theme.colorScheme),
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: textSize * 0.1),
        Text(
          'Thể thao cùng nhau',
          style: TextStyle(
            fontSize: textSize * 0.45,
            fontWeight: FontWeight.w500,
            color: _getTextColor(theme.colorScheme).withOpacity(0.8),
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  LinearGradient _getLogoGradient(ColorScheme colorScheme) {
    switch (variant) {
      case LogoVariant.primary:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF4A90E2), // Primary blue
            Color(0xFF2E5BDA), // Deeper blue
          ],
        );
      case LogoVariant.secondary:
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.secondary,
            colorScheme.secondaryContainer,
          ],
        );
      case LogoVariant.white:
        return const LinearGradient(
          colors: [Colors.white, Colors.white],
        );
      case LogoVariant.dark:
        return const LinearGradient(
          colors: [Color(0xFF1E293B), Color(0xFF334155)],
        );
    }
  }

  Color _getIconColor(ColorScheme colorScheme) {
    switch (variant) {
      case LogoVariant.white:
        return const Color(0xFF3A7BD5);
      case LogoVariant.dark:
        return Colors.white;
      default:
        return const Color(0xFF3A7BD5);
    }
  }

  Color _getTextColor(ColorScheme colorScheme) {
    switch (variant) {
      case LogoVariant.white:
        return colorScheme.onSurface;
      case LogoVariant.dark:
        return Colors.white;
      default:
        return Colors.white;
    }
  }
}

enum LogoVariant {
  primary,
  secondary,
  white,
  dark,
}