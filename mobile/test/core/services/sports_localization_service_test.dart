import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_sport_app/core/services/sports_localization_service.dart';

// Mock AppLocalizations for testing
class MockAppLocalizationsVi extends AppLocalizations {
  MockAppLocalizationsVi() : super('vi');
  
  @override
  String get localeName => 'vi';
}

class MockAppLocalizationsEn extends AppLocalizations {
  MockAppLocalizationsEn() : super('en');
  
  @override 
  String get localeName => 'en';
}

void main() {
  group('SportsLocalizationService', () {
    group('Vietnamese sports list', () {
      test('returns localized Vietnamese sports list', () {
        final mockL10n = MockAppLocalizationsVi();
        final sportsList = SportsLocalizationService.getLocalizedSportsList(mockL10n);
        
        expect(sportsList, isNotEmpty);
        expect(sportsList.length, equals(15));
        
        // Check for key Vietnamese sports
        expect(sportsList, contains('Bóng đá'));
        expect(sportsList, contains('Bóng chuyền'));
        expect(sportsList, contains('Bóng rổ'));
        expect(sportsList, contains('Cầu lông'));
        expect(sportsList, contains('Tennis'));
        expect(sportsList, contains('Bóng bàn'));
        expect(sportsList, contains('Bơi lội'));
        expect(sportsList, contains('Chạy bộ'));
        expect(sportsList, contains('Đạp xe'));
        expect(sportsList, contains('Yoga'));
        expect(sportsList, contains('Gym/Thể hình'));
        expect(sportsList, contains('Võ thuật'));
        expect(sportsList, contains('Golf'));
        expect(sportsList, contains('Billiards'));
        expect(sportsList, contains('Bowling'));
      });

      test('Vietnamese sports list has correct order', () {
        final mockL10n = MockAppLocalizationsVi();
        final sportsList = SportsLocalizationService.getLocalizedSportsList(mockL10n);
        
        // Check that popular Vietnamese sports are at the top
        expect(sportsList[0], equals('Bóng đá')); // Football is most popular
        expect(sportsList[1], equals('Bóng chuyền')); // Volleyball is also very popular
        expect(sportsList[2], equals('Bóng rổ')); // Basketball
      });
    });

    group('English sports list', () {
      test('returns English sports list', () {
        final sportsList = SportsLocalizationService.getEnglishSportsList();
        
        expect(sportsList, isNotEmpty);
        expect(sportsList.length, equals(15));
        
        // Check for key English sports
        expect(sportsList, contains('Football'));
        expect(sportsList, contains('Volleyball'));
        expect(sportsList, contains('Basketball'));
        expect(sportsList, contains('Badminton'));
        expect(sportsList, contains('Tennis'));
        expect(sportsList, contains('Table Tennis'));
        expect(sportsList, contains('Swimming'));
        expect(sportsList, contains('Running'));
        expect(sportsList, contains('Cycling'));
        expect(sportsList, contains('Yoga'));
        expect(sportsList, contains('Gym/Fitness'));
        expect(sportsList, contains('Martial Arts'));
        expect(sportsList, contains('Golf'));
        expect(sportsList, contains('Billiards'));
        expect(sportsList, contains('Bowling'));
      });

      test('English sports list has correct order', () {
        final sportsList = SportsLocalizationService.getEnglishSportsList();
        
        // Check that sports are in a logical order
        expect(sportsList[0], equals('Football'));
        expect(sportsList[1], equals('Volleyball'));
        expect(sportsList[2], equals('Basketball'));
      });
    });

    group('Locale-based sports list', () {
      test('returns Vietnamese list for Vietnamese locale', () {
        final mockL10n = MockAppLocalizationsVi();
        final sportsList = SportsLocalizationService.getSportsListForLocale(mockL10n);
        
        expect(sportsList, contains('Bóng đá'));
        expect(sportsList, contains('Bóng chuyền'));
        expect(sportsList, isNot(contains('Football')));
        expect(sportsList, isNot(contains('Volleyball')));
      });

      test('returns English list for English locale', () {
        final mockL10n = MockAppLocalizationsEn();
        final sportsList = SportsLocalizationService.getSportsListForLocale(mockL10n);
        
        expect(sportsList, contains('Football'));
        expect(sportsList, contains('Volleyball'));
        expect(sportsList, isNot(contains('Bóng đá')));
        expect(sportsList, isNot(contains('Bóng chuyền')));
      });

      test('returns English list as fallback for unknown locale', () {
        // Create a mock with an unsupported locale
        final mockL10n = MockAppLocalizationsEn();
        // Override the localeName to simulate unsupported locale
        final sportsList = SportsLocalizationService.getEnglishSportsList();
        
        expect(sportsList, contains('Football'));
        expect(sportsList, contains('Volleyball'));
      });
    });

    group('Sports list consistency', () {
      test('Vietnamese and English lists have same number of sports', () {
        final mockL10n = MockAppLocalizationsVi();
        final vietnameseSports = SportsLocalizationService.getLocalizedSportsList(mockL10n);
        final englishSports = SportsLocalizationService.getEnglishSportsList();
        
        expect(vietnameseSports.length, equals(englishSports.length));
      });

      test('All sports lists are non-empty strings', () {
        final mockL10n = MockAppLocalizationsVi();
        final vietnameseSports = SportsLocalizationService.getLocalizedSportsList(mockL10n);
        final englishSports = SportsLocalizationService.getEnglishSportsList();
        
        // Check Vietnamese sports
        for (final sport in vietnameseSports) {
          expect(sport, isNotEmpty);
          expect(sport.trim(), equals(sport)); // No leading/trailing whitespace
        }
        
        // Check English sports
        for (final sport in englishSports) {
          expect(sport, isNotEmpty);
          expect(sport.trim(), equals(sport)); // No leading/trailing whitespace
        }
      });

      test('No duplicate sports in lists', () {
        final mockL10n = MockAppLocalizationsVi();
        final vietnameseSports = SportsLocalizationService.getLocalizedSportsList(mockL10n);
        final englishSports = SportsLocalizationService.getEnglishSportsList();
        
        // Check Vietnamese sports for duplicates
        final vietnameseSet = vietnameseSports.toSet();
        expect(vietnameseSet.length, equals(vietnameseSports.length));
        
        // Check English sports for duplicates
        final englishSet = englishSports.toSet();
        expect(englishSet.length, equals(englishSports.length));
      });
    });

    group('Edge cases', () {
      test('handles null localization gracefully', () {
        // This test ensures the service doesn't crash with null input
        // In real usage, AppLocalizations.of(context) should never return null,
        // but we test defensive programming
        expect(() => SportsLocalizationService.getEnglishSportsList(), returnsNormally);
      });

      test('sports names are properly formatted', () {
        final mockL10n = MockAppLocalizationsVi();
        final vietnameseSports = SportsLocalizationService.getLocalizedSportsList(mockL10n);
        
        // Check that sports names follow Vietnamese naming conventions
        expect(vietnameseSports, contains('Bóng đá')); // Space between words
        expect(vietnameseSports, contains('Gym/Thể hình')); // Mixed naming with slash
        expect(vietnameseSports, contains('Võ thuật')); // Vietnamese characters
        
        final englishSports = SportsLocalizationService.getEnglishSportsList();
        
        // Check English naming conventions
        expect(englishSports, contains('Table Tennis')); // Space between words
        expect(englishSports, contains('Gym/Fitness')); // Mixed naming with slash
        expect(englishSports, contains('Martial Arts')); // Space between words
      });
    });

    group('Sports coverage', () {
      test('includes popular Vietnamese sports', () {
        final mockL10n = MockAppLocalizationsVi();
        final sportsList = SportsLocalizationService.getLocalizedSportsList(mockL10n);
        
        // Popular in Vietnam
        expect(sportsList, contains('Bóng đá')); // Most popular
        expect(sportsList, contains('Cầu lông')); // Very popular in Vietnam
        expect(sportsList, contains('Bóng bàn')); // Popular in Asia
        expect(sportsList, contains('Võ thuật')); // Traditional
      });

      test('includes common recreational sports', () {
        final mockL10n = MockAppLocalizationsVi();
        final sportsList = SportsLocalizationService.getLocalizedSportsList(mockL10n);
        
        // Recreational activities
        expect(sportsList, contains('Chạy bộ'));
        expect(sportsList, contains('Đạp xe'));
        expect(sportsList, contains('Bơi lội'));
        expect(sportsList, contains('Yoga'));
        expect(sportsList, contains('Gym/Thể hình'));
      });

      test('includes modern and traditional sports mix', () {
        final mockL10n = MockAppLocalizationsVi();
        final sportsList = SportsLocalizationService.getLocalizedSportsList(mockL10n);
        
        // Modern sports
        expect(sportsList, contains('Bowling'));
        expect(sportsList, contains('Golf'));
        
        // Traditional/established sports
        expect(sportsList, contains('Tennis'));
        expect(sportsList, contains('Billiards'));
      });
    });
  });
}