import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/dependency_injection/injection_container.dart';
import '../../models/group.dart';
import '../../widgets/group_card_widget.dart';
import '../../widgets/sport_filter_widget.dart';
import 'groups_list_view_model.dart';
import 'groups_list_state.dart';

/// Groups List Screen for Vietnamese sports app
/// 
/// Displays user's groups with search, filter, and join functionality
/// Uses BlocBuilder pattern with Vietnamese localization
class GroupsListScreen extends StatelessWidget {
  const GroupsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.createGroupsListViewModel()..initialize(),
      child: const _GroupsListView(),
    );
  }
}

class _GroupsListView extends StatefulWidget {
  const _GroupsListView();

  @override
  State<_GroupsListView> createState() => _GroupsListViewState();
}

class _GroupsListViewState extends State<_GroupsListView> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupsListViewModel, GroupsListState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: (_) {},
          loaded: (_, __, ___, ____) {},
          error: (message, _) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 4),
              ),
            );
          },
          groupJoined: (message) {
            if (message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 3),
                ),
              );
            }
          },
          groupLeft: (message) {
            if (message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.orange,
                  duration: const Duration(seconds: 3),
                ),
              );
            }
          },
          navigateToCreateGroup: () {
            Navigator.pushNamed(context, '/groups/create');
          },
          navigateToGroupDetails: (groupId) {
            Navigator.pushNamed(context, '/groups/$groupId');
          },
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Nhóm của tôi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: const Color(0xFF4A90E2),
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  context.read<GroupsListViewModel>().navigateToCreateGroup();
                },
              ),
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () => _showSearchDialog(context),
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () => context.read<GroupsListViewModel>().refreshGroups(),
            child: state.when(
              initial: () => const Center(
                child: CircularProgressIndicator(),
              ),
              loading: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    if (message != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        message,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              loaded: (groups, searchQuery, sportTypeFilter, hasMore) =>
                  _buildGroupsList(context, groups, searchQuery, sportTypeFilter),
              error: (message, _) => _buildErrorState(context, message),
              groupJoined: (_) => const Center(
                child: CircularProgressIndicator(),
              ),
              groupLeft: (_) => const Center(
                child: CircularProgressIndicator(),
              ),
              navigateToCreateGroup: () => const Center(
                child: CircularProgressIndicator(),
              ),
              navigateToGroupDetails: (_) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<GroupsListViewModel>().navigateToCreateGroup();
            },
            backgroundColor: const Color(0xFF4A90E2),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        );
      },
    );
  }

  Widget _buildGroupsList(
    BuildContext context,
    List<Group> groups,
    String? searchQuery,
    String? sportTypeFilter,
  ) {
    if (groups.isEmpty) {
      return _buildEmptyState(context, searchQuery, sportTypeFilter);
    }

    return Column(
      children: [
        // Filter bar
        if (searchQuery?.isNotEmpty == true || sportTypeFilter?.isNotEmpty == true)
          _buildFilterBar(context, searchQuery, sportTypeFilter),
        
        // Groups list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final group = groups[index];
              return GroupCardWidget(
                group: group,
                onTap: () {
                  context.read<GroupsListViewModel>()
                      .navigateToGroupDetails(group.id.toString());
                },
                onLeave: () => _showLeaveGroupDialog(context, group),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterBar(
    BuildContext context,
    String? searchQuery,
    String? sportTypeFilter,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: const Color(0xFFF8F9FA),
      child: Row(
        children: [
          if (searchQuery?.isNotEmpty == true) ...[
            Chip(
              label: Text('Tìm kiếm: "$searchQuery"'),
              onDeleted: () {
                _searchController.clear();
                context.read<GroupsListViewModel>().searchGroups('');
              },
            ),
            const SizedBox(width: 8),
          ],
          if (sportTypeFilter?.isNotEmpty == true) ...[
            Chip(
              label: Text('Môn: $sportTypeFilter'),
              onDeleted: () {
                context.read<GroupsListViewModel>().filterBySportType(null);
              },
            ),
            const SizedBox(width: 8),
          ],
          TextButton(
            onPressed: () {
              _searchController.clear();
              context.read<GroupsListViewModel>().clearFilters();
            },
            child: const Text('Xóa bộ lọc'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    String? searchQuery,
    String? sportTypeFilter,
  ) {
    final hasFilters = searchQuery?.isNotEmpty == true || 
                      sportTypeFilter?.isNotEmpty == true;
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              hasFilters ? Icons.search_off : Icons.group_add,
              size: 64,
              color: const Color(0xFFE2E8F0),
            ),
            const SizedBox(height: 16),
            Text(
              hasFilters 
                  ? 'Không tìm thấy nhóm nào'
                  : 'Bạn chưa tham gia nhóm nào',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF475569),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              hasFilters
                  ? 'Thử thay đổi bộ lọc hoặc tìm kiếm khác'
                  : 'Tạo nhóm mới hoặc tham gia nhóm có sẵn',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF64748B),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            if (!hasFilters) ...[
              ElevatedButton.icon(
                onPressed: () {
                  context.read<GroupsListViewModel>().navigateToCreateGroup();
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  'Tạo nhóm mới',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A90E2),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => _showJoinGroupDialog(context),
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text('Tham gia nhóm'),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF4A90E2)),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ] else ...[
              TextButton(
                onPressed: () {
                  _searchController.clear();
                  context.read<GroupsListViewModel>().clearFilters();
                },
                child: const Text('Xóa bộ lọc'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Color(0xFFEF4444),
            ),
            const SizedBox(height: 16),
            const Text(
              'Có lỗi xảy ra',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF475569),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF64748B),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<GroupsListViewModel>().loadGroups();
              },
              icon: const Icon(Icons.refresh, color: Colors.white),
              label: const Text(
                'Thử lại',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A90E2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Tìm kiếm nhóm'),
        content: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Nhập tên nhóm...',
            prefixIcon: Icon(Icons.search),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              context.read<GroupsListViewModel>()
                  .searchGroups(_searchController.text);
              Navigator.pop(dialogContext);
            },
            child: const Text('Tìm kiếm'),
          ),
        ],
      ),
    );
  }

  void _showJoinGroupDialog(BuildContext context) {
    final codeController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Tham gia nhóm'),
        content: TextField(
          controller: codeController,
          decoration: const InputDecoration(
            hintText: 'Nhập mã mời nhóm...',
            prefixIcon: Icon(Icons.qr_code),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              if (codeController.text.isNotEmpty) {
                context.read<GroupsListViewModel>()
                    .joinGroupWithCode(codeController.text);
              }
              Navigator.pop(dialogContext);
            },
            child: const Text('Tham gia'),
          ),
        ],
      ),
    );
  }

  void _showLeaveGroupDialog(BuildContext context, Group group) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Rời khỏi nhóm'),
        content: Text('Bạn có chắc chắn muốn rời khỏi nhóm "${group.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              context.read<GroupsListViewModel>().leaveGroup(group.id.toString());
              Navigator.pop(dialogContext);
            },
            child: const Text(
              'Rời nhóm',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}