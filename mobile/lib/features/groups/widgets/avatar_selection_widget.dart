import 'package:flutter/material.dart';
import '../models/default_avatar.dart';
import '../services/image_upload_service.dart';
import '../../../core/dependency_injection/injection_container.dart';
import 'dart:io';

class AvatarSelectionWidget extends StatefulWidget {
  final String? selectedAvatarUrl;
  final String? uploadedImagePath;
  final String? sportType;
  final Function(String?) onAvatarSelected;
  final Function(String?) onImageUploaded;

  const AvatarSelectionWidget({
    super.key,
    this.selectedAvatarUrl,
    this.uploadedImagePath,
    this.sportType,
    required this.onAvatarSelected,
    required this.onImageUploaded,
  });

  @override
  State<AvatarSelectionWidget> createState() => _AvatarSelectionWidgetState();
}

class _AvatarSelectionWidgetState extends State<AvatarSelectionWidget> {
  final ImageUploadService _imageUploadService = getIt<ImageUploadService>();
  List<DefaultAvatar> _defaultAvatars = [];
  bool _isLoading = false;
  String? _uploadedImagePath;

  @override
  void initState() {
    super.initState();
    _uploadedImagePath = widget.uploadedImagePath;
    _loadDefaultAvatars();
  }

  Future<void> _loadDefaultAvatars() async {
    try {
      setState(() => _isLoading = true);
      final avatars = await _imageUploadService.getDefaultAvatars();
      setState(() {
        _defaultAvatars = avatars;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Không thể tải ảnh mặc định: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _pickAndUploadImage() async {
    try {
      final image = await ImageUploadService.showImagePickerDialog(context, _imageUploadService);
      if (image == null) return;

      if (!_imageUploadService.isValidImage(image)) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ảnh không hợp lệ. Vui lòng chọn ảnh JPG, PNG hoặc GIF dưới 5MB.'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      setState(() => _isLoading = true);

      final result = await _imageUploadService.uploadGroupAvatar(image);
      
      setState(() {
        _isLoading = false;
        _uploadedImagePath = image.path;
      });

      widget.onImageUploaded(result['url']);
      widget.onAvatarSelected(null); // Clear default avatar selection

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tải ảnh lên thành công!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi khi tải ảnh lên: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildCurrentAvatar() {
    Widget avatarWidget;
    bool hasImage = _uploadedImagePath != null || widget.selectedAvatarUrl != null;
    
    if (_uploadedImagePath != null) {
      avatarWidget = ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Image.file(
          File(_uploadedImagePath!),
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
      );
    } else if (widget.selectedAvatarUrl != null) {
      avatarWidget = ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Image.network(
          widget.selectedAvatarUrl!,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / 
                        loadingProgress.expectedTotalBytes!
                      : null,
                  strokeWidth: 2,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Icon(Icons.group, size: 40),
            );
          },
        ),
      );
    } else {
      avatarWidget = Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(40),
        ),
        child: const Icon(Icons.group, size: 40),
      );
    }

    return GestureDetector(
      onTap: hasImage ? _showImagePreview : null,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: avatarWidget,
          ),
          if (hasImage && !_isLoading)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(
                  Icons.zoom_in,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
          if (_isLoading)
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showImagePreview() {
    if (_uploadedImagePath == null && widget.selectedAvatarUrl == null) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black,
          child: Stack(
            children: [
              Center(
                child: _uploadedImagePath != null
                    ? Image.file(
                        File(_uploadedImagePath!),
                        fit: BoxFit.contain,
                      )
                    : Image.network(
                        widget.selectedAvatarUrl!,
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(color: Colors.white),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.white,
                              size: 48,
                            ),
                          );
                        },
                      ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              if (_uploadedImagePath != null)
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _pickAndUploadImage();
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text('Chỉnh sửa'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {
                            _uploadedImagePath = null;
                          });
                          widget.onImageUploaded(null);
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text('Xóa'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ảnh đại diện nhóm',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        
        // Current avatar display
        Center(
          child: _buildCurrentAvatar(),
        ),
        const SizedBox(height: 16),

        // Upload custom image button
        Center(
          child: OutlinedButton.icon(
            onPressed: _isLoading ? null : _pickAndUploadImage,
            icon: const Icon(Icons.camera_alt),
            label: const Text('Tải ảnh tùy chỉnh'),
          ),
        ),
        const SizedBox(height: 24),

        // Default avatars section
        Text(
          'Hoặc chọn ảnh mặc định',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 12),

        if (_isLoading && _defaultAvatars.isEmpty)
          const Center(child: CircularProgressIndicator())
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: _defaultAvatars.length,
            itemBuilder: (context, index) {
              final avatar = _defaultAvatars[index];
              final isSelected = widget.selectedAvatarUrl == avatar.url;
              final matchesSport = avatar.matchesSport(widget.sportType);

              return GestureDetector(
                onTap: () {
                  widget.onAvatarSelected(avatar.url);
                  widget.onImageUploaded(null); // Clear custom upload
                  setState(() => _uploadedImagePath = null);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected 
                          ? Theme.of(context).primaryColor 
                          : matchesSport 
                              ? Colors.grey[300]! 
                              : Colors.grey[200]!,
                      width: isSelected ? 3 : 1,
                    ),
                    color: matchesSport ? null : Colors.grey[100],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: Stack(
                      children: [
                        Image.network(
                          avatar.url,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.group, size: 30),
                            );
                          },
                        ),
                        if (!matchesSport)
                          Container(
                            color: Colors.white70,
                            child: const Center(
                              child: Icon(
                                Icons.lock_outline,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                          ),
                        if (isSelected)
                          Container(
                            color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                            child: Center(
                              child: Icon(
                                Icons.check_circle,
                                color: Theme.of(context).primaryColor,
                                size: 24,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}