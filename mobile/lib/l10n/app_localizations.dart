import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Go Sport'**
  String get appTitle;

  /// Home tab label
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTab;

  /// Groups tab label
  ///
  /// In en, this message translates to:
  /// **'Groups'**
  String get groupsTab;

  /// Attendance tab label
  ///
  /// In en, this message translates to:
  /// **'Attendance'**
  String get attendanceTab;

  /// Payments tab label
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get paymentsTab;

  /// Profile tab label
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTab;

  /// Welcome message for users
  ///
  /// In en, this message translates to:
  /// **'Welcome to Go Sport!'**
  String get welcomeMessage;

  /// Loading indicator text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get error;

  /// Retry button text
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Confirm button text
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Register account screen title
  ///
  /// In en, this message translates to:
  /// **'Register Account'**
  String get registerAccount;

  /// Create account header text
  ///
  /// In en, this message translates to:
  /// **'Create Go Sport Account'**
  String get createGoSportAccount;

  /// Registration instruction text
  ///
  /// In en, this message translates to:
  /// **'Enter information to create a new account'**
  String get enterInfoToRegister;

  /// Name field label
  ///
  /// In en, this message translates to:
  /// **'Your Name'**
  String get yourName;

  /// Name input placeholder
  ///
  /// In en, this message translates to:
  /// **'Nguyen Van A'**
  String get namePlaceholder;

  /// Phone number field label
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// New password field label
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// Confirm password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// Password input placeholder
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enterPassword;

  /// Confirm password input placeholder
  ///
  /// In en, this message translates to:
  /// **'Re-enter password'**
  String get reenterPassword;

  /// Sports selection field label
  ///
  /// In en, this message translates to:
  /// **'Favorite Sports (optional)'**
  String get favoriteSports;

  /// Send verification button text
  ///
  /// In en, this message translates to:
  /// **'Send Verification Code'**
  String get sendVerificationCode;

  /// Terms agreement text part 1
  ///
  /// In en, this message translates to:
  /// **'By registering, you agree to our '**
  String get agreeToTerms;

  /// Terms of service link text
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// Conjunction between terms and privacy
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get and;

  /// Privacy policy link text
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// SMS verification screen title
  ///
  /// In en, this message translates to:
  /// **'Verify Phone Number'**
  String get verifyPhoneNumber;

  /// SMS verification header
  ///
  /// In en, this message translates to:
  /// **'Enter Verification Code'**
  String get enterVerificationCode;

  /// Code sent message
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a 6-digit verification code to'**
  String get codeSentTo;

  /// Verify button text
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// Resend code prompt
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code? '**
  String get didNotReceiveCode;

  /// Resend code button text
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// Resend countdown text
  ///
  /// In en, this message translates to:
  /// **'Resend after {seconds}s'**
  String resendAfter(int seconds);

  /// Code validity information
  ///
  /// In en, this message translates to:
  /// **'The verification code is valid for 5 minutes. Check your spam folder if you don\'t see the message.'**
  String get codeValidInfo;

  /// Phone carrier display
  ///
  /// In en, this message translates to:
  /// **'Carrier: {carrier}'**
  String carrier(String carrier);

  /// Name validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get errorEnterName;

  /// Phone validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter phone number'**
  String get errorEnterPhone;

  /// Phone too short error
  ///
  /// In en, this message translates to:
  /// **'Phone number is too short'**
  String get errorPhoneTooShort;

  /// Phone too long error
  ///
  /// In en, this message translates to:
  /// **'Phone number is too long'**
  String get errorPhoneTooLong;

  /// Invalid Vietnamese phone error
  ///
  /// In en, this message translates to:
  /// **'Phone number is not in Vietnamese format'**
  String get errorInvalidVietnamesePhone;

  /// Password validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter password'**
  String get errorEnterPassword;

  /// Password too short error
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get errorPasswordTooShort;

  /// Password confirmation error
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get errorConfirmPassword;

  /// Password mismatch error
  ///
  /// In en, this message translates to:
  /// **'Password confirmation does not match'**
  String get errorPasswordMismatch;

  /// Verification code validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter all 6 digits'**
  String get errorEnterFullCode;

  /// Unknown carrier text
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknownCarrier;

  /// Registration success message
  ///
  /// In en, this message translates to:
  /// **'Registration successful! Welcome {name}'**
  String successRegistration(String name);

  /// Code sent success message
  ///
  /// In en, this message translates to:
  /// **'New verification code has been sent'**
  String get successVerificationCodeSent;

  /// Login button text
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Login screen welcome message
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// Login instruction text
  ///
  /// In en, this message translates to:
  /// **'Login to your Go Sport account'**
  String get loginToYourAccount;

  /// Remember me checkbox label
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// Forgot password link text
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// Biometric login button text
  ///
  /// In en, this message translates to:
  /// **'Login with biometric'**
  String get loginWithBiometric;

  /// Register prompt text
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAccount;

  /// Register link text
  ///
  /// In en, this message translates to:
  /// **'Register now'**
  String get registerNow;

  /// Logout confirmation dialog title
  ///
  /// In en, this message translates to:
  /// **'Logout Confirmation'**
  String get logoutConfirmation;

  /// Logout confirmation dialog message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout from your account?'**
  String get logoutConfirmationMessage;

  /// Session timeout dialog title
  ///
  /// In en, this message translates to:
  /// **'Session Timeout'**
  String get sessionTimeout;

  /// Session timeout dialog message
  ///
  /// In en, this message translates to:
  /// **'Your session will expire soon due to inactivity. Would you like to extend your session?'**
  String get sessionTimeoutMessage;

  /// Logout now button text
  ///
  /// In en, this message translates to:
  /// **'Logout Now'**
  String get logoutNow;

  /// Extend session button text
  ///
  /// In en, this message translates to:
  /// **'Extend Session'**
  String get extendSession;

  /// Logout button text
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Reset password screen title
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// Password reset instruction text
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number to reset your password'**
  String get enterPhoneToReset;

  /// Send reset code button text
  ///
  /// In en, this message translates to:
  /// **'Send Reset Code'**
  String get sendResetCode;

  /// Reset code sent success message
  ///
  /// In en, this message translates to:
  /// **'Password reset code sent to your phone'**
  String get resetCodeSent;

  /// Enter reset code instruction
  ///
  /// In en, this message translates to:
  /// **'Enter Reset Code'**
  String get enterResetCode;

  /// New password instruction
  ///
  /// In en, this message translates to:
  /// **'Enter your new password'**
  String get enterNewPassword;

  /// Confirm new password instruction
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get confirmNewPassword;

  /// Update password button text
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatePassword;

  /// Password reset success message
  ///
  /// In en, this message translates to:
  /// **'Password reset successful! Please login with your new password.'**
  String get passwordResetSuccess;

  /// Back to login button text
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get backToLogin;

  /// Create group screen title
  ///
  /// In en, this message translates to:
  /// **'Create Group'**
  String get createGroup;

  /// Choose sport for group
  ///
  /// In en, this message translates to:
  /// **'Choose sport'**
  String get chooseGroupSport;

  /// Popular sports section
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get popularSports;

  /// All sports section
  ///
  /// In en, this message translates to:
  /// **'All Sports'**
  String get allSports;

  /// Selected indicator
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get selected;

  /// Basic information section
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get basicInfo;

  /// Group name field
  ///
  /// In en, this message translates to:
  /// **'Group Name'**
  String get groupName;

  /// Required group name field
  ///
  /// In en, this message translates to:
  /// **'Group Name *'**
  String get groupNameRequired;

  /// Group name hint
  ///
  /// In en, this message translates to:
  /// **'E.g.: Hanoi Badminton Group'**
  String get groupNameHint;

  /// Group description field
  ///
  /// In en, this message translates to:
  /// **'Group Description'**
  String get groupDescription;

  /// Group description hint
  ///
  /// In en, this message translates to:
  /// **'Describe your group...'**
  String get groupDescriptionHint;

  /// Skill level field
  ///
  /// In en, this message translates to:
  /// **'Skill Level'**
  String get skillLevel;

  /// Required skill level field
  ///
  /// In en, this message translates to:
  /// **'Skill Level *'**
  String get skillLevelRequired;

  /// Required city field
  ///
  /// In en, this message translates to:
  /// **'City *'**
  String get cityRequired;

  /// City hint
  ///
  /// In en, this message translates to:
  /// **'E.g.: Hanoi'**
  String get cityHint;

  /// District field
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get district;

  /// District hint
  ///
  /// In en, this message translates to:
  /// **'E.g.: Ba Dinh'**
  String get districtHint;

  /// Required location field
  ///
  /// In en, this message translates to:
  /// **'Location *'**
  String get locationRequired;

  /// Location hint
  ///
  /// In en, this message translates to:
  /// **'E.g.: ABC Badminton Court, 123 XYZ Street'**
  String get locationHint;

  /// Group settings section
  ///
  /// In en, this message translates to:
  /// **'Group Settings'**
  String get groupSettings;

  /// Max members field
  ///
  /// In en, this message translates to:
  /// **'Maximum Members'**
  String get maxMembers;

  /// Membership fee field
  ///
  /// In en, this message translates to:
  /// **'Membership Fee (VND/month)'**
  String get membershipFee;

  /// Privacy settings
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// Public group option
  ///
  /// In en, this message translates to:
  /// **'Public'**
  String get publicGroup;

  /// Private group option
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get privateGroup;

  /// Public group description
  ///
  /// In en, this message translates to:
  /// **'Anyone can find and join the group'**
  String get publicGroupDesc;

  /// Private group description
  ///
  /// In en, this message translates to:
  /// **'Only joinable by invitation or request'**
  String get privateGroupDesc;

  /// Group rules section
  ///
  /// In en, this message translates to:
  /// **'Group Rules'**
  String get groupRules;

  /// Add rule button
  ///
  /// In en, this message translates to:
  /// **'Add Rule'**
  String get addRule;

  /// Enter new rule hint
  ///
  /// In en, this message translates to:
  /// **'Enter new rule...'**
  String get enterNewRule;

  /// Back button
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Continue button
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// Finish button
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// Minimum group name length error
  ///
  /// In en, this message translates to:
  /// **'Group name must be at least 3 characters'**
  String get errorMinGroupName;

  /// Enter group name error
  ///
  /// In en, this message translates to:
  /// **'Please enter group name'**
  String get errorEnterGroupName;

  /// Select skill level error
  ///
  /// In en, this message translates to:
  /// **'Please select skill level'**
  String get errorSelectSkillLevel;

  /// Enter city error
  ///
  /// In en, this message translates to:
  /// **'Please enter city'**
  String get errorEnterCity;

  /// Enter location error
  ///
  /// In en, this message translates to:
  /// **'Please enter location'**
  String get errorEnterLocation;

  /// Football/Soccer sport name
  ///
  /// In en, this message translates to:
  /// **'Football'**
  String get sportFootball;

  /// Badminton sport name
  ///
  /// In en, this message translates to:
  /// **'Badminton'**
  String get sportBadminton;

  /// Tennis sport name
  ///
  /// In en, this message translates to:
  /// **'Tennis'**
  String get sportTennis;

  /// Pickleball sport name
  ///
  /// In en, this message translates to:
  /// **'Pickleball'**
  String get sportPickleball;

  /// Basketball sport name
  ///
  /// In en, this message translates to:
  /// **'Basketball'**
  String get sportBasketball;

  /// Volleyball sport name
  ///
  /// In en, this message translates to:
  /// **'Volleyball'**
  String get sportVolleyball;

  /// Table tennis sport name
  ///
  /// In en, this message translates to:
  /// **'Table Tennis'**
  String get sportTableTennis;

  /// Admin role name
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get roleAdmin;

  /// Moderator role name
  ///
  /// In en, this message translates to:
  /// **'Moderator'**
  String get roleModerator;

  /// Member role name
  ///
  /// In en, this message translates to:
  /// **'Member'**
  String get roleMember;

  /// Guest role name
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get roleGuest;

  /// Pending role name
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get rolePending;

  /// Group creation step 1 title
  ///
  /// In en, this message translates to:
  /// **'Step 1: Choose Sport'**
  String get groupCreationStep1;

  /// Group creation step 2 title
  ///
  /// In en, this message translates to:
  /// **'Step 2: Group Information'**
  String get groupCreationStep2;

  /// Group creation step 3 title
  ///
  /// In en, this message translates to:
  /// **'Step 3: Settings and Rules'**
  String get groupCreationStep3;

  /// Group creation success message
  ///
  /// In en, this message translates to:
  /// **'Group created successfully!'**
  String get groupCreationComplete;

  /// Welcome message after group creation
  ///
  /// In en, this message translates to:
  /// **'Welcome to your new group!'**
  String get groupCreationWelcome;

  /// Help text for group name field
  ///
  /// In en, this message translates to:
  /// **'Group name will be displayed to all members. Choose a recognizable name that fits the sport.'**
  String get helpGroupName;

  /// Help text for group description field
  ///
  /// In en, this message translates to:
  /// **'Brief description of the group, its goals and characteristics.'**
  String get helpGroupDescription;

  /// Help text for skill level field
  ///
  /// In en, this message translates to:
  /// **'Choose appropriate skill level to attract players of similar level.'**
  String get helpSkillLevel;

  /// Help text for location field
  ///
  /// In en, this message translates to:
  /// **'Main location where the group usually plays. Can be changed later.'**
  String get helpLocation;

  /// Help text for membership fee field
  ///
  /// In en, this message translates to:
  /// **'Monthly membership fee (if any). Leave blank if group is free.'**
  String get helpMembershipFee;

  /// Help text for privacy settings
  ///
  /// In en, this message translates to:
  /// **'Public group: Anyone can find and join\nPrivate group: Join by invitation only'**
  String get helpPrivacy;

  /// Group name suggestion with sport and city
  ///
  /// In en, this message translates to:
  /// **'{sport} Group {city}'**
  String groupNameSuggestionSport(String sport, String city);

  /// Club-style group name suggestion
  ///
  /// In en, this message translates to:
  /// **'{sport} Club {city}'**
  String groupNameSuggestionClub(String sport, String city);

  /// Team-style group name suggestion
  ///
  /// In en, this message translates to:
  /// **'{sport} Team {city}'**
  String groupNameSuggestionTeam(String sport, String city);

  /// Tap to use suggestion instruction
  ///
  /// In en, this message translates to:
  /// **'Tap to use'**
  String get tapToUse;

  /// Name suggestions title
  ///
  /// In en, this message translates to:
  /// **'Name Suggestions'**
  String get nameSuggestions;

  /// Group creation failed error
  ///
  /// In en, this message translates to:
  /// **'Group creation failed. Please try again.'**
  String get errorGroupCreationFailed;

  /// Invalid sport selection error
  ///
  /// In en, this message translates to:
  /// **'Please select a valid sport'**
  String get errorInvalidSportSelection;

  /// Network connection error
  ///
  /// In en, this message translates to:
  /// **'Network connection error. Please check your connection and try again.'**
  String get errorNetworkConnection;

  /// Server error message
  ///
  /// In en, this message translates to:
  /// **'Server error. Please try again later.'**
  String get errorServerError;

  /// Permission denied error
  ///
  /// In en, this message translates to:
  /// **'You don\'t have permission to perform this action'**
  String get errorPermissionDenied;

  /// Group not found error
  ///
  /// In en, this message translates to:
  /// **'Group not found'**
  String get errorGroupNotFound;

  /// Member not found error
  ///
  /// In en, this message translates to:
  /// **'Member not found'**
  String get errorMemberNotFound;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
