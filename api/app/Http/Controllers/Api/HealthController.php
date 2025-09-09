<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Traits\ApiResponseTrait;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Cache;

class HealthController extends Controller
{
    use ApiResponseTrait;
    public function check(): JsonResponse
    {
        $health = [
            'status' => 'OK',
            'timestamp' => now()->toISOString(),
            'timezone' => 'Asia/Ho_Chi_Minh',
            'locale' => 'vi_VN',
            'version' => config('app.version', '1.0.0'),
            'environment' => config('app.env'),
            'services' => []
        ];

        // Check database connection
        try {
            DB::connection()->getPdo();
            $health['services']['database'] = [
                'status' => 'connected',
                'type' => config('database.default'),
            ];
        } catch (\Exception $e) {
            $health['services']['database'] = [
                'status' => 'error',
                'message' => 'Database connection failed',
            ];
            $health['status'] = 'ERROR';
        }

        // Check cache connection (Redis or file)
        try {
            Cache::put('health_check', true, 10);
            $cacheWorks = Cache::get('health_check');
            $health['services']['cache'] = [
                'status' => $cacheWorks ? 'connected' : 'error',
                'driver' => config('cache.default'),
            ];
        } catch (\Exception $e) {
            $health['services']['cache'] = [
                'status' => 'error',
                'message' => 'Cache connection failed',
            ];
        }

        // Vietnamese system info
        $health['system'] = [
            'php_version' => PHP_VERSION,
            'laravel_version' => app()->version(),
            'memory_usage' => $this->formatBytes(memory_get_usage(true)),
            'server_time' => now('Asia/Ho_Chi_Minh')->format('Y-m-d H:i:s T'),
        ];

        $statusCode = $health['status'] === 'OK' ? 200 : 503;
        $message = $health['status'] === 'OK' ? 'Hệ thống hoạt động bình thường' : 'Hệ thống gặp sự cố';

        if ($health['status'] === 'OK') {
            return $this->successResponse($health, $message, $statusCode);
        } else {
            return $this->errorResponse($message, $health, $statusCode);
        }
    }

    private function formatBytes(int $bytes, int $precision = 2): string
    {
        $units = ['B', 'KB', 'MB', 'GB', 'TB'];
        
        for ($i = 0; $bytes > 1024 && $i < count($units) - 1; $i++) {
            $bytes /= 1024;
        }
        
        return round($bytes, $precision) . ' ' . $units[$i];
    }
}
