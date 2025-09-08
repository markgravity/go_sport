<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ $title }}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#3B82F6',
                        secondary: '#10B981',
                        accent: '#F59E0B'
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-gray-50 min-h-screen flex items-center justify-center">
    <div class="max-w-md mx-auto px-4">
        <div class="bg-white rounded-2xl shadow-xl p-8 text-center">
            <!-- Error Icon -->
            <div class="w-20 h-20 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-6">
                <svg class="w-10 h-10 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.962-.833-2.732 0L4.082 16.5c-.77.833.192 2.5 1.732 2.5z"></path>
                </svg>
            </div>

            <!-- Error Message -->
            <h1 class="text-2xl font-bold text-gray-900 mb-4">Lời mời không tồn tại</h1>
            <p class="text-gray-600 mb-6">Lời mời này không tồn tại hoặc đã bị xóa. Vui lòng kiểm tra lại liên kết hoặc liên hệ với người gửi lời mời.</p>

            <!-- Actions -->
            <div class="space-y-3">
                <button onclick="history.back()" class="w-full bg-gray-100 hover:bg-gray-200 text-gray-700 font-semibold py-3 px-4 rounded-lg transition-colors">
                    ← Quay lại
                </button>
                <a href="/" class="block w-full bg-primary hover:bg-blue-600 text-white font-semibold py-3 px-4 rounded-lg transition-colors">
                    Về trang chủ GoSport
                </a>
            </div>

            <!-- Debug Info (only in development) -->
            @if(config('app.debug'))
                <div class="mt-8 p-4 bg-gray-100 rounded-lg text-left">
                    <p class="text-xs text-gray-600 font-mono">Token: {{ $token }}</p>
                </div>
            @endif
        </div>
    </div>
</body>
</html>