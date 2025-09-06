# Story Migration 4: Attendance and Real-time Features Migration

**Epic**: Riverpod to Cubit Architecture Migration  
**Story ID**: MIGRATION-4  
**Estimated Effort**: 2-3 sprints  
**Priority**: Critical  
**Dependencies**: MIGRATION-3 (Group Management System)  

## User Story

As a Vietnamese sports group member,  
I want attendance tracking to work exactly as before,  
So that my game coordination remains reliable during the architectural migration.

## Story Context

**Migration Phase**: Attendance and Real-time Migration (Week 7-8 of 10-week migration)  
**Risk Level**: Critical (affects core real-time coordination functionality)  
**Rollback Strategy**: Feature flag to revert to Riverpod attendance providers

## Acceptance Criteria

### AC1: AttendanceProvider to AttendanceCubit Migration
- [ ] Create `AttendanceCubit` in `features/attendance/presentation/viewmodels/attendance_cubit.dart`
- [ ] Create `AttendanceState` using Freezed with states: `initial, loading, loaded, error, submitting`
- [ ] Migrate attendance request creation and management
- [ ] Preserve Vietnamese notification timing and cultural patterns
- [ ] Maintain attendance deadline handling with Vietnam timezone (UTC+7)
- [ ] Register AttendanceCubit in GetIt container

### AC2: AttendanceResponse Provider to AttendanceResponseCubit Migration
- [ ] Create `AttendanceResponseCubit` in `features/attendance/presentation/viewmodels/attendance_response_cubit.dart`
- [ ] Create `AttendanceResponseState` using Freezed for response management
- [ ] Migrate member response functionality (✅ Có thể đến, ❌ Không thể đến)
- [ ] Preserve late response handling and automatic notifications
- [ ] Maintain Vietnamese response text and cultural messaging
- [ ] Keep offline response caching using Hive storage

### AC3: Real-time Attendance Updates Preservation
- [ ] Ensure real-time headcount updates work with new Cubit architecture  
- [ ] Maintain WebSocket/Server-Sent Events integration for live updates
- [ ] Preserve automatic UI refresh when other members respond
- [ ] Keep Vietnamese notification sounds and vibration patterns
- [ ] Maintain attendance status synchronization across multiple devices
- [ ] Ensure real-time updates work with Vietnam mobile network conditions

### AC4: Screen Updates to BlocBuilder Patterns
- [ ] Update `AttendanceRequestScreen` to use `BlocBuilder<AttendanceCubit, AttendanceState>`
- [ ] Update `AttendanceStatusScreen` to use `BlocBuilder<AttendanceResponseCubit, AttendanceResponseState>`
- [ ] Replace all attendance-related `Consumer` patterns with `BlocBuilder`
- [ ] Maintain identical Vietnamese UI rendering and response buttons
- [ ] Preserve Vietnamese headcount display and member status lists

### AC5: Vietnamese Notification Patterns Maintenance
- [ ] Ensure Vietnamese push notification content remains identical
- [ ] Preserve Vietnamese SMS notification formatting and timing
- [ ] Maintain cultural notification schedules (avoid Vietnamese meal times)
- [ ] Keep Vietnamese reminder message tone and frequency
- [ ] Preserve notification sound preferences for Vietnamese users
- [ ] Maintain Vietnamese timezone-aware notification scheduling

### AC6: Offline Attendance Caching with Hive
- [ ] Preserve existing Hive database schema for attendance responses
- [ ] Maintain offline response capability during network issues
- [ ] Keep attendance response sync when connectivity restored
- [ ] Preserve Vietnamese data encryption patterns in local storage
- [ ] Ensure offline attendance data survives app restart
- [ ] Maintain compatibility with existing Hive attendance data

## Integration Verification

### IV1: Real-time Attendance Updates Function Across All Group Members
- [ ] When member A responds, members B and C see update immediately
- [ ] Headcount changes reflect instantly across all connected devices
- [ ] Vietnamese member names and responses display correctly in real-time
- [ ] Network reconnection properly syncs missed attendance updates
- [ ] Multiple group attendance tracking works simultaneously

### IV2: Vietnamese Timezone Handling (UTC+7) Preserved
- [ ] Attendance deadlines respect Vietnamese timezone regardless of device settings
- [ ] Vietnamese date/time displays show correct local time
- [ ] Notification scheduling works correctly for Vietnamese users abroad
- [ ] Attendance request timing aligns with Vietnamese sports schedules
- [ ] Weekend vs weekday attendance patterns preserved for Vietnamese culture

### IV3: Offline Attendance Responses Sync Correctly
- [ ] Responses made offline are queued and sent when connectivity restored
- [ ] Offline responses don't duplicate when network returns
- [ ] Vietnamese response text preserved during offline/online transitions
- [ ] Attendance status shows correctly for offline responses
- [ ] Conflicting responses resolved properly when coming back online

## Technical Implementation Notes

### AttendanceState Design Pattern
```dart
@freezed
class AttendanceState with _$AttendanceState {
  const factory AttendanceState.initial() = _Initial;
  const factory AttendanceState.loading() = _Loading;
  const factory AttendanceState.loaded({
    required AttendanceRequest request,
    required List<AttendanceResponse> responses,
    required int headcount,
  }) = _Loaded;
  const factory AttendanceState.submitting() = _Submitting;
  const factory AttendanceState.error(String vietnameseMessage) = _Error;
}
```

### Real-time Integration with Cubit
```dart
class AttendanceCubit extends Cubit<AttendanceState> {
  StreamSubscription? _realtimeSubscription;
  
  void _listenToRealtimeUpdates(String requestId) {
    _realtimeSubscription = _websocketService
        .attendanceUpdates(requestId)
        .listen((update) {
      if (update.type == 'response_added') {
        _handleNewResponse(update.response);
      } else if (update.type == 'headcount_changed') {
        _updateHeadcount(update.newCount);
      }
    });
  }
  
  @override
  Future<void> close() {
    _realtimeSubscription?.cancel();
    return super.close();
  }
}
```

### Vietnamese Offline Storage Pattern
```dart
class AttendanceOfflineStorage {
  static const String _boxName = 'attendance_responses_vn';
  
  Future<void> storeOfflineResponse(AttendanceResponse response) async {
    final box = await Hive.openBox<AttendanceResponse>(_boxName);
    await box.put(response.id, response);
  }
  
  Future<List<AttendanceResponse>> getPendingResponses() async {
    final box = await Hive.openBox<AttendanceResponse>(_boxName);
    return box.values.where((r) => !r.synced).toList();
  }
}
```

## Vietnamese Cultural and Timing Considerations

### Notification Scheduling Patterns
- [ ] Avoid sending attendance notifications during Vietnamese dinner time (6-8 PM)
- [ ] Respect Vietnamese lunch break timing (11:30 AM - 1:30 PM)  
- [ ] Consider Vietnamese work schedules for weekday notifications
- [ ] Account for Vietnamese public holidays in notification scheduling
- [ ] Maintain Vietnamese weekend sports scheduling preferences

### Response Patterns and Etiquette
- [ ] Preserve Vietnamese politeness patterns in response messaging
- [ ] Maintain cultural context for late responses and apologies
- [ ] Keep Vietnamese group courtesy notifications for attendance changes
- [ ] Preserve cultural patterns for attendance commitment reliability
- [ ] Maintain Vietnamese sports group social dynamics in UI

### Vietnamese Sports Timing Culture
- [ ] Respect Vietnamese badminton court booking patterns (early morning/evening)
- [ ] Account for Vietnamese football field availability timing
- [ ] Maintain pickleball timing preferences for Vietnamese communities
- [ ] Preserve Vietnamese sports season considerations in attendance patterns

## Performance Requirements

### Real-time Update Performance
- [ ] Attendance updates appear within 2 seconds of member response
- [ ] Headcount calculations complete within 500ms
- [ ] Vietnamese text rendering maintains smooth performance during updates
- [ ] Real-time updates don't impact app battery life significantly
- [ ] Network efficiency maintained for Vietnamese mobile data conditions

### Offline Performance
- [ ] Offline response storage completes within 200ms
- [ ] App startup loads cached attendance data within 1 second
- [ ] Sync operation when network returns completes within 5 seconds
- [ ] Vietnamese text search in attendance history maintains speed

## Testing Requirements

### Unit Tests
- [ ] AttendanceCubit state transitions with Vietnamese data
- [ ] Real-time update handling with network simulation
- [ ] Offline storage and sync logic with Vietnamese responses
- [ ] Vietnamese timezone calculations and formatting
- [ ] Notification scheduling with Vietnamese cultural patterns

### Widget Tests
- [ ] AttendanceStatusScreen with Vietnamese member names and responses
- [ ] Real-time headcount updates rendering correctly
- [ ] Offline response indicators displaying properly
- [ ] Vietnamese response buttons (Có thể đến/Không thể đến)

### Integration Tests  
- [ ] Complete attendance request flow with Vietnamese group
- [ ] Real-time response synchronization across multiple test devices
- [ ] Offline response creation and online sync workflow
- [ ] Vietnamese notification delivery and response workflow
- [ ] Cross-platform attendance tracking (iOS/Android)

### Performance Tests
- [ ] Real-time update latency under Vietnam network conditions
- [ ] Memory usage during extended attendance tracking sessions
- [ ] Battery impact assessment for real-time attendance monitoring
- [ ] Vietnamese text rendering performance under load

## Definition of Done

- [ ] All acceptance criteria completed with Vietnamese cultural validation
- [ ] Integration verification tests pass with real Vietnamese attendance data
- [ ] Unit tests achieve >90% coverage for attendance-related Cubits
- [ ] Widget tests validate Vietnamese UI elements work correctly
- [ ] Real-time updates work reliably under Vietnamese network conditions
- [ ] Offline functionality preserves Vietnamese response data accurately
- [ ] Performance benchmarks maintained for attendance operations
- [ ] Vietnamese sports group leaders validate attendance workflow preservation
- [ ] Code review completed with focus on real-time architecture patterns
- [ ] QA sign-off on Vietnamese attendance coordination reliability

## Rollback Procedure

If critical attendance issues arise:

1. **Enable feature flag** `USE_RIVERPOD_ATTENDANCE = true`
2. **Verify real-time updates** work with existing system
3. **Test Vietnamese notifications** deliver correctly
4. **Check offline responses** sync properly
5. **Validate attendance timing** respects Vietnamese timezone
6. **Confirm headcount calculations** are accurate
7. **Test attendance request creation** with Vietnamese groups

## Vietnamese Sports Group Validation

- [ ] Test with actual Vietnamese badminton group during peak hours
- [ ] Validate with Vietnamese football group weekend coordination
- [ ] Verify with Vietnamese pickleball group weekday evening sessions
- [ ] Test attendance patterns during Vietnamese public holidays
- [ ] Validate notification timing with Vietnamese work schedule patterns

## Critical Success Metrics

- [ ] **Real-time Update Latency**: <2 seconds for Vietnamese mobile networks
- [ ] **Offline Response Success Rate**: >99% sync success when connectivity restored
- [ ] **Vietnamese Notification Delivery**: >95% successful delivery rate
- [ ] **Attendance Accuracy**: 100% headcount accuracy across all devices
- [ ] **Cultural Pattern Preservation**: 100% Vietnamese messaging and timing patterns maintained

## Next Story

**Story Migration 5**: Payment System Migration and Architecture Cleanup (final migration phase)