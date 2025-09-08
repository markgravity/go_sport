<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ $title }}</title>
    <meta name="description" content="{{ $meta['description'] }}">
    
    <!-- Open Graph / Facebook -->
    <meta property="og:type" content="website">
    <meta property="og:title" content="{{ $meta['og_title'] }}">
    <meta property="og:description" content="{{ $meta['og_description'] }}">
    <meta property="og:image" content="{{ $meta['og_image'] }}">
    <meta property="og:url" content="{{ url()->current() }}">

    <!-- Twitter -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="{{ $meta['og_title'] }}">
    <meta name="twitter:description" content="{{ $meta['og_description'] }}">
    <meta name="twitter:image" content="{{ $meta['og_image'] }}">

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
        .sport-icon {
            width: 48px;
            height: 48px;
            background: linear-gradient(135deg, #3B82F6, #1E40AF);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: white;
        }
    </style>
</head>
<body class="bg-gray-50 min-h-screen">
    <!-- Header -->
    <header class="bg-white shadow-sm border-b border-gray-200">
        <div class="max-w-4xl mx-auto px-4 py-3">
            <div class="flex items-center justify-between">
                <div class="flex items-center space-x-3">
                    <div class="w-8 h-8 bg-primary rounded-lg flex items-center justify-center">
                        <span class="text-white font-bold text-sm">G</span>
                    </div>
                    <span class="font-semibold text-gray-900">GoSport</span>
                </div>
                <div class="text-sm text-gray-600">
                    Lời mời tham gia nhóm
                </div>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="max-w-4xl mx-auto px-4 py-8">
        <div class="bg-white rounded-2xl shadow-xl overflow-hidden">
            <!-- Hero Section -->
            <div class="relative bg-gradient-to-br from-blue-500 via-blue-600 to-blue-700 px-6 py-12 text-white">
                <div class="absolute inset-0 bg-black opacity-10"></div>
                <div class="relative z-10">
                    <div class="text-center mb-8">
                        <div class="sport-icon mx-auto mb-4">
                            @if($group->sport_type === 'badminton')
                                🏸
                            @elseif($group->sport_type === 'tennis')
                                🎾
                            @elseif($group->sport_type === 'football')
                                ⚽
                            @elseif($group->sport_type === 'basketball')
                                🏀
                            @else
                                🏃
                            @endif
                        </div>
                        <h1 class="text-3xl font-bold mb-2">{{ $group->name }}</h1>
                        <p class="text-blue-100 text-lg">Nhóm {{ $group->sport_name }}</p>
                        @if($group->location)
                            <p class="text-blue-200 mt-1 flex items-center justify-center">
                                <svg class="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M5.05 4.05a7 7 0 119.9 9.9L10 18.9l-4.95-4.95a7 7 0 010-9.9zM10 11a2 2 0 100-4 2 2 0 000 4z" clip-rule="evenodd"></path>
                                </svg>
                                {{ $group->location }}
                            </p>
                        @endif
                    </div>
                </div>
            </div>

            <!-- Group Information -->
            <div class="px-6 py-8">
                <div class="grid md:grid-cols-2 gap-8">
                    <!-- Left Column: Group Details -->
                    <div>
                        @if($group->description)
                            <div class="mb-6">
                                <h3 class="text-lg font-semibold text-gray-900 mb-3">Về nhóm này</h3>
                                <p class="text-gray-600 leading-relaxed">{{ $group->description }}</p>
                            </div>
                        @endif

                        <div class="space-y-4">
                            <div class="flex items-center space-x-3 p-3 bg-gray-50 rounded-lg">
                                <div class="w-10 h-10 bg-secondary/10 rounded-lg flex items-center justify-center">
                                    <svg class="w-5 h-5 text-secondary" fill="currentColor" viewBox="0 0 20 20">
                                        <path d="M13 6a3 3 0 11-6 0 3 3 0 016 0zM18 8a2 2 0 11-4 0 2 2 0 014 0zM14 15a4 4 0 00-8 0v3h8v-3z"></path>
                                    </svg>
                                </div>
                                <div>
                                    <p class="font-medium text-gray-900">{{ $member_count }} thành viên</p>
                                    <p class="text-sm text-gray-600">Đã tham gia nhóm</p>
                                </div>
                            </div>

                            <div class="flex items-center space-x-3 p-3 bg-gray-50 rounded-lg">
                                <div class="w-10 h-10 bg-accent/10 rounded-lg flex items-center justify-center">
                                    <svg class="w-5 h-5 text-accent" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd"></path>
                                    </svg>
                                </div>
                                <div>
                                    <p class="font-medium text-gray-900">Tạo {{ $group->created_at->format('d/m/Y') }}</p>
                                    <p class="text-sm text-gray-600">Ngày thành lập</p>
                                </div>
                            </div>

                            @if($invitation->expires_at)
                                <div class="flex items-center space-x-3 p-3 bg-orange-50 rounded-lg border border-orange-200">
                                    <div class="w-10 h-10 bg-orange-100 rounded-lg flex items-center justify-center">
                                        <svg class="w-5 h-5 text-orange-600" fill="currentColor" viewBox="0 0 20 20">
                                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-12a1 1 0 10-2 0v4a1 1 0 00.293.707l2.828 2.829a1 1 0 101.415-1.415L11 9.586V6z" clip-rule="evenodd"></path>
                                        </svg>
                                    </div>
                                    <div>
                                        <p class="font-medium text-orange-900">Hết hạn {{ $invitation->expires_at->format('d/m/Y H:i') }}</p>
                                        <p class="text-sm text-orange-700">Thời gian còn lại</p>
                                    </div>
                                </div>
                            @endif
                        </div>
                    </div>

                    <!-- Right Column: Invitation & Creator -->
                    <div>
                        <!-- Creator Info -->
                        <div class="mb-6 p-4 bg-blue-50 rounded-lg border border-blue-200">
                            <h3 class="text-lg font-semibold text-blue-900 mb-3">Người mời</h3>
                            <div class="flex items-center space-x-3">
                                <div class="w-12 h-12 bg-blue-200 rounded-full flex items-center justify-center overflow-hidden">
                                    @if($creator->avatar_url)
                                        <img src="{{ $creator->avatar_url }}" alt="{{ $creator->display_name }}" class="w-full h-full object-cover">
                                    @else
                                        <span class="text-blue-700 font-semibold text-lg">
                                            {{ substr($creator->display_name, 0, 1) }}
                                        </span>
                                    @endif
                                </div>
                                <div>
                                    <p class="font-semibold text-blue-900">{{ $creator->display_name }}</p>
                                    <p class="text-sm text-blue-700">Người tạo nhóm</p>
                                </div>
                            </div>
                        </div>

                        <!-- Join Action -->
                        <div class="space-y-4">
                            <div id="join-section">
                                <button id="join-btn" class="w-full bg-primary hover:bg-blue-600 text-white font-semibold py-4 px-6 rounded-xl transition-all duration-200 transform hover:scale-[1.02] shadow-lg hover:shadow-xl">
                                    <span class="flex items-center justify-center">
                                        <svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 20 20">
                                            <path fill-rule="evenodd" d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z" clip-rule="evenodd"></path>
                                        </svg>
                                        Tham gia nhóm
                                    </span>
                                </button>
                            </div>

                            <div id="auth-section" class="hidden">
                                <div class="text-center p-4 bg-yellow-50 rounded-lg border border-yellow-200">
                                    <p class="text-yellow-800 mb-3">Bạn cần đăng nhập để tham gia nhóm</p>
                                    <a href="{{ route('invite.register', ['token' => $invitation->token]) }}" 
                                       class="inline-block bg-yellow-600 hover:bg-yellow-700 text-white font-semibold py-2 px-4 rounded-lg transition-colors">
                                        Đăng ký / Đăng nhập
                                    </a>
                                </div>
                            </div>

                            <div id="member-section" class="hidden">
                                <div class="text-center p-4 bg-green-50 rounded-lg border border-green-200">
                                    <div class="flex items-center justify-center mb-2">
                                        <svg class="w-6 h-6 text-green-600 mr-2" fill="currentColor" viewBox="0 0 20 20">
                                            <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                                        </svg>
                                        <span class="text-green-800 font-semibold">Bạn đã là thành viên</span>
                                    </div>
                                    <p class="text-green-700 text-sm">Bạn đã tham gia nhóm này rồi</p>
                                </div>
                            </div>

                            <!-- Share Options -->
                            <div class="border-t pt-4 mt-6">
                                <p class="text-sm text-gray-600 mb-3">Chia sẻ lời mời này:</p>
                                <div class="flex space-x-2">
                                    <button onclick="copyInviteLink()" class="flex-1 bg-gray-100 hover:bg-gray-200 text-gray-700 py-2 px-3 rounded-lg text-sm transition-colors">
                                        📋 Sao chép link
                                    </button>
                                    <button onclick="shareToFacebook()" class="flex-1 bg-blue-100 hover:bg-blue-200 text-blue-700 py-2 px-3 rounded-lg text-sm transition-colors">
                                        📘 Facebook
                                    </button>
                                    <button onclick="shareToZalo()" class="flex-1 bg-blue-100 hover:bg-blue-200 text-blue-700 py-2 px-3 rounded-lg text-sm transition-colors">
                                        💬 Zalo
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Loading/Error Messages -->
        <div id="message-container" class="mt-4"></div>
    </main>

    <!-- Footer -->
    <footer class="mt-12 pb-8 text-center text-gray-500">
        <p class="mb-2">Được tạo bởi</p>
        <div class="flex items-center justify-center space-x-2">
            <div class="w-6 h-6 bg-primary rounded-md flex items-center justify-center">
                <span class="text-white font-bold text-xs">G</span>
            </div>
            <span class="font-semibold text-gray-700">GoSport</span>
        </div>
        <p class="text-sm mt-2">Kết nối đam mê thể thao</p>
    </footer>

    <script>
        // Global variables
        let invitationData = null;
        const token = '{{ $invitation->token }}';

        // Initialize page
        document.addEventListener('DOMContentLoaded', function() {
            loadInvitationData();
        });

        // Load invitation data
        async function loadInvitationData() {
            try {
                const response = await fetch(`/invite/${token}/data`);
                const data = await response.json();
                
                if (response.ok) {
                    invitationData = data;
                    updateUI(data);
                } else {
                    showError(data.message || 'Có lỗi xảy ra khi tải thông tin lời mời');
                }
            } catch (error) {
                showError('Không thể kết nối đến máy chủ');
            }
        }

        // Update UI based on user status
        function updateUI(data) {
            const joinSection = document.getElementById('join-section');
            const authSection = document.getElementById('auth-section');
            const memberSection = document.getElementById('member-section');
            
            // Hide all sections first
            joinSection.classList.add('hidden');
            authSection.classList.add('hidden');
            memberSection.classList.add('hidden');
            
            if (data.is_member) {
                memberSection.classList.remove('hidden');
            } else if (data.is_authenticated) {
                joinSection.classList.remove('hidden');
                setupJoinButton();
            } else {
                authSection.classList.remove('hidden');
            }
        }

        // Setup join button
        function setupJoinButton() {
            const joinBtn = document.getElementById('join-btn');
            joinBtn.addEventListener('click', handleJoinClick);
        }

        // Handle join button click
        async function handleJoinClick() {
            const joinBtn = document.getElementById('join-btn');
            const originalText = joinBtn.innerHTML;
            
            // Show loading state
            joinBtn.disabled = true;
            joinBtn.innerHTML = `
                <span class="flex items-center justify-center">
                    <svg class="animate-spin w-5 h-5 mr-2" fill="none" viewBox="0 0 24 24">
                        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                    </svg>
                    Đang tham gia...
                </span>
            `;

            try {
                const response = await fetch(`/invite/${token}/join`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || ''
                    }
                });
                
                const result = await response.json();
                
                if (result.success) {
                    showSuccess(result.message);
                    if (result.redirect) {
                        setTimeout(() => {
                            window.location.href = result.redirect;
                        }, 1500);
                    } else {
                        // Update UI to show member status
                        loadInvitationData();
                    }
                } else {
                    showError(result.message);
                    if (result.redirect) {
                        setTimeout(() => {
                            window.location.href = result.redirect;
                        }, 2000);
                    }
                }
            } catch (error) {
                showError('Có lỗi xảy ra khi tham gia nhóm');
            } finally {
                joinBtn.disabled = false;
                joinBtn.innerHTML = originalText;
            }
        }

        // Copy invite link
        function copyInviteLink() {
            const url = window.location.href;
            navigator.clipboard.writeText(url).then(() => {
                showSuccess('Đã sao chép link lời mời!', 2000);
            }).catch(() => {
                showError('Không thể sao chép link');
            });
        }

        // Share to Facebook
        function shareToFacebook() {
            const url = encodeURIComponent(window.location.href);
            const text = encodeURIComponent(`Tham gia nhóm {{ $group->sport_name }} "${{{ $group->name }}}" trên GoSport!`);
            window.open(`https://www.facebook.com/sharer/sharer.php?u=${url}&quote=${text}`, '_blank');
        }

        // Share to Zalo
        function shareToZalo() {
            const url = encodeURIComponent(window.location.href);
            const text = encodeURIComponent(`Tham gia nhóm {{ $group->sport_name }} "${{{ $group->name }}}" trên GoSport!`);
            window.open(`https://zalo.me/share?url=${url}&text=${text}`, '_blank');
        }

        // Show success message
        function showSuccess(message, duration = 4000) {
            showMessage(message, 'success', duration);
        }

        // Show error message
        function showError(message, duration = 4000) {
            showMessage(message, 'error', duration);
        }

        // Show message
        function showMessage(message, type, duration) {
            const container = document.getElementById('message-container');
            const bgColor = type === 'success' ? 'bg-green-50 border-green-200' : 'bg-red-50 border-red-200';
            const textColor = type === 'success' ? 'text-green-800' : 'text-red-800';
            const iconColor = type === 'success' ? 'text-green-600' : 'text-red-600';
            const icon = type === 'success' 
                ? `<svg class="w-5 h-5 ${iconColor}" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path></svg>`
                : `<svg class="w-5 h-5 ${iconColor}" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"></path></svg>`;
            
            const messageEl = document.createElement('div');
            messageEl.className = `p-4 rounded-lg border ${bgColor} ${textColor} flex items-center space-x-2`;
            messageEl.innerHTML = `${icon}<span>${message}</span>`;
            
            container.innerHTML = '';
            container.appendChild(messageEl);
            
            setTimeout(() => {
                messageEl.style.opacity = '0';
                messageEl.style.transform = 'translateY(-10px)';
                setTimeout(() => {
                    container.removeChild(messageEl);
                }, 300);
            }, duration);
        }
    </script>
</body>
</html>