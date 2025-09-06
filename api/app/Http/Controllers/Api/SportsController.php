<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Services\SportsConfigService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class SportsController extends Controller
{
    public function index(): JsonResponse
    {
        try {
            $sports = SportsConfigService::getAvailableSports();
            
            return response()->json([
                'success' => true,
                'data' => [
                    'sports' => $sports,
                    'popular' => SportsConfigService::getPopularSports(),
                    'categories' => SportsConfigService::getSportsByCategory()
                ]
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Không thể lấy danh sách môn thể thao',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function show(string $sportType): JsonResponse
    {
        try {
            $config = SportsConfigService::getSportConfig($sportType);
            
            if (!$config) {
                return response()->json([
                    'success' => false,
                    'message' => 'Môn thể thao không tồn tại'
                ], 404);
            }
            
            return response()->json([
                'success' => true,
                'data' => $config
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Không thể lấy thông tin môn thể thao',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function getDefaults(string $sportType): JsonResponse
    {
        try {
            $defaults = SportsConfigService::getSportDefaults($sportType);
            
            if (empty($defaults)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Môn thể thao không tồn tại'
                ], 404);
            }
            
            return response()->json([
                'success' => true,
                'data' => $defaults
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Không thể lấy cài đặt mặc định',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function getLocationSuggestions(string $sportType, Request $request): JsonResponse
    {
        try {
            $city = $request->query('city');
            $locations = SportsConfigService::getLocationSuggestions($sportType, $city);
            
            return response()->json([
                'success' => true,
                'data' => $locations
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Không thể lấy gợi ý địa điểm',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
