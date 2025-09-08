<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tham gia thành công - Go Sport</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
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
            background: #059669;
            color: white;
            text-align: center;
            padding: 2rem 1rem;
        }
        
        .success-icon {
            font-size: 4rem;
            margin-bottom: 1rem;
        }
        
        .title {
            font-size: 1.5rem;
            font-weight: bold;
        }
        
        .content {
            padding: 2rem 1.5rem;
            text-align: center;
        }
        
        .group-name {
            font-size: 1.25rem;
            font-weight: 600;
            color: #059669;
            margin-bottom: 1rem;
        }
        
        .message {
            color: #6b7280;
            margin-bottom: 2rem;
            line-height: 1.6;
        }
        
        .next-steps {
            background: #f0fdf4;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            text-align: left;
        }
        
        .steps-title {
            font-weight: 600;
            color: #059669;
            margin-bottom: 1rem;
        }
        
        .step {
            display: flex;
            align-items: flex-start;
            gap: 0.75rem;
            margin-bottom: 0.75rem;
        }
        
        .step-number {
            background: #059669;
            color: white;
            width: 24px;
            height: 24px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.875rem;
            font-weight: 600;
            flex-shrink: 0;
        }
        
        .step-text {
            color: #374151;
            font-size: 0.9rem;
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
            margin-bottom: 1rem;
            transition: all 0.3s ease;
        }
        
        .btn-primary {
            background: #059669;
            color: white;
        }
        
        .btn-primary:hover {
            background: #047857;
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
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <div class="success-icon">🎉</div>
            <div class="title">Tham gia thành công!</div>
        </div>
        
        <!-- Content -->
        <div class="content">
            <div class="group-name">{{ $group->name }}</div>
            
            <p class="message">
                Chúc mừng! Bạn đã được thêm vào nhóm {{ $group->sport_name }} thành công. 
                Hãy tải ứng dụng Go Sport để bắt đầu tương tác với nhóm.
            </p>
            
            <!-- Next Steps -->
            <div class="next-steps">
                <div class="steps-title">Bước tiếp theo:</div>
                
                <div class="step">
                    <div class="step-number">1</div>
                    <div class="step-text">Tải và cài đặt ứng dụng Go Sport trên điện thoại</div>
                </div>
                
                <div class="step">
                    <div class="step-number">2</div>
                    <div class="step-text">Đăng ký tài khoản bằng số điện thoại của bạn</div>
                </div>
                
                <div class="step">
                    <div class="step-number">3</div>
                    <div class="step-text">Tham gia hoạt động nhóm và kết bạn với thành viên khác</div>
                </div>
            </div>
            
            <!-- Action Buttons -->
            <a href="{{ $appDownloadUrl }}" class="btn btn-primary">
                📱 Tải ứng dụng Go Sport
            </a>
            
            <a href="{{ url("/invite/{$invitation->token}") }}" class="btn btn-secondary">
                🔙 Quay lại trang mời
            </a>
        </div>
    </div>
    
    <script>
        // Track successful join for analytics
        fetch('/api/invitations/validate/{{ $invitation->token }}', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-TOKEN': '{{ csrf_token() }}'
            },
            body: JSON.stringify({
                action: 'joined'
            })
        }).catch(function(error) {
            console.log('Analytics tracking failed:', error);
        });
    </script>
</body>
</html>