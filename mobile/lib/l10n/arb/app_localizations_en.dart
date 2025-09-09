// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Go Sport';

  @override
  String get homeTab => 'Home';

  @override
  String get groupsTab => 'Groups';

  @override
  String get attendanceTab => 'Attendance';

  @override
  String get paymentsTab => 'Payments';

  @override
  String get profileTab => 'Profile';

  @override
  String get welcomeMessage => 'Welcome to Go Sport!';

  @override
  String get loading => 'Loading...';

  @override
  String get error => 'An error occurred';

  @override
  String get retry => 'Retry';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get registerAccount => 'Register Account';

  @override
  String get createGoSportAccount => 'Create Go Sport Account';

  @override
  String get enterInfoToRegister => 'Enter information to create a new account';

  @override
  String get yourName => 'Your Name';

  @override
  String get namePlaceholder => 'Nguyen Van A';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get password => 'Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get enterPassword => 'Enter password';

  @override
  String get reenterPassword => 'Re-enter password';

  @override
  String get favoriteSports => 'Favorite Sports (optional)';

  @override
  String get sendVerificationCode => 'Send Verification Code';

  @override
  String get agreeToTerms => 'By registering, you agree to our ';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get and => ' and ';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get verifyPhoneNumber => 'Verify Phone Number';

  @override
  String get enterVerificationCode => 'Enter Verification Code';

  @override
  String get codeSentTo => 'We\'ve sent a 6-digit verification code to';

  @override
  String get verify => 'Verify';

  @override
  String get didNotReceiveCode => 'Didn\'t receive the code? ';

  @override
  String get resend => 'Resend';

  @override
  String resendAfter(int seconds) {
    return 'Resend after ${seconds}s';
  }

  @override
  String get codeValidInfo =>
      'The verification code is valid for 5 minutes. Check your spam folder if you don\'t see the message.';

  @override
  String carrier(String carrier) {
    return 'Carrier: $carrier';
  }

  @override
  String get errorEnterName => 'Please enter your name';

  @override
  String get errorEnterPhone => 'Please enter phone number';

  @override
  String get errorPhoneTooShort => 'Phone number is too short';

  @override
  String get errorPhoneTooLong => 'Phone number is too long';

  @override
  String get errorInvalidVietnamesePhone =>
      'Phone number is not in Vietnamese format';

  @override
  String get errorEnterPassword => 'Please enter password';

  @override
  String get errorPasswordTooShort => 'Password must be at least 8 characters';

  @override
  String get errorConfirmPassword => 'Please confirm your password';

  @override
  String get errorPasswordMismatch => 'Password confirmation does not match';

  @override
  String get errorEnterFullCode => 'Please enter all 6 digits';

  @override
  String get unknownCarrier => 'Unknown';

  @override
  String successRegistration(String name) {
    return 'Registration successful! Welcome $name';
  }

  @override
  String get successVerificationCodeSent =>
      'New verification code has been sent';

  @override
  String get login => 'Login';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get loginToYourAccount => 'Login to your Go Sport account';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get loginWithBiometric => 'Login with biometric';

  @override
  String get dontHaveAccount => 'Don\'t have an account? ';

  @override
  String get registerNow => 'Register now';

  @override
  String get logoutConfirmation => 'Logout Confirmation';

  @override
  String get logoutConfirmationMessage =>
      'Are you sure you want to logout from your account?';

  @override
  String get sessionTimeout => 'Session Timeout';

  @override
  String get sessionTimeoutMessage =>
      'Your session will expire soon due to inactivity. Would you like to extend your session?';

  @override
  String get logoutNow => 'Logout Now';

  @override
  String get extendSession => 'Extend Session';

  @override
  String get logout => 'Logout';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get enterPhoneToReset =>
      'Enter your phone number to reset your password';

  @override
  String get sendResetCode => 'Send Reset Code';

  @override
  String get resetCodeSent => 'Password reset code sent to your phone';

  @override
  String get enterResetCode => 'Enter Reset Code';

  @override
  String get enterNewPassword => 'Enter your new password';

  @override
  String get confirmNewPassword => 'Confirm new password';

  @override
  String get updatePassword => 'Update Password';

  @override
  String get passwordResetSuccess =>
      'Password reset successful! Please login with your new password.';

  @override
  String get backToLogin => 'Back to Login';

  @override
  String get createGroup => 'Create Group';

  @override
  String get chooseGroupSport => 'Choose sport';

  @override
  String get popularSports => 'Popular';

  @override
  String get allSports => 'All Sports';

  @override
  String get selected => 'Selected';

  @override
  String get basicInfo => 'Basic Information';

  @override
  String get groupName => 'Group Name';

  @override
  String get groupNameRequired => 'Group Name *';

  @override
  String get groupNameHint => 'E.g.: Hanoi Badminton Group';

  @override
  String get groupDescription => 'Group Description';

  @override
  String get groupDescriptionHint => 'Describe your group...';

  @override
  String get skillLevel => 'Skill Level';

  @override
  String get skillLevelRequired => 'Skill Level *';

  @override
  String get cityRequired => 'City *';

  @override
  String get cityHint => 'E.g.: Hanoi';

  @override
  String get district => 'District';

  @override
  String get districtHint => 'E.g.: Ba Dinh';

  @override
  String get locationRequired => 'Location *';

  @override
  String get locationHint => 'E.g.: ABC Badminton Court, 123 XYZ Street';

  @override
  String get groupSettings => 'Group Settings';

  @override
  String get maxMembers => 'Maximum Members';

  @override
  String get membershipFee => 'Membership Fee (VND/month)';

  @override
  String get privacy => 'Privacy';

  @override
  String get publicGroup => 'Public';

  @override
  String get privateGroup => 'Private';

  @override
  String get publicGroupDesc => 'Anyone can find and join the group';

  @override
  String get privateGroupDesc => 'Only joinable by invitation or request';

  @override
  String get groupRules => 'Group Rules';

  @override
  String get addRule => 'Add Rule';

  @override
  String get enterNewRule => 'Enter new rule...';

  @override
  String get back => 'Back';

  @override
  String get continueButton => 'Continue';

  @override
  String get finish => 'Finish';

  @override
  String get errorMinGroupName => 'Group name must be at least 3 characters';

  @override
  String get errorEnterGroupName => 'Please enter group name';

  @override
  String get errorSelectSkillLevel => 'Please select skill level';

  @override
  String get errorEnterCity => 'Please enter city';

  @override
  String get errorEnterLocation => 'Please enter location';

  @override
  String get sportFootball => 'Football';

  @override
  String get sportBadminton => 'Badminton';

  @override
  String get sportTennis => 'Tennis';

  @override
  String get sportPickleball => 'Pickleball';

  @override
  String get sportBasketball => 'Basketball';

  @override
  String get sportVolleyball => 'Volleyball';

  @override
  String get sportTableTennis => 'Table Tennis';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleModerator => 'Moderator';

  @override
  String get roleMember => 'Member';

  @override
  String get roleGuest => 'Guest';

  @override
  String get rolePending => 'Pending';

  @override
  String get groupCreationStep1 => 'Step 1: Choose Sport';

  @override
  String get groupCreationStep2 => 'Step 2: Group Information';

  @override
  String get groupCreationStep3 => 'Step 3: Settings and Rules';

  @override
  String get groupCreationComplete => 'Group created successfully!';

  @override
  String get groupCreationWelcome => 'Welcome to your new group!';

  @override
  String get helpGroupName =>
      'Group name will be displayed to all members. Choose a recognizable name that fits the sport.';

  @override
  String get helpGroupDescription =>
      'Brief description of the group, its goals and characteristics.';

  @override
  String get helpSkillLevel =>
      'Choose appropriate skill level to attract players of similar level.';

  @override
  String get helpLocation =>
      'Main location where the group usually plays. Can be changed later.';

  @override
  String get helpMembershipFee =>
      'Monthly membership fee (if any). Leave blank if group is free.';

  @override
  String get helpPrivacy =>
      'Public group: Anyone can find and join\nPrivate group: Join by invitation only';

  @override
  String groupNameSuggestionSport(String sport, String city) {
    return '$sport Group $city';
  }

  @override
  String groupNameSuggestionClub(String sport, String city) {
    return '$sport Club $city';
  }

  @override
  String groupNameSuggestionTeam(String sport, String city) {
    return '$sport Team $city';
  }

  @override
  String get tapToUse => 'Tap to use';

  @override
  String get nameSuggestions => 'Name Suggestions';

  @override
  String get errorGroupCreationFailed =>
      'Group creation failed. Please try again.';

  @override
  String get errorInvalidSportSelection => 'Please select a valid sport';

  @override
  String get errorNetworkConnection =>
      'Network connection error. Please check your connection and try again.';

  @override
  String get errorServerError => 'Server error. Please try again later.';

  @override
  String get errorPermissionDenied =>
      'You don\'t have permission to perform this action';

  @override
  String get errorGroupNotFound => 'Group not found';

  @override
  String get errorMemberNotFound => 'Member not found';
}
