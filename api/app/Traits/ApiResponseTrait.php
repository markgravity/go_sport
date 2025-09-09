<?php

namespace App\Traits;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Response;

trait ApiResponseTrait
{
    /**
     * Return a success JSON response
     */
    protected function successResponse(
        $data = null, 
        string $message = '', 
        int $statusCode = Response::HTTP_OK
    ): JsonResponse {
        $response = [
            'success' => true,
            'message' => $message,
        ];

        if ($data !== null) {
            $response['data'] = $data;
        }

        return response()->json($response, $statusCode);
    }

    /**
     * Return an error JSON response
     */
    protected function errorResponse(
        string $message = 'An error occurred', 
        $errors = null,
        int $statusCode = Response::HTTP_BAD_REQUEST
    ): JsonResponse {
        $response = [
            'success' => false,
            'message' => $message,
        ];

        if ($errors !== null) {
            $response['errors'] = $errors;
        }

        return response()->json($response, $statusCode);
    }

    /**
     * Return a validation error response
     */
    protected function validationErrorResponse(
        $errors, 
        string $message = 'Dữ liệu không hợp lệ'
    ): JsonResponse {
        return $this->errorResponse($message, $errors, Response::HTTP_UNPROCESSABLE_ENTITY);
    }

    /**
     * Return a not found error response
     */
    protected function notFoundResponse(string $message = 'Không tìm thấy dữ liệu'): JsonResponse 
    {
        return $this->errorResponse($message, null, Response::HTTP_NOT_FOUND);
    }

    /**
     * Return a forbidden error response
     */
    protected function forbiddenResponse(string $message = 'Bạn không có quyền thực hiện thao tác này'): JsonResponse 
    {
        return $this->errorResponse($message, null, Response::HTTP_FORBIDDEN);
    }

    /**
     * Return an unauthorized error response
     */
    protected function unauthorizedResponse(string $message = 'Bạn cần đăng nhập để thực hiện thao tác này'): JsonResponse 
    {
        return $this->errorResponse($message, null, Response::HTTP_UNAUTHORIZED);
    }

    /**
     * Return a server error response
     */
    protected function serverErrorResponse(
        string $message = 'Đã xảy ra lỗi hệ thống',
        $error = null
    ): JsonResponse {
        $response = [
            'success' => false,
            'message' => $message,
        ];

        // Include error details in development/debug mode only
        if (config('app.debug') && $error !== null) {
            $response['error'] = is_string($error) ? $error : $error->getMessage();
        }

        return response()->json($response, Response::HTTP_INTERNAL_SERVER_ERROR);
    }

    /**
     * Return a rate limit error response
     */
    protected function rateLimitResponse(
        string $message = 'Bạn đã gửi quá nhiều yêu cầu. Vui lòng thử lại sau.'
    ): JsonResponse {
        return $this->errorResponse($message, null, Response::HTTP_TOO_MANY_REQUESTS);
    }
}