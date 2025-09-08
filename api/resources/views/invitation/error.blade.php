<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lỗi - Go Sport</title>
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
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .container {
            max-width: 400px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            padding: 2rem;
            text-align: center;
        }
        
        .error-icon {
            font-size: 4rem;
            margin-bottom: 1rem;
        }
        
        .error-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #dc2626;
            margin-bottom: 0.5rem;
        }
        
        .error-message {
            color: #6b7280;
            margin-bottom: 2rem;
            line-height: 1.5;
        }
        
        .btn {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            background: #2563eb;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: background 0.3s ease;
        }
        
        .btn:hover {
            background: #1d4ed8;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="error-icon">😞</div>
        <h1 class="error-title">Oops! Có lỗi xảy ra</h1>
        <p class="error-message">
            {{ $error ?? 'Không thể tải trang mời. Vui lòng thử lại sau.' }}
        </p>
        <a href="https://example.com/download-app" class="btn">
            📱 Tải ứng dụng Go Sport
        </a>
    </div>
</body>
</html>