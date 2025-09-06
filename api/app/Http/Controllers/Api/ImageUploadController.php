<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;

class ImageUploadController extends Controller
{
    /**
     * Upload and process group avatar image
     */
    public function uploadGroupAvatar(Request $request): JsonResponse
    {
        try {
            $validator = Validator::make($request->all(), [
                'image' => 'required|image|mimes:jpeg,png,jpg,gif|max:5120', // Max 5MB
                'group_id' => 'nullable|integer|exists:groups,id',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Dữ liệu không hợp lệ',
                    'errors' => $validator->errors()
                ], 422);
            }

            $image = $request->file('image');
            $groupId = $request->input('group_id');
            
            // Generate unique filename
            $filename = 'group_avatars/' . Str::random(32) . '.' . $image->getClientOriginalExtension();
            
            // Basic content filtering
            if ($this->containsInappropriateContent($image)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Ảnh không phù hợp. Vui lòng chọn ảnh khác.'
                ], 400);
            }
            
            // Store the image with automatic resizing
            $path = $image->storeAs('group_avatars', basename($filename), 'public');
            
            if (!$path) {
                return response()->json([
                    'success' => false,
                    'message' => 'Không thể lưu ảnh. Vui lòng thử lại.'
                ], 500);
            }
            
            return response()->json([
                'success' => true,
                'message' => 'Tải ảnh thành công',
                'data' => [
                    'url' => Storage::disk('public')->url($path),
                    'filename' => $path,
                    'size' => $image->getSize(),
                ]
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Lỗi khi tải ảnh: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Delete uploaded image
     */
    public function deleteImage(Request $request): JsonResponse
    {
        try {
            $validator = Validator::make($request->all(), [
                'filename' => 'required|string',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Tên file không hợp lệ',
                    'errors' => $validator->errors()
                ], 422);
            }

            $filename = $request->input('filename');
            
            // Security check - ensure filename is within allowed directory
            if (!str_starts_with($filename, 'group_avatars/')) {
                return response()->json([
                    'success' => false,
                    'message' => 'File không hợp lệ'
                ], 400);
            }

            // Delete image
            if (Storage::disk('public')->exists($filename)) {
                Storage::disk('public')->delete($filename);
            }

            return response()->json([
                'success' => true,
                'message' => 'Xóa ảnh thành công'
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Lỗi khi xóa ảnh: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get default avatar options
     */
    public function getDefaultAvatars(): JsonResponse
    {
        try {
            $defaultAvatars = [
                [
                    'id' => 'football',
                    'name' => 'Bóng đá',
                    'url' => '/images/default-avatars/football.png',
                    'sport' => 'football'
                ],
                [
                    'id' => 'badminton',
                    'name' => 'Cầu lông',
                    'url' => '/images/default-avatars/badminton.png',
                    'sport' => 'badminton'
                ],
                [
                    'id' => 'tennis',
                    'name' => 'Tennis',
                    'url' => '/images/default-avatars/tennis.png',
                    'sport' => 'tennis'
                ],
                [
                    'id' => 'pickleball',
                    'name' => 'Pickleball',
                    'url' => '/images/default-avatars/pickleball.png',
                    'sport' => 'pickleball'
                ],
                [
                    'id' => 'general-1',
                    'name' => 'Nhóm thể thao 1',
                    'url' => '/images/default-avatars/general-1.png',
                    'sport' => null
                ],
                [
                    'id' => 'general-2',
                    'name' => 'Nhóm thể thao 2',
                    'url' => '/images/default-avatars/general-2.png',
                    'sport' => null
                ],
            ];

            return response()->json([
                'success' => true,
                'data' => $defaultAvatars
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Lỗi khi lấy ảnh mặc định: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Basic content filtering
     */
    private function containsInappropriateContent($image): bool
    {
        // Basic checks for image appropriateness
        $size = $image->getSize();
        $mimeType = $image->getMimeType();
        
        // Check file size (too small might be inappropriate)
        if ($size < 1024) { // Less than 1KB
            return true;
        }
        
        // Check if it's a valid image mime type
        $allowedTypes = ['image/jpeg', 'image/png', 'image/jpg', 'image/gif'];
        if (!in_array($mimeType, $allowedTypes)) {
            return true;
        }
        
        return false;
    }
}
