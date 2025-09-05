import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Navigation configuration for Vietnamese sports app
class AppNavigation {
  
  /// Main navigation items for all users
  static List<NavigationItem> getMainNavigation(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return [
      NavigationItem(
        route: '/home',
        label: l10n.homeTab,
        icon: Icons.home_outlined,
        activeIcon: Icons.home,
        vietnameseLabel: 'Trang chủ',
      ),
      NavigationItem(
        route: '/groups',
        label: l10n.groupsTab,
        icon: Icons.group_outlined,
        activeIcon: Icons.group,
        vietnameseLabel: 'Nhóm',
      ),
      NavigationItem(
        route: '/attendance',
        label: l10n.attendanceTab,
        icon: Icons.how_to_reg_outlined,
        activeIcon: Icons.how_to_reg,
        vietnameseLabel: 'Điểm danh',
      ),
      NavigationItem(
        route: '/payments',
        label: l10n.paymentsTab,
        icon: Icons.payment_outlined,
        activeIcon: Icons.payment,
        vietnameseLabel: 'Thanh toán',
      ),
      NavigationItem(
        route: '/profile',
        label: l10n.profileTab,
        icon: Icons.person_outline,
        activeIcon: Icons.person,
        vietnameseLabel: 'Hồ sơ',
      ),
    ];
  }
  
  /// Role-based navigation for group administrators
  static List<NavigationItem> getAdminNavigation(BuildContext context) {
    final baseNavigation = getMainNavigation(context);
    
    return [
      ...baseNavigation,
      NavigationItem(
        route: '/admin',
        label: 'Quản lý',
        icon: Icons.admin_panel_settings_outlined,
        activeIcon: Icons.admin_panel_settings,
        vietnameseLabel: 'Quản lý nhóm',
        roleRequired: UserRole.admin,
      ),
    ];
  }
  
  /// Role-based navigation for group moderators
  static List<NavigationItem> getModeratorNavigation(BuildContext context) {
    final baseNavigation = getMainNavigation(context);
    
    return [
      ...baseNavigation,
      NavigationItem(
        route: '/moderate',
        label: 'Điều hành',
        icon: Icons.supervisor_account_outlined,
        activeIcon: Icons.supervisor_account,
        vietnameseLabel: 'Điều hành nhóm',
        roleRequired: UserRole.moderator,
      ),
    ];
  }
  
  /// Get navigation based on user role
  static List<NavigationItem> getNavigationForRole(
    BuildContext context, 
    UserRole role,
  ) {
    switch (role) {
      case UserRole.admin:
        return getAdminNavigation(context);
      case UserRole.moderator:
        return getModeratorNavigation(context);
      case UserRole.member:
      case UserRole.pending:
        return getMainNavigation(context);
    }
  }
  
  /// Vietnamese sports categories navigation
  static List<CategoryItem> getSportsCategories(BuildContext context) {
    return [
      CategoryItem(
        id: 'bong_da',
        vietnameseName: 'Bóng đá',
        englishName: 'Football',
        icon: Icons.sports_soccer,
        color: const Color(0xFF10B981),
        gradient: const LinearGradient(
          colors: [Color(0xFF10B981), Color(0xFF059669)],
        ),
      ),
      CategoryItem(
        id: 'cau_long',
        vietnameseName: 'Cầu lông',
        englishName: 'Badminton',
        icon: Icons.sports_tennis,
        color: const Color(0xFF3B82F6),
        gradient: const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
        ),
      ),
      CategoryItem(
        id: 'bong_ro',
        vietnameseName: 'Bóng rổ',
        englishName: 'Basketball',
        icon: Icons.sports_basketball,
        color: const Color(0xFFFF6B35),
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B35), Color(0xFFEA580C)],
        ),
      ),
      CategoryItem(
        id: 'chay_bo',
        vietnameseName: 'Chạy bộ',
        englishName: 'Running',
        icon: Icons.directions_run,
        color: const Color(0xFF8B5CF6),
        gradient: const LinearGradient(
          colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
        ),
      ),
      CategoryItem(
        id: 'boi_loi',
        vietnameseName: 'Bơi lội',
        englishName: 'Swimming',
        icon: Icons.pool,
        color: const Color(0xFF06B6D4),
        gradient: const LinearGradient(
          colors: [Color(0xFF06B6D4), Color(0xFF0891B2)],
        ),
      ),
      CategoryItem(
        id: 'yoga',
        vietnameseName: 'Yoga',
        englishName: 'Yoga',
        icon: Icons.self_improvement,
        color: const Color(0xFFEC4899),
        gradient: const LinearGradient(
          colors: [Color(0xFFEC4899), Color(0xFFDB2777)],
        ),
      ),
    ];
  }
  
  /// Quick action items for Vietnamese users
  static List<QuickAction> getQuickActions(BuildContext context) {
    return [
      QuickAction(
        id: 'create_group',
        vietnameseLabel: 'Tạo nhóm mới',
        englishLabel: 'Create Group',
        icon: Icons.add_circle_outline,
        color: const Color(0xFF10B981),
        route: '/create-group',
      ),
      QuickAction(
        id: 'join_group',
        vietnameseLabel: 'Tham gia nhóm',
        englishLabel: 'Join Group',
        icon: Icons.group_add,
        color: const Color(0xFF3B82F6),
        route: '/join-group',
      ),
      QuickAction(
        id: 'scan_qr',
        vietnameseLabel: 'Quét QR điểm danh',
        englishLabel: 'Scan QR',
        icon: Icons.qr_code_scanner,
        color: const Color(0xFF8B5CF6),
        route: '/scan-qr',
      ),
      QuickAction(
        id: 'payment_history',
        vietnameseLabel: 'Lịch sử thanh toán',
        englishLabel: 'Payment History',
        icon: Icons.receipt_long,
        color: const Color(0xFFFF6B35),
        route: '/payment-history',
      ),
    ];
  }
}

/// Navigation item configuration
class NavigationItem {
  final String route;
  final String label;
  final String vietnameseLabel;
  final IconData icon;
  final IconData activeIcon;
  final UserRole? roleRequired;
  final bool requiresAuth;

  const NavigationItem({
    required this.route,
    required this.label,
    required this.vietnameseLabel,
    required this.icon,
    required this.activeIcon,
    this.roleRequired,
    this.requiresAuth = true,
  });
}

/// Vietnamese sports category configuration
class CategoryItem {
  final String id;
  final String vietnameseName;
  final String englishName;
  final IconData icon;
  final Color color;
  final LinearGradient gradient;

  const CategoryItem({
    required this.id,
    required this.vietnameseName,
    required this.englishName,
    required this.icon,
    required this.color,
    required this.gradient,
  });
}

/// Quick action configuration for Vietnamese users
class QuickAction {
  final String id;
  final String vietnameseLabel;
  final String englishLabel;
  final IconData icon;
  final Color color;
  final String route;

  const QuickAction({
    required this.id,
    required this.vietnameseLabel,
    required this.englishLabel,
    required this.icon,
    required this.color,
    required this.route,
  });
}

/// User role enumeration matching backend
enum UserRole {
  admin,     // Quản trị viên
  moderator, // Điều hành viên  
  member,    // Thành viên
  pending,   // Chờ duyệt
}