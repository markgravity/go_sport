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
<body class="bg-gradient-to-br from-blue-50 to-indigo-50 min-h-screen">
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
                    Đăng ký để tham gia
                </div>
            </div>
        </div>
    </header>

    <div class="min-h-[calc(100vh-80px)] flex items-center justify-center px-4 py-8">
        <div class="max-w-lg mx-auto">
            <div class="bg-white rounded-3xl shadow-2xl overflow-hidden">
                <!-- Invitation Preview -->
                <div class="bg-gradient-to-r from-primary to-blue-600 px-6 py-8 text-white">
                    <div class="text-center">
                        <div class="w-16 h-16 bg-white bg-opacity-20 rounded-2xl flex items-center justify-center mx-auto mb-4">
                            @if($group->sport_type === 'badminton')
                                <span class="text-2xl">🏸</span>
                            @elseif($group->sport_type === 'tennis')
                                <span class="text-2xl">🎾</span>
                            @elseif($group->sport_type === 'football')
                                <span class="text-2xl">⚽</span>
                            @elseif($group->sport_type === 'basketball')
                                <span class="text-2xl">🏀</span>
                            @else
                                <span class="text-2xl">🏃</span>
                            @endif
                        </div>
                        <h1 class="text-2xl font-bold mb-2">{{ $group->name }}</h1>
                        <p class="text-blue-100">Nhóm {{ $group->sport_name }}</p>
                        @if($group->location)
                            <p class="text-blue-200 text-sm mt-1">📍 {{ $group->location }}</p>
                        @endif
                    </div>
                </div>

                <!-- Registration Form -->
                <div class="px-6 py-8">
                    <div class="text-center mb-6">
                        <h2 class="text-2xl font-bold text-gray-900 mb-2">Tạo tài khoản</h2>
                        <p class="text-gray-600">Đăng ký để tham gia nhóm và khám phá GoSport</p>
                    </div>

                    <!-- Auth Options -->
                    <div class="space-y-4">
                        <!-- Phone Registration -->
                        <div class="p-6 border-2 border-primary border-opacity-20 rounded-2xl">
                            <div class="flex items-center mb-4">
                                <div class="w-10 h-10 bg-primary bg-opacity-10 rounded-lg flex items-center justify-center mr-3">
                                    <svg class="w-5 h-5 text-primary" fill="currentColor" viewBox="0 0 20 20">
                                        <path d="M2 3a1 1 0 011-1h2.153a1 1 0 01.986.836l.74 4.435a1 1 0 01-.54 1.06l-1.548.773a11.037 11.037 0 006.105 6.105l.774-1.548a1 1 0 011.059-.54l4.435.74a1 1 0 01.836.986V17a1 1 0 01-1 1h-2C7.82 18 2 12.18 2 5V3z"></path>
                                    </svg>
                                </div>
                                <div>
                                    <h3 class="font-semibold text-gray-900">Đăng ký bằng số điện thoại</h3>
                                    <p class="text-sm text-gray-600">Nhanh chóng và an toàn</p>
                                </div>
                            </div>
                            
                            <form id="phone-form" class="space-y-4">
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Số điện thoại</label>
                                    <div class="relative">
                                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                            <span class="text-gray-500 text-sm">+84</span>
                                        </div>
                                        <input type="tel" id="phone" name="phone" 
                                               class="block w-full pl-12 pr-3 py-3 border border-gray-300 rounded-lg focus:ring-primary focus:border-primary" 
                                               placeholder="901234567">
                                    </div>
                                </div>
                                
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Tên hiển thị</label>
                                    <input type="text" id="display_name" name="display_name" 
                                           class="block w-full px-3 py-3 border border-gray-300 rounded-lg focus:ring-primary focus:border-primary" 
                                           placeholder="Nhập tên của bạn">
                                </div>

                                <button type="submit" class="w-full bg-primary hover:bg-blue-600 text-white font-semibold py-3 px-4 rounded-lg transition-colors">
                                    Tiếp tục với số điện thoại
                                </button>
                            </form>
                        </div>

                        <!-- Divider -->
                        <div class="relative">
                            <div class="absolute inset-0 flex items-center">
                                <div class="w-full border-t border-gray-300"></div>
                            </div>
                            <div class="relative flex justify-center text-sm">
                                <span class="px-2 bg-white text-gray-500">hoặc</span>
                            </div>
                        </div>

                        <!-- Existing Account -->
                        <div class="p-6 bg-gray-50 rounded-2xl">
                            <div class="text-center">
                                <h3 class="font-semibold text-gray-900 mb-2">Đã có tài khoản?</h3>
                                <p class="text-gray-600 text-sm mb-4">Đăng nhập để tham gia nhóm</p>
                                <button onclick="showLoginForm()" class="w-full bg-gray-100 hover:bg-gray-200 text-gray-700 font-semibold py-3 px-4 rounded-lg transition-colors">
                                    Đăng nhập
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Terms -->
                    <div class="mt-6 text-center">
                        <p class="text-xs text-gray-500">
                            Bằng cách đăng ký, bạn đồng ý với 
                            <a href="#" class="text-primary hover:underline">Điều khoản sử dụng</a> 
                            và 
                            <a href="#" class="text-primary hover:underline">Chính sách bảo mật</a> 
                            của GoSport.
                        </p>
                    </div>
                </div>
            </div>

            <!-- Back to Invitation -->
            <div class="text-center mt-6">
                <a href="{{ route('invite.show', ['token' => $token]) }}" 
                   class="text-gray-600 hover:text-gray-800 text-sm">
                    ← Quay lại lời mời
                </a>
            </div>
        </div>
    </div>

    <!-- Login Modal -->
    <div id="login-modal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center px-4 z-50">
        <div class="bg-white rounded-2xl p-6 max-w-md w-full">
            <div class="flex justify-between items-center mb-6">
                <h3 class="text-xl font-bold text-gray-900">Đăng nhập</h3>
                <button onclick="hideLoginForm()" class="text-gray-400 hover:text-gray-600">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                </button>
            </div>
            
            <form id="login-form" class="space-y-4">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Số điện thoại</label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <span class="text-gray-500 text-sm">+84</span>
                        </div>
                        <input type="tel" id="login-phone" name="phone" 
                               class="block w-full pl-12 pr-3 py-3 border border-gray-300 rounded-lg focus:ring-primary focus:border-primary" 
                               placeholder="901234567">
                    </div>
                </div>
                
                <button type="submit" class="w-full bg-primary hover:bg-blue-600 text-white font-semibold py-3 px-4 rounded-lg transition-colors">
                    Gửi mã xác thực
                </button>
            </form>
        </div>
    </div>

    <!-- Message Container -->
    <div id="message-container" class="fixed top-4 left-1/2 transform -translate-x-1/2 z-50"></div>

    <script>
        const token = '{{ $token }}';
        
        // Registration form handler
        document.getElementById('phone-form').addEventListener('submit', async function(e) {
            e.preventDefault();
            
            const formData = new FormData(this);
            const phone = formData.get('phone');
            const displayName = formData.get('display_name');
            
            if (!phone || !displayName) {
                showMessage('Vui lòng điền đầy đủ thông tin', 'error');
                return;
            }
            
            if (!validateVietnamesePhone(phone)) {
                showMessage('Số điện thoại không hợp lệ', 'error');
                return;
            }
            
            try {
                // Show loading
                const submitBtn = this.querySelector('button[type="submit"]');
                const originalText = submitBtn.innerHTML;
                submitBtn.disabled = true;
                submitBtn.innerHTML = 'Đang xử lý...';
                
                // Here you would normally call your registration API
                // For now, we'll simulate the process
                await new Promise(resolve => setTimeout(resolve, 2000));
                
                // Redirect to verification or directly to join
                showMessage('Đăng ký thành công! Đang chuyển hướng...', 'success');
                setTimeout(() => {
                    window.location.href = `/invite/${token}`;
                }, 1500);
                
            } catch (error) {
                showMessage('Có lỗi xảy ra. Vui lòng thử lại.', 'error');
            } finally {
                const submitBtn = this.querySelector('button[type="submit"]');
                submitBtn.disabled = false;
                submitBtn.innerHTML = originalText;
            }
        });
        
        // Login form handler
        document.getElementById('login-form').addEventListener('submit', async function(e) {
            e.preventDefault();
            
            const formData = new FormData(this);
            const phone = formData.get('phone');
            
            if (!phone) {
                showMessage('Vui lòng nhập số điện thoại', 'error');
                return;
            }
            
            if (!validateVietnamesePhone(phone)) {
                showMessage('Số điện thoại không hợp lệ', 'error');
                return;
            }
            
            try {
                const submitBtn = this.querySelector('button[type="submit"]');
                const originalText = submitBtn.innerHTML;
                submitBtn.disabled = true;
                submitBtn.innerHTML = 'Đang gửi...';
                
                // Here you would normally call your login API
                await new Promise(resolve => setTimeout(resolve, 2000));
                
                showMessage('Mã xác thực đã được gửi!', 'success');
                // Here you would show OTP verification form or redirect
                
            } catch (error) {
                showMessage('Có lỗi xảy ra. Vui lòng thử lại.', 'error');
            } finally {
                const submitBtn = this.querySelector('button[type="submit"]');
                submitBtn.disabled = false;
                submitBtn.innerHTML = originalText;
            }
        });
        
        // Modal functions
        function showLoginForm() {
            document.getElementById('login-modal').classList.remove('hidden');
        }
        
        function hideLoginForm() {
            document.getElementById('login-modal').classList.add('hidden');
        }
        
        // Close modal on outside click
        document.getElementById('login-modal').addEventListener('click', function(e) {
            if (e.target === this) {
                hideLoginForm();
            }
        });
        
        // Phone validation
        function validateVietnamesePhone(phone) {
            const cleanPhone = phone.replace(/\D/g, '');
            const patterns = [
                /^[35789]\d{8}$/,     // Without prefix
                /^0[35789]\d{8}$/,   // With 0 prefix
                /^84[35789]\d{8}$/   // With 84 prefix
            ];
            
            return patterns.some(pattern => pattern.test(cleanPhone));
        }
        
        // Message functions
        function showMessage(message, type, duration = 4000) {
            const container = document.getElementById('message-container');
            const bgColor = type === 'success' ? 'bg-green-50 border-green-200' : 'bg-red-50 border-red-200';
            const textColor = type === 'success' ? 'text-green-800' : 'text-red-800';
            const iconColor = type === 'success' ? 'text-green-600' : 'text-red-600';
            const icon = type === 'success' 
                ? `<svg class="w-5 h-5 ${iconColor}" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path></svg>`
                : `<svg class="w-5 h-5 ${iconColor}" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"></path></svg>`;
            
            const messageEl = document.createElement('div');
            messageEl.className = `p-4 rounded-lg border ${bgColor} ${textColor} flex items-center space-x-2 shadow-lg`;
            messageEl.innerHTML = `${icon}<span>${message}</span>`;
            
            container.innerHTML = '';
            container.appendChild(messageEl);
            
            setTimeout(() => {
                messageEl.style.opacity = '0';
                messageEl.style.transform = 'translateY(-10px)';
                setTimeout(() => {
                    if (container.contains(messageEl)) {
                        container.removeChild(messageEl);
                    }
                }, 300);
            }, duration);
        }
    </script>
</body>
</html>