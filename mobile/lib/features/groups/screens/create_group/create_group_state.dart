import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/group.dart';

part 'create_group_state.freezed.dart';

/// State for Create Group View
@freezed
class CreateGroupViewState with _$CreateGroupViewState {
  /// Initial state
  const factory CreateGroupViewState.initial() = _Initial;

  /// Loading state - initializing form
  const factory CreateGroupViewState.loading() = _Loading;

  /// Ready state - form is ready for input
  const factory CreateGroupViewState.ready() = _Ready;

  /// Creating state - group creation in progress
  const factory CreateGroupViewState.creating({
    String? message,
    int? progress,
  }) = _Creating;

  /// Success state - group created successfully
  const factory CreateGroupViewState.success({
    required Group group,
    required String message,
  }) = _Success;

  /// Error state - something went wrong
  const factory CreateGroupViewState.error({
    required String message,
  }) = _Error;
}

/// Extensions for convenience
extension CreateGroupViewStateX on CreateGroupViewState {
  /// Whether the view is in loading state
  bool get isLoading => when(
    initial: () => false,
    loading: () => true,
    ready: () => false,
    creating: (_, __) => false,
    success: (_, __) => false,
    error: (_) => false,
  );

  /// Whether the view is ready for user input
  bool get isReady => when(
    initial: () => false,
    loading: () => false,
    ready: () => true,
    creating: (_, __) => false,
    success: (_, __) => false,
    error: (_) => false,
  );

  /// Whether group creation is in progress
  bool get isCreating => when(
    initial: () => false,
    loading: () => false,
    ready: () => false,
    creating: (_, __) => true,
    success: (_, __) => false,
    error: (_) => false,
  );

  /// Whether there's an error
  bool get hasError => when(
    initial: () => false,
    loading: () => false,
    ready: () => false,
    creating: (_, __) => false,
    success: (_, __) => false,
    error: (_) => true,
  );

  /// Whether group was created successfully
  bool get isSuccess => when(
    initial: () => false,
    loading: () => false,
    ready: () => false,
    creating: (_, __) => false,
    success: (_, __) => true,
    error: (_) => false,
  );
}