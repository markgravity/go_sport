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
            <!-- Warning Icon -->
            <div class="w-20 h-20 bg-orange-100 rounded-full flex items-center justify-center mx-auto mb-6">
                <svg class="w-10 h-10 text-orange-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                </svg>
            </div>

            <!-- Error Message -->
            <h1 class="text-2xl font-bold text-gray-900 mb-4">
                {{ $is_expired ? 'Lời mời đã hết hạn' : 'Lời mời không hợp lệ' }}
            </h1>
            <p class="text-gray-600 mb-6">{{ $error_message }}</p>

            <!-- Group Info (if available) -->
            @if($group)
                <div class="bg-gray-50 rounded-lg p-4 mb-6">
                    <h3 class="font-semibold text-gray-900 mb-2">{{ $group->name }}</h3>
                    <p class="text-sm text-gray-600">Nhóm {{ $group->sport_name }}</p>
                    @if($group->location)
                        <p class="text-sm text-gray-500 mt-1">{{ $group->location }}</p>
                    @endif
                </div>

                @if($is_expired && $invitation->expires_at)
                    <div class="bg-orange-50 border border-orange-200 rounded-lg p-4 mb-6">
                        <p class="text-sm text-orange-800">
                            Lời mời đã hết hạn vào {{ $invitation->expires_at->format('d/m/Y H:i') }}
                        </p>
                    </div>
                @endif
            @endif

            <!-- Actions -->
            <div class="space-y-3">
                @if($group)
                    <p class="text-sm text-gray-600 mb-4">
                        Bạn có thể liên hệ với người tạo nhóm để nhận lời mời mới.
                    </p>
                @endif
                
                <button onclick="history.back()" class="w-full bg-gray-100 hover:bg-gray-200 text-gray-700 font-semibold py-3 px-4 rounded-lg transition-colors">
                    ← Quay lại
                </button>
                <a href="/" class="block w-full bg-primary hover:bg-blue-600 text-white font-semibold py-3 px-4 rounded-lg transition-colors">
                    Về trang chủ GoSport
                </a>
            </div>
        </div>
    </div>
</body>
</html>