// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Go Sport';

  @override
  String get homeTab => 'Trang chủ';

  @override
  String get groupsTab => 'Nhóm';

  @override
  String get attendanceTab => 'Điểm danh';

  @override
  String get paymentsTab => 'Thanh toán';

  @override
  String get profileTab => 'Hồ sơ';

  @override
  String get welcomeMessage => 'Chào mừng đến với Go Sport!';

  @override
  String get loading => 'Đang tải...';

  @override
  String get error => 'Có lỗi xảy ra';

  @override
  String get retry => 'Thử lại';

  @override
  String get cancel => 'Hủy';

  @override
  String get confirm => 'Xác nhận';

  @override
  String get registerAccount => 'Đăng ký tài khoản';

  @override
  String get createGoSportAccount => 'Tạo tài khoản Go Sport';

  @override
  String get enterInfoToRegister => 'Nhập thông tin để tạo tài khoản mới';

  @override
  String get yourName => 'Tên của bạn';

  @override
  String get namePlaceholder => 'Nguyễn Văn A';

  @override
  String get phoneNumber => 'Số điện thoại';

  @override
  String get password => 'Mật khẩu';

  @override
  String get newPassword => 'Mật khẩu mới';

  @override
  String get confirmPassword => 'Xác nhận mật khẩu';

  @override
  String get enterPassword => 'Nhập mật khẩu';

  @override
  String get reenterPassword => 'Nhập lại mật khẩu';

  @override
  String get favoriteSports => 'Môn thể thao yêu thích (tùy chọn)';

  @override
  String get sendVerificationCode => 'Gửi mã xác thực';

  @override
  String get agreeToTerms => 'Bằng cách đăng ký, bạn đồng ý với ';

  @override
  String get termsOfService => 'Điều khoản sử dụng';

  @override
  String get and => ' và ';

  @override
  String get privacyPolicy => 'Chính sách bảo mật';

  @override
  String get verifyPhoneNumber => 'Xác thực số điện thoại';

  @override
  String get enterVerificationCode => 'Nhập mã xác thực';

  @override
  String get codeSentTo => 'Chúng tôi đã gửi mã xác thực 6 số đến';

  @override
  String get verify => 'Xác thực';

  @override
  String get didNotReceiveCode => 'Không nhận được mã? ';

  @override
  String get resend => 'Gửi lại';

  @override
  String resendAfter(int seconds) {
    return 'Gửi lại sau ${seconds}s';
  }

  @override
  String get codeValidInfo =>
      'Mã xác thực có hiệu lực trong 5 phút. Kiểm tra hộp thư spam nếu không thấy tin nhắn.';

  @override
  String carrier(String carrier) {
    return 'Nhà mạng: $carrier';
  }

  @override
  String get errorEnterName => 'Vui lòng nhập tên của bạn';

  @override
  String get errorEnterPhone => 'Vui lòng nhập số điện thoại';

  @override
  String get errorPhoneTooShort => 'Số điện thoại quá ngắn';

  @override
  String get errorPhoneTooLong => 'Số điện thoại quá dài';

  @override
  String get errorInvalidVietnamesePhone =>
      'Số điện thoại không đúng định dạng Việt Nam';

  @override
  String get errorEnterPassword => 'Vui lòng nhập mật khẩu';

  @override
  String get errorPasswordTooShort => 'Mật khẩu phải có ít nhất 8 ký tự';

  @override
  String get errorConfirmPassword => 'Vui lòng xác nhận mật khẩu';

  @override
  String get errorPasswordMismatch => 'Mật khẩu xác nhận không khớp';

  @override
  String get errorEnterFullCode => 'Vui lòng nhập đầy đủ 6 số';

  @override
  String get unknownCarrier => 'Không xác định';

  @override
  String successRegistration(String name) {
    return 'Đăng ký thành công! Chào mừng $name';
  }

  @override
  String get successVerificationCodeSent => 'Mã xác thực mới đã được gửi';

  @override
  String get login => 'Đăng nhập';

  @override
  String get welcomeBack => 'Chào mừng trở lại';

  @override
  String get loginToYourAccount => 'Đăng nhập vào tài khoản Go Sport của bạn';

  @override
  String get rememberMe => 'Ghi nhớ đăng nhập';

  @override
  String get forgotPassword => 'Quên mật khẩu?';

  @override
  String get loginWithBiometric => 'Đăng nhập bằng sinh trắc học';

  @override
  String get dontHaveAccount => 'Chưa có tài khoản? ';

  @override
  String get registerNow => 'Đăng ký ngay';

  @override
  String get logoutConfirmation => 'Xác nhận đăng xuất';

  @override
  String get logoutConfirmationMessage =>
      'Bạn có chắc chắn muốn đăng xuất khỏi tài khoản?';

  @override
  String get sessionTimeout => 'Phiên làm việc hết hạn';

  @override
  String get sessionTimeoutMessage =>
      'Phiên làm việc của bạn sẽ hết hạn do không hoạt động. Bạn có muốn gia hạn phiên làm việc?';

  @override
  String get logoutNow => 'Đăng xuất ngay';

  @override
  String get extendSession => 'Gia hạn phiên';

  @override
  String get logout => 'Đăng xuất';

  @override
  String get resetPassword => 'Đặt Lại Mật Khẩu';

  @override
  String get enterPhoneToReset => 'Nhập số điện thoại để đặt lại mật khẩu';

  @override
  String get sendResetCode => 'Gửi Mã Đặt Lại';

  @override
  String get resetCodeSent =>
      'Mã đặt lại mật khẩu đã được gửi đến số điện thoại của bạn';

  @override
  String get enterResetCode => 'Nhập Mã Đặt Lại';

  @override
  String get enterNewPassword => 'Nhập mật khẩu mới';

  @override
  String get confirmNewPassword => 'Xác nhận mật khẩu mới';

  @override
  String get updatePassword => 'Cập Nhật Mật Khẩu';

  @override
  String get passwordResetSuccess =>
      'Đặt lại mật khẩu thành công! Vui lòng đăng nhập với mật khẩu mới.';

  @override
  String get backToLogin => 'Trở Về Đăng Nhập';

  @override
  String get createGroup => 'Tạo Nhóm';

  @override
  String get chooseGroupSport => 'Chọn môn thể thao';

  @override
  String get popularSports => 'Phổ biến';

  @override
  String get allSports => 'Tất cả môn thể thao';

  @override
  String get selected => 'Đã chọn';

  @override
  String get basicInfo => 'Thông tin cơ bản';

  @override
  String get groupName => 'Tên nhóm';

  @override
  String get groupNameRequired => 'Tên nhóm *';

  @override
  String get groupNameHint => 'VD: Nhóm cầu lông Hà Nội';

  @override
  String get groupDescription => 'Mô tả nhóm';

  @override
  String get groupDescriptionHint => 'Mô tả về nhóm của bạn...';

  @override
  String get skillLevel => 'Trình độ';

  @override
  String get skillLevelRequired => 'Trình độ *';

  @override
  String get cityRequired => 'Thành phố *';

  @override
  String get cityHint => 'VD: Hà Nội';

  @override
  String get district => 'Quận/Huyện';

  @override
  String get districtHint => 'VD: Ba Đình';

  @override
  String get locationRequired => 'Địa điểm *';

  @override
  String get locationHint => 'VD: Sân cầu lông ABC, 123 Đường XYZ';

  @override
  String get groupSettings => 'Cài đặt nhóm';

  @override
  String get maxMembers => 'Số thành viên tối đa';

  @override
  String get membershipFee => 'Phí thành viên (VND/tháng)';

  @override
  String get privacy => 'Quyền riêng tư';

  @override
  String get publicGroup => 'Công khai';

  @override
  String get privateGroup => 'Riêng tư';

  @override
  String get publicGroupDesc => 'Mọi người có thể tìm thấy và tham gia nhóm';

  @override
  String get privateGroupDesc =>
      'Chỉ có thể tham gia bằng lời mời hoặc yêu cầu';

  @override
  String get groupRules => 'Nội quy nhóm';

  @override
  String get addRule => 'Thêm quy tắc';

  @override
  String get enterNewRule => 'Nhập quy tắc mới...';

  @override
  String get back => 'Trở lại';

  @override
  String get continueButton => 'Tiếp tục';

  @override
  String get finish => 'Hoàn thành';

  @override
  String get errorMinGroupName => 'Tên nhóm phải có ít nhất 3 ký tự';

  @override
  String get errorEnterGroupName => 'Vui lòng nhập tên nhóm';

  @override
  String get errorSelectSkillLevel => 'Vui lòng chọn trình độ';

  @override
  String get errorEnterCity => 'Vui lòng nhập thành phố';

  @override
  String get errorEnterLocation => 'Vui lòng nhập địa điểm';

  @override
  String get sportFootball => 'Bóng đá';

  @override
  String get sportBadminton => 'Cầu lông';

  @override
  String get sportTennis => 'Tennis';

  @override
  String get sportPickleball => 'Pickleball';

  @override
  String get sportBasketball => 'Bóng rổ';

  @override
  String get sportVolleyball => 'Bóng chuyền';

  @override
  String get sportTableTennis => 'Bóng bàn';

  @override
  String get roleAdmin => 'Trưởng nhóm';

  @override
  String get roleModerator => 'Phó nhóm';

  @override
  String get roleMember => 'Thành viên';

  @override
  String get roleGuest => 'Khách';

  @override
  String get rolePending => 'Chờ duyệt';

  @override
  String get groupCreationStep1 => 'Bước 1: Chọn môn thể thao';

  @override
  String get groupCreationStep2 => 'Bước 2: Thông tin nhóm';

  @override
  String get groupCreationStep3 => 'Bước 3: Cài đặt và quy tắc';

  @override
  String get groupCreationComplete => 'Tạo nhóm thành công!';

  @override
  String get groupCreationWelcome => 'Chào mừng bạn đến với nhóm mới!';

  @override
  String get helpGroupName =>
      'Tên nhóm sẽ hiển thị cho tất cả thành viên. Hãy chọn tên dễ nhận biết và phù hợp với môn thể thao.';

  @override
  String get helpGroupDescription =>
      'Mô tả ngắn gọn về nhóm, mục tiêu và đặc điểm của nhóm.';

  @override
  String get helpSkillLevel =>
      'Chọn trình độ phù hợp để thu hút những người chơi cùng trình độ.';

  @override
  String get helpLocation =>
      'Địa điểm chính nơi nhóm thường hoạt động. Có thể thay đổi sau này.';

  @override
  String get helpMembershipFee =>
      'Phí thành viên hàng tháng (nếu có). Để trống nếu nhóm miễn phí.';

  @override
  String get helpPrivacy =>
      'Nhóm công khai: Ai cũng có thể tìm thấy và tham gia\nNhóm riêng tư: Chỉ tham gia qua lời mời';

  @override
  String groupNameSuggestionSport(String sport, String city) {
    return 'Nhóm $sport $city';
  }

  @override
  String groupNameSuggestionClub(String sport, String city) {
    return 'CLB $sport $city';
  }

  @override
  String groupNameSuggestionTeam(String sport, String city) {
    return 'Đội $sport $city';
  }

  @override
  String get tapToUse => 'Nhấn để sử dụng';

  @override
  String get nameSuggestions => 'Gợi ý tên nhóm';

  @override
  String get errorGroupCreationFailed => 'Tạo nhóm thất bại. Vui lòng thử lại.';

  @override
  String get errorInvalidSportSelection =>
      'Vui lòng chọn một môn thể thao hợp lệ';

  @override
  String get errorNetworkConnection =>
      'Lỗi kết nối mạng. Vui lòng kiểm tra kết nối và thử lại.';

  @override
  String get errorServerError => 'Lỗi máy chủ. Vui lòng thử lại sau.';

  @override
  String get errorPermissionDenied =>
      'Bạn không có quyền thực hiện hành động này';

  @override
  String get errorGroupNotFound => 'Không tìm thấy nhóm';

  @override
  String get errorMemberNotFound => 'Không tìm thấy thành viên';
}
