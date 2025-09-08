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
    <style>
        .confetti {
            animation: confetti-fall 3s ease-out forwards;
        }
        
        @keyframes confetti-fall {
            0% {
                transform: translateY(-100vh) rotate(0deg);
                opacity: 1;
            }
            100% {
                transform: translateY(100vh) rotate(720deg);
                opacity: 0;
            }
        }
        
        .celebration {
            animation: celebration 0.6s ease-out;
        }
        
        @keyframes celebration {
            0% {
                transform: scale(0.8);
                opacity: 0;
            }
            50% {
                transform: scale(1.1);
            }
            100% {
                transform: scale(1);
                opacity: 1;
            }
        }
    </style>
</head>
<body class="bg-gradient-to-br from-green-50 to-blue-50 min-h-screen">
    <!-- Confetti Animation -->
    <div class="fixed inset-0 pointer-events-none overflow-hidden">
        <div class="confetti absolute top-0 left-1/4 w-2 h-2 bg-yellow-400 rounded-full" style="animation-delay: 0s;"></div>
        <div class="confetti absolute top-0 left-1/3 w-2 h-2 bg-red-400 rounded-full" style="animation-delay: 0.2s;"></div>
        <div class="confetti absolute top-0 left-1/2 w-2 h-2 bg-blue-400 rounded-full" style="animation-delay: 0.4s;"></div>
        <div class="confetti absolute top-0 left-2/3 w-2 h-2 bg-green-400 rounded-full" style="animation-delay: 0.6s;"></div>
        <div class="confetti absolute top-0 left-3/4 w-2 h-2 bg-purple-400 rounded-full" style="animation-delay: 0.8s;"></div>
    </div>

    <div class="min-h-screen flex items-center justify-center px-4">
        <div class="max-w-lg mx-auto">
            <div class="bg-white rounded-3xl shadow-2xl p-8 text-center celebration">
                <!-- Success Icon -->
                <div class="w-24 h-24 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-6">
                    <svg class="w-12 h-12 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                </div>

                <!-- Success Message -->
                <h1 class="text-3xl font-bold text-gray-900 mb-4">🎉 Chúc mừng!</h1>
                <p class="text-xl text-gray-700 mb-2">Bạn đã tham gia thành công</p>
                <h2 class="text-2xl font-bold text-primary mb-6">{{ $group->name }}</h2>

                <!-- Group Details -->
                <div class="bg-gradient-to-r from-blue-50 to-green-50 rounded-2xl p-6 mb-8">
                    <div class="flex items-center justify-center mb-4">
                        <div class="w-16 h-16 bg-gradient-to-br from-primary to-secondary rounded-2xl flex items-center justify-center">
                            @if($group->sport_type === 'badminton')
                                <span class="text-3xl">🏸</span>
                            @elseif($group->sport_type === 'tennis')
                                <span class="text-3xl">🎾</span>
                            @elseif($group->sport_type === 'football')
                                <span class="text-3xl">⚽</span>
                            @elseif($group->sport_type === 'basketball')
                                <span class="text-3xl">🏀</span>
                            @else
                                <span class="text-3xl">🏃</span>
                            @endif
                        </div>
                    </div>
                    <h3 class="font-semibold text-gray-900 mb-2">{{ $group->sport_name }}</h3>
                    @if($group->location)
                        <p class="text-gray-600 flex items-center justify-center">
                            <svg class="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M5.05 4.05a7 7 0 119.9 9.9L10 18.9l-4.95-4.95a7 7 0 010-9.9zM10 11a2 2 0 100-4 2 2 0 000 4z" clip-rule="evenodd"></path>
                            </svg>
                            {{ $group->location }}
                        </p>
                    @endif
                </div>

                <!-- Welcome Message -->
                <div class="bg-yellow-50 border border-yellow-200 rounded-xl p-4 mb-6">
                    <p class="text-yellow-800 text-sm">
                        Chào mừng bạn đến với nhóm! Bạn có thể bắt đầu tham gia các hoạt động và kết nối với các thành viên khác.
                    </p>
                </div>

                <!-- Next Steps -->
                <div class="text-left mb-8">
                    <h3 class="font-semibold text-gray-900 mb-4">Những bước tiếp theo:</h3>
                    <div class="space-y-3">
                        <div class="flex items-start space-x-3">
                            <div class="w-6 h-6 bg-primary rounded-full flex items-center justify-center flex-shrink-0 mt-0.5">
                                <span class="text-white text-xs font-bold">1</span>
                            </div>
                            <p class="text-gray-600 text-sm">Tải ứng dụng GoSport để nhận thông báo về các hoạt động</p>
                        </div>
                        <div class="flex items-start space-x-3">
                            <div class="w-6 h-6 bg-primary rounded-full flex items-center justify-center flex-shrink-0 mt-0.5">
                                <span class="text-white text-xs font-bold">2</span>
                            </div>
                            <p class="text-gray-600 text-sm">Xem lịch trình các buổi tập và tham gia</p>
                        </div>
                        <div class="flex items-start space-x-3">
                            <div class="w-6 h-6 bg-primary rounded-full flex items-center justify-center flex-shrink-0 mt-0.5">
                                <span class="text-white text-xs font-bold">3</span>
                            </div>
                            <p class="text-gray-600 text-sm">Kết nối với các thành viên khác trong nhóm</p>
                        </div>
                    </div>
                </div>

                <!-- Actions -->
                <div class="space-y-4">
                    <button onclick="openApp()" class="w-full bg-gradient-to-r from-primary to-blue-600 hover:from-blue-600 hover:to-blue-700 text-white font-semibold py-4 px-6 rounded-xl transition-all duration-200 transform hover:scale-[1.02] shadow-lg">
                        📱 Mở ứng dụng GoSport
                    </button>
                    
                    <div class="grid grid-cols-2 gap-3">
                        <button onclick="shareSuccess()" class="bg-green-100 hover:bg-green-200 text-green-700 font-semibold py-3 px-4 rounded-lg transition-colors text-sm">
                            📤 Chia sẻ
                        </button>
                        <a href="/" class="bg-gray-100 hover:bg-gray-200 text-gray-700 font-semibold py-3 px-4 rounded-lg transition-colors text-sm text-center">
                            🏠 Về trang chủ
                        </a>
                    </div>
                </div>

                <!-- Creator Thank You -->
                @if($creator)
                    <div class="mt-8 p-4 bg-blue-50 rounded-xl">
                        <p class="text-blue-800 text-sm">
                            Cảm ơn <strong>{{ $creator->display_name }}</strong> đã mời bạn tham gia!
                        </p>
                    </div>
                @endif
            </div>
        </div>
    </div>

    <script>
        // Open GoSport app or fallback to web version
        function openApp() {
            // Try to open the mobile app first
            const appUrl = 'gosport://group/{{ $group->id }}';
            const fallbackUrl = '/'; // Web app URL
            
            // Create a hidden iframe to trigger the app
            const iframe = document.createElement('iframe');
            iframe.style.display = 'none';
            iframe.src = appUrl;
            document.body.appendChild(iframe);
            
            // Fallback to web version after a short delay
            setTimeout(() => {
                window.location.href = fallbackUrl;
                document.body.removeChild(iframe);
            }, 2000);
        }

        // Share success
        function shareSuccess() {
            const text = `Tôi vừa tham gia nhóm {{ $group->sport_name }} "${{{ $group->name }}}" trên GoSport! 🎉`;
            
            if (navigator.share) {
                navigator.share({
                    title: 'Đã tham gia nhóm GoSport!',
                    text: text,
                    url: window.location.origin
                });
            } else if (navigator.clipboard) {
                navigator.clipboard.writeText(text).then(() => {
                    alert('Đã sao chép thông báo thành công!');
                });
            } else {
                // Fallback for older browsers
                const textarea = document.createElement('textarea');
                textarea.value = text;
                document.body.appendChild(textarea);
                textarea.select();
                document.execCommand('copy');
                document.body.removeChild(textarea);
                alert('Đã sao chép thông báo thành công!');
            }
        }

        // Add some dynamic effects
        document.addEventListener('DOMContentLoaded', function() {
            // Add more confetti after a delay
            setTimeout(() => {
                for (let i = 0; i < 10; i++) {
                    setTimeout(() => {
                        createConfetti();
                    }, i * 200);
                }
            }, 1000);
        });

        function createConfetti() {
            const colors = ['bg-red-400', 'bg-blue-400', 'bg-green-400', 'bg-yellow-400', 'bg-purple-400', 'bg-pink-400'];
            const confetti = document.createElement('div');
            confetti.className = `confetti absolute w-2 h-2 rounded-full ${colors[Math.floor(Math.random() * colors.length)]}`;
            confetti.style.left = Math.random() * 100 + '%';
            confetti.style.animationDelay = Math.random() * 2 + 's';
            document.body.appendChild(confetti);
            
            // Remove confetti after animation
            setTimeout(() => {
                document.body.removeChild(confetti);
            }, 3000);
        }
    </script>
</body>
</html>