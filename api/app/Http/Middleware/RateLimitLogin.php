<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Symfony\Component\HttpFoundation\Response;

class RateLimitLogin
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        // Skip rate limiting in debug mode for development
        if (config('app.debug')) {
            return $next($request);
        }
        
        $key = $this->getRateLimitKey($request);
        $maxAttempts = 5; // Maximum 5 login attempts
        $windowMinutes = 15; // within 15 minutes
        
        $attempts = Cache::get($key, 0);
        
        if ($attempts >= $maxAttempts) {
            return response()->json([
                'success' => false,
                'message' => 'Quá nhiều lần đăng nhập thất bại. Vui lòng thử lại sau 15 phút.',
                'retry_after' => $windowMinutes * 60,
            ], 429);
        }
        
        $response = $next($request);
        
        // If login failed (401 status), increment attempts counter
        if ($response->status() === 401) {
            Cache::put($key, $attempts + 1, now()->addMinutes($windowMinutes));
        } elseif ($response->status() === 200) {
            // If login successful, clear the rate limit counter
            Cache::forget($key);
        }
        
        return $response;
    }
    
    /**
     * Get the rate limiting key for the request.
     */
    private function getRateLimitKey(Request $request): string
    {
        $phone = $request->input('phone', 'unknown');
        $ip = $request->ip();
        
        // Use both phone and IP to prevent abuse
        return 'login_attempts:' . md5($phone . '|' . $ip);
    }
}
