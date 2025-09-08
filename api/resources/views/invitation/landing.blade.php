<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ $group->name ?? 'Lời mời tham gia nhóm' }} - Go Sport</title>
    
    <!-- Meta tags for social sharing -->
    @if($group)
    <meta property="og:title" content="{{ $group->name }} - Go Sport">
    <meta property="og:description" content="Tham gia nhóm {{ $group->sport_name }} tại {{ $group->city }}. {{ $group->current_members }} thành viên đang hoạt động.">
    <meta property="og:type" content="website">
    @endif
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
        }
        
        .container {
            max-width: 480px;
            margin: 0 auto;
            background: white;
            min-height: 100vh;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        
        .header {
            background: #2563eb;
            color: white;
            text-align: center;
            padding: 2rem 1rem;
        }
        
        .logo {
            font-size: 1.8rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }
        
        .tagline {
            opacity: 0.9;
            font-size: 0.9rem;
        }
        
        .content {
            padding: 2rem 1.5rem;
        }
        
        .group-card {
            background: #f8fafc;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border-left: 4px solid #2563eb;
        }
        
        .group-name {
            font-size: 1.5rem;
            font-weight: 600;
            color: #1e40af;
            margin-bottom: 0.5rem;
        }
        
        .group-sport {
            display: inline-block;
            background: #dbeafe;
            color: #1e40af;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.875rem;
            margin-bottom: 1rem;
        }
        
        .group-details {
            display: grid;
            gap: 0.75rem;
        }
        
        .detail-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .detail-icon {
            width: 20px;
            height: 20px;
            color: #6b7280;
        }
        
        .detail-text {
            color: #374151;
        }
        
        .creator-info {
            background: #f1f5f9;
            border-radius: 8px;
            padding: 1rem;
            margin: 1.5rem 0;
        }
        
        .creator-text {
            font-size: 0.9rem;
            color: #64748b;
            margin-bottom: 0.5rem;
        }
        
        .creator-name {
            font-weight: 600;
            color: #334155;
        }
        
        .action-buttons {
            margin-top: 2rem;
        }
        
        .btn {
            display: block;
            width: 100%;
            padding: 1rem;
            border-radius: 8px;
            text-align: center;
            text-decoration: none;
            font-weight: 600;
            font-size: 1rem;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .btn-primary {
            background: #2563eb;
            color: white;
            margin-bottom: 1rem;
        }
        
        .btn-primary:hover {
            background: #1d4ed8;
            transform: translateY(-1px);
        }
        
        .btn-secondary {
            background: #f1f5f9;
            color: #475569;
            border: 1px solid #e2e8f0;
        }
        
        .btn-secondary:hover {
            background: #e2e8f0;
        }
        
        .expired-notice {
            background: #fef2f2;
            border: 1px solid #fecaca;
            border-radius: 8px;
            padding: 1rem;
            color: #dc2626;
            text-align: center;
            margin-bottom: 1rem;
        }
        
        .invalid-notice {
            background: #fefce8;
            border: 1px solid #fde047;
            border-radius: 8px;
            padding: 1rem;
            color: #ca8a04;
            text-align: center;
            margin-bottom: 1rem;
        }
        
        .footer {
            text-align: center;
            padding: 2rem 1.5rem;
            color: #6b7280;
            font-size: 0.875rem;
            border-top: 1px solid #e5e7eb;
            margin-top: 2rem;
        }
        
        @media (max-width: 480px) {
            .container {
                margin: 0;
                border-radius: 0;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <div class="logo">⚽ Go Sport</div>
            <div class="tagline">Kết nối đam mê thể thao</div>
        </div>
        
        <!-- Content -->
        <div class="content">
            @if($invitation && $group)
                @if($isExpired)
                    <div class="expired-notice">
                        ⏰ Lời mời này đã hết hạn vào {{ $invitation->expires_at->format('d/m/Y H:i') }}
                    </div>
                @elseif(!$isValid)
                    <div class="invalid-notice">
                        ⚠️ Lời mời không hợp lệ hoặc đã được sử dụng
                    </div>
                @endif
                
                <!-- Group Information -->
                <div class="group-card">
                    <h1 class="group-name">{{ $group->name }}</h1>
                    <span class="group-sport">{{ $group->sport_name }}</span>
                    
                    <div class="group-details">
                        <div class="detail-item">
                            <svg class="detail-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                      d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                      d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/>
                            </svg>
                            <span class="detail-text">{{ $group->location }}, {{ $group->city }}</span>
                        </div>
                        
                        <div class="detail-item">
                            <svg class="detail-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                      d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"/>
                            </svg>
                            <span class="detail-text">{{ $group->current_members }} thành viên</span>
                        </div>
                        
                        @if($group->monthly_fee > 0)
                        <div class="detail-item">
                            <svg class="detail-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                      d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1"/>
                            </svg>
                            <span class="detail-text">{{ number_format($group->monthly_fee, 0, ',', '.') }} VND/tháng</span>
                        </div>
                        @endif
                        
                        <div class="detail-item">
                            <svg class="detail-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                      d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                            <span class="detail-text">{{ $group->privacy_name }}</span>
                        </div>
                    </div>
                </div>
                
                @if($creator)
                <!-- Creator Information -->
                <div class="creator-info">
                    <div class="creator-text">Được mời bởi:</div>
                    <div class="creator-name">{{ $creator->name }}</div>
                </div>
                @endif
                
                @if($group->description)
                <!-- Group Description -->
                <div style="margin-bottom: 1.5rem;">
                    <h3 style="margin-bottom: 0.5rem; color: #374151;">Về nhóm này</h3>
                    <p style="color: #6b7280; line-height: 1.5;">{{ $group->description }}</p>
                </div>
                @endif
                
                <!-- Action Buttons -->
                <div class="action-buttons">
                    @if($isValid)
                        <!-- Join Request Form -->
                        <form action="{{ url("/invite/{$token}/join") }}" method="POST" style="margin-bottom: 1rem;">
                            @csrf
                            <div style="margin-bottom: 1rem;">
                                <label for="message" style="display: block; font-weight: 500; margin-bottom: 0.5rem; color: #374151;">
                                    Tin nhắn giới thiệu (tuỳ chọn):
                                </label>
                                <textarea 
                                    name="message" 
                                    id="message" 
                                    rows="3" 
                                    placeholder="Giới thiệu bản thân và lý do muốn tham gia nhóm..."
                                    style="width: 100%; padding: 0.75rem; border: 1px solid #d1d5db; border-radius: 8px; font-size: 1rem; resize: vertical;"
                                ></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">
                                🚀 Gửi yêu cầu tham gia
                            </button>
                        </form>
                        <a href="#" class="btn btn-secondary" onclick="shareInvitation()">
                            📤 Chia sẻ lời mời
                        </a>
                    @else
                        <div style="text-align: center; color: #6b7280; padding: 1rem;">
                            Lời mời này không còn khả dụng
                        </div>
                    @endif
                </div>
                
            @else
                <!-- Invitation not found -->
                <div class="invalid-notice">
                    ❌ Không tìm thấy lời mời hoặc liên kết không hợp lệ
                </div>
                
                <div style="text-align: center; margin-top: 2rem;">
                    <a href="https://example.com/download-app" class="btn btn-primary">
                        📱 Tải ứng dụng Go Sport
                    </a>
                </div>
            @endif
        </div>
        
        <!-- Footer -->
        <div class="footer">
            <div>Tải ứng dụng Go Sport để quản lý nhóm thể thao của bạn</div>
            <div style="margin-top: 0.5rem;">
                <a href="https://apps.apple.com" style="color: #2563eb; text-decoration: none;">App Store</a>
                &nbsp;•&nbsp;
                <a href="https://play.google.com" style="color: #2563eb; text-decoration: none;">Google Play</a>
            </div>
        </div>
    </div>
    
    <script>
        function shareInvitation() {
            if (navigator.share) {
                navigator.share({
                    title: '{{ $group->name ?? "Lời mời tham gia nhóm thể thao" }}',
                    text: 'Tham gia nhóm {{ $group->sport_name ?? "thể thao" }} cùng tôi!',
                    url: window.location.href
                });
            } else {
                // Fallback to copy to clipboard
                navigator.clipboard.writeText(window.location.href).then(function() {
                    alert('Đã sao chép liên kết vào clipboard!');
                });
            }
        }
        
        // Track page view for analytics
        fetch('/api/invitations/validate/{{ $token }}', {
            method: 'GET'
        }).catch(function(error) {
            console.log('Analytics tracking failed:', error);
        });
    </script>
</body>
</html>