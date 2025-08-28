#!/bin/bash

# Go Sport Development Environment Management Script
# Usage: ./scripts/dev.sh [command]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored output
print_color() {
    printf "${1}${2}${NC}\n"
}

print_header() {
    echo
    print_color $BLUE "🏃 Go Sport Development Environment"
    echo "======================================"
}

print_success() {
    print_color $GREEN "✅ $1"
}

print_warning() {
    print_color $YELLOW "⚠️  $1"
}

print_error() {
    print_color $RED "❌ $1"
}

# Check if Docker is running
check_docker() {
    if ! docker info > /dev/null 2>&1; then
        print_error "Docker is not running. Please start Docker first."
        exit 1
    fi
}

# Build and start all services
start() {
    print_header
    print_color $BLUE "Starting Go Sport development environment..."
    
    check_docker
    
    # Build and start containers
    docker-compose up -d --build
    
    print_success "Services started successfully!"
    print_color $YELLOW "Waiting for services to be ready..."
    
    # Wait for MySQL to be ready
    until docker-compose exec mysql mysqladmin ping -h"localhost" --silent; do
        printf "."
        sleep 2
    done
    
    echo
    print_success "MySQL is ready!"
    
    # Run Laravel setup
    setup_laravel
    
    print_success "Development environment is ready!"
    print_status
}

# Stop all services
stop() {
    print_header
    print_color $BLUE "Stopping Go Sport development environment..."
    
    docker-compose down
    
    print_success "Services stopped successfully!"
}

# Restart all services
restart() {
    print_header
    print_color $BLUE "Restarting Go Sport development environment..."
    
    stop
    start
}

# Setup Laravel application
setup_laravel() {
    print_color $BLUE "Setting up Laravel application..."
    
    # Generate app key if not exists
    if ! docker-compose exec app php artisan key:generate --show | grep -q "base64"; then
        docker-compose exec app php artisan key:generate
    fi
    
    # Run database migrations
    docker-compose exec app php artisan migrate --force
    
    # Clear caches
    docker-compose exec app php artisan config:clear
    docker-compose exec app php artisan cache:clear
    docker-compose exec app php artisan route:clear
    docker-compose exec app php artisan view:clear
    
    # Optimize for development
    docker-compose exec app php artisan config:cache
    docker-compose exec app php artisan route:cache
    
    print_success "Laravel setup completed!"
}

# Show service status
status() {
    print_header
    print_color $BLUE "Service Status:"
    
    docker-compose ps
    
    echo
    print_color $BLUE "Health Checks:"
    
    # Check API health
    if curl -s http://localhost:8000/api/health > /dev/null 2>&1; then
        print_success "API is responding at http://localhost:8000/api/health"
    else
        print_warning "API is not responding"
    fi
    
    # Check MySQL
    if docker-compose exec mysql mysqladmin ping -h"localhost" --silent > /dev/null 2>&1; then
        print_success "MySQL is running"
    else
        print_warning "MySQL is not responding"
    fi
    
    # Check Redis
    if docker-compose exec redis redis-cli ping > /dev/null 2>&1; then
        print_success "Redis is running"
    else
        print_warning "Redis is not responding"
    fi
}

# View logs
logs() {
    service=${2:-""}
    if [ -n "$service" ]; then
        docker-compose logs -f "$service"
    else
        docker-compose logs -f
    fi
}

# Clean up everything
clean() {
    print_header
    print_color $YELLOW "This will remove all containers, volumes, and images. Are you sure? (y/N)"
    read -r response
    
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        print_color $BLUE "Cleaning up Go Sport development environment..."
        
        docker-compose down -v --rmi all
        docker system prune -f
        
        print_success "Cleanup completed!"
    else
        print_color $BLUE "Cleanup cancelled."
    fi
}

# Execute artisan commands
artisan() {
    shift # Remove 'artisan' from arguments
    docker-compose exec app php artisan "$@"
}

# Execute composer commands
composer() {
    shift # Remove 'composer' from arguments
    docker-compose exec app composer "$@"
}

# Show help
help() {
    print_header
    echo "Available commands:"
    echo
    echo "  start     - Build and start all services"
    echo "  stop      - Stop all services"
    echo "  restart   - Restart all services"
    echo "  status    - Show service status and health"
    echo "  logs      - Show logs (optionally for specific service)"
    echo "  clean     - Remove all containers, volumes, and images"
    echo "  artisan   - Run Laravel artisan commands"
    echo "  composer  - Run composer commands"
    echo "  help      - Show this help message"
    echo
    echo "Examples:"
    echo "  ./scripts/dev.sh start"
    echo "  ./scripts/dev.sh logs app"
    echo "  ./scripts/dev.sh artisan migrate"
    echo "  ./scripts/dev.sh composer install"
}

# Main command dispatcher
case "${1:-help}" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    status)
        status
        ;;
    logs)
        logs "$@"
        ;;
    clean)
        clean
        ;;
    artisan)
        artisan "$@"
        ;;
    composer)
        composer "$@"
        ;;
    help|--help|-h)
        help
        ;;
    *)
        print_error "Unknown command: $1"
        help
        exit 1
        ;;
esac