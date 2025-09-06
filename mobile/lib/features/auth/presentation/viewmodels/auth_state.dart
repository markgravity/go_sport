import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/user_model.dart';
import '../../models/auth_tokens.dart';

part 'auth_state.freezed.dart';

/// Authentication state cho Go Sport app
/// 
/// Sử dụng Freezed để tạo immutable state classes với type safety
/// Bao gồm tất cả các trạng thái authentication cần thiết cho Vietnamese users
@freezed
class AuthState with _$AuthState {
  /// Trạng thái chưa đăng nhập - initial state
  const factory AuthState.unauthenticated() = _Unauthenticated;
  
  /// Trạng thái đang xử lý authentication với message tùy chọn
  /// 
  /// [message] - Thông báo loading tiếng Việt
  /// Ví dụ: "Đang gửi mã xác thực...", "Đang đăng nhập..."
  const factory AuthState.authenticating({
    String? message,
  }) = _Authenticating;
  
  /// Trạng thái đã đăng nhập thành công
  /// 
  /// [user] - Thông tin người dùng
  /// [tokens] - Firebase và Laravel tokens
  const factory AuthState.authenticated({
    required UserModel user,
    required AuthTokens tokens,
  }) = _Authenticated;
  
  /// Trạng thái yêu cầu xác thực số điện thoại Vietnamese
  /// 
  /// [phoneNumber] - Số điện thoại đã gửi mã xác thực
  /// [verificationId] - Firebase verification ID
  const factory AuthState.phoneVerificationRequired({
    required String phoneNumber,
    String? verificationId,
  }) = _PhoneVerificationRequired;
  
  /// Trạng thái lỗi với thông báo tiếng Việt
  /// 
  /// [message] - Thông báo lỗi tiếng Việt
  /// [errorCode] - Mã lỗi để xử lý cụ thể (optional)
  const factory AuthState.error({
    required String message,
    String? errorCode,
  }) = _AuthError;
  
  /// Trạng thái đang refresh token
  /// 
  /// [user] - User hiện tại (giữ nguyên)
  /// [tokens] - Tokens hiện tại (sẽ được cập nhật)
  const factory AuthState.refreshingToken({
    required UserModel user,
    required AuthTokens tokens,
  }) = _RefreshingToken;
}

/// Extension methods cho AuthState để tiện sử dụng
extension AuthStateExtensions on AuthState {
  /// Kiểm tra có đang loading không
  bool get isLoading => when(
    unauthenticated: () => false,
    authenticating: (_) => true,
    authenticated: (_, __) => false,
    phoneVerificationRequired: (_, __) => false,
    error: (_, __) => false,
    refreshingToken: (_, __) => true,
  );
  
  /// Kiểm tra đã authenticated chưa
  bool get isAuthenticated => when(
    unauthenticated: () => false,
    authenticating: (_) => false,
    authenticated: (_, __) => true,
    phoneVerificationRequired: (_, __) => false,
    error: (_, __) => false,
    refreshingToken: (_, __) => true, // Vẫn được coi là authenticated khi refresh
  );
  
  /// Kiểm tra có lỗi không
  bool get hasError => when(
    unauthenticated: () => false,
    authenticating: (_) => false,
    authenticated: (_, __) => false,
    phoneVerificationRequired: (_, __) => false,
    error: (_, __) => true,
    refreshingToken: (_, __) => false,
  );
  
  /// Lấy user hiện tại (nếu có)
  UserModel? get currentUser => when(
    unauthenticated: () => null,
    authenticating: (_) => null,
    authenticated: (user, _) => user,
    phoneVerificationRequired: (_, __) => null,
    error: (_, __) => null,
    refreshingToken: (user, _) => user,
  );
  
  /// Lấy tokens hiện tại (nếu có)
  AuthTokens? get currentTokens => when(
    unauthenticated: () => null,
    authenticating: (_) => null,
    authenticated: (_, tokens) => tokens,
    phoneVerificationRequired: (_, __) => null,
    error: (_, __) => null,
    refreshingToken: (_, tokens) => tokens,
  );
  
  /// Lấy error message (nếu có)
  String? get errorMessage => when(
    unauthenticated: () => null,
    authenticating: (_) => null,
    authenticated: (_, __) => null,
    phoneVerificationRequired: (_, __) => null,
    error: (message, _) => message,
    refreshingToken: (_, __) => null,
  );
  
  /// Lấy loading message (nếu có)
  String? get loadingMessage => when(
    unauthenticated: () => null,
    authenticating: (message) => message,
    authenticated: (_, __) => null,
    phoneVerificationRequired: (_, __) => null,
    error: (_, __) => null,
    refreshingToken: (_, __) => 'Đang làm mới phiên đăng nhập...',
  );
  
  /// Kiểm tra có cần xác thực phone không
  bool get requiresPhoneVerification => when(
    unauthenticated: () => false,
    authenticating: (_) => false,
    authenticated: (_, __) => false,
    phoneVerificationRequired: (_, __) => true,
    error: (_, __) => false,
    refreshingToken: (_, __) => false,
  );
  
  /// Lấy phone number đang xác thực (nếu có)
  String? get verifyingPhoneNumber => when(
    unauthenticated: () => null,
    authenticating: (_) => null,
    authenticated: (_, __) => null,
    phoneVerificationRequired: (phoneNumber, _) => phoneNumber,
    error: (_, __) => null,
    refreshingToken: (_, __) => null,
  );
}