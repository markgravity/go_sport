import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:injectable/injectable.dart';

/// Service to provide localized sports lists
@injectable
class SportsLocalizationService {
  
  /// Get localized Vietnamese sports list
  static List<String> getLocalizedSportsList(AppLocalizations l10n) {
    // For now, return the Vietnamese list directly since we know this is primarily a Vietnamese app
    // In a future version, we could extend this to support multiple languages
    return [
      'Bóng đá',
      'Bóng chuyền',
      'Bóng rổ',
      'Cầu lông',
      'Tennis',
      'Bóng bàn',
      'Bơi lội',
      'Chạy bộ',
      'Đạp xe',
      'Yoga',
      'Gym/Thể hình',
      'Võ thuật',
      'Golf',
      'Billiards',
      'Bowling',
    ];
  }

  /// Get English sports list (for reference or fallback)
  static List<String> getEnglishSportsList() {
    return [
      'Football',
      'Volleyball',
      'Basketball',
      'Badminton',
      'Tennis',
      'Table Tennis',
      'Swimming',
      'Running',
      'Cycling',
      'Yoga',
      'Gym/Fitness',
      'Martial Arts',
      'Golf',
      'Billiards',
      'Bowling',
    ];
  }

  /// Get sports list based on current locale
  static List<String> getSportsListForLocale(AppLocalizations l10n) {
    // Check locale and return appropriate list
    if (l10n.localeName == 'vi') {
      return getLocalizedSportsList(l10n);
    } else {
      // Fallback to English for other locales
      return getEnglishSportsList();
    }
  }
}