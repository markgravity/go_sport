import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../core/network/api_client.dart';
import '../models/default_avatar.dart';

@injectable
class ImageUploadService {
  final ApiClient _apiClient;
  static const String _baseUrl = '/images';
  static final ImagePicker _picker = ImagePicker();
  
  ImageUploadService(this._apiClient);

  /// Pick image from gallery or camera
  Future<XFile?> pickImage({ImageSource source = ImageSource.gallery}) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      return image;
    } catch (e) {
      throw Exception('Không thể chọn ảnh: $e');
    }
  }

  /// Upload group avatar image
  Future<Map<String, dynamic>> uploadGroupAvatar(XFile image, {int? groupId}) async {
    try {
      // Create form data
      final formData = FormData();
      formData.files.add(MapEntry(
        'image',
        await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        ),
      ));
      
      if (groupId != null) {
        formData.fields.add(MapEntry('group_id', groupId.toString()));
      }

      final response = await _apiClient.post(
        '$_baseUrl/upload/group-avatar',
        data: formData,
        options: Options(
          headers: {'Content-Type': 'multipart/form-data'},
        ),
      );

      if (response.data['success'] == true) {
        return {
          'url': response.data['data']['url'],
          'filename': response.data['data']['filename'],
          'size': response.data['data']['size'],
        };
      } else {
        throw Exception('Upload failed: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Lỗi khi tải ảnh lên: $e');
    }
  }

  /// Delete uploaded image
  Future<void> deleteImage(String filename) async {
    try {
      final response = await _apiClient.delete(
        '$_baseUrl/delete',
        data: {'filename': filename},
      );

      if (response.data['success'] != true) {
        throw Exception('Delete failed: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Lỗi khi xóa ảnh: $e');
    }
  }

  /// Get default avatar options
  Future<List<DefaultAvatar>> getDefaultAvatars() async {
    try {
      final response = await _apiClient.get('$_baseUrl/default-avatars');

      if (response.data['success'] == true) {
        final List<dynamic> avatarsData = response.data['data'];
        return avatarsData.map((json) => DefaultAvatar.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load default avatars: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Lỗi khi tải ảnh mặc định: $e');
    }
  }

  /// Show image picker dialog
  static Future<XFile?> showImagePickerDialog(BuildContext context, ImageUploadService service) async {
    return showModalBottomSheet<XFile>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Chọn từ thư viện'),
                onTap: () async {
                  final navigator = Navigator.of(context);
                  navigator.pop();
                  final image = await service.pickImage(source: ImageSource.gallery);
                  navigator.pop(image);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Chụp ảnh mới'),
                onTap: () async {
                  final navigator = Navigator.of(context);
                  navigator.pop();
                  final image = await service.pickImage(source: ImageSource.camera);
                  navigator.pop(image);
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text('Hủy'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Validate image before upload
  bool isValidImage(XFile image) {
    // Check file size (max 5MB)
    final file = File(image.path);
    final sizeInBytes = file.lengthSync();
    final sizeInMB = sizeInBytes / (1024 * 1024);
    
    if (sizeInMB > 5) {
      return false;
    }

    // Check file extension
    final validExtensions = ['jpg', 'jpeg', 'png', 'gif'];
    final extension = image.path.split('.').last.toLowerCase();
    
    return validExtensions.contains(extension);
  }
}