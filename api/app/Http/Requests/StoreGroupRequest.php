<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class StoreGroupRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true; // Authorization handled by middleware
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'name' => 'required|string|max:255',
            'description' => 'nullable|string|max:1000',
            'sport_type' => [
                'required',
                Rule::in(['football', 'badminton', 'tennis', 'pickleball'])
            ],
            'location' => 'required|string|max:500',
            'city' => 'required|string|max:100',
            'district' => 'nullable|string|max:100',
            'latitude' => 'nullable|numeric|between:-90,90',
            'longitude' => 'nullable|numeric|between:-180,180',
            'schedule' => 'nullable|array',
            'monthly_fee' => 'nullable|numeric|min:0|max:10000000',
            'privacy' => [
                'required',
                Rule::in(['cong_khai', 'rieng_tu'])
            ],
            'avatar' => 'nullable|string|max:255',
            'rules' => 'nullable|array',
            'level_requirements' => 'nullable|array',
            'level_requirements.*.level_key' => [
                'required_with:level_requirements',
                Rule::in(['moi_bat_dau', 'so_cap', 'trung_cap', 'cao_cap', 'chuyen_nghiep'])
            ],
            'level_requirements.*.level_name' => 'required_with:level_requirements|string|max:255'
        ];
    }

    /**
     * Get custom error messages for validator errors.
     *
     * @return array<string, string>
     */
    public function messages(): array
    {
        return [
            'name.required' => 'Tên nhóm là bắt buộc',
            'name.max' => 'Tên nhóm không được vượt quá 255 ký tự',
            'sport_type.required' => 'Loại thể thao là bắt buộc',
            'sport_type.in' => 'Loại thể thao không hợp lệ',
            'location.required' => 'Địa điểm là bắt buộc',
            'location.max' => 'Địa điểm không được vượt quá 500 ký tự',
            'city.required' => 'Thành phố là bắt buộc',
            'city.max' => 'Thành phố không được vượt quá 100 ký tự',
            'privacy.required' => 'Chế độ riêng tư là bắt buộc',
            'privacy.in' => 'Chế độ riêng tư không hợp lệ',
            'monthly_fee.numeric' => 'Phí hàng tháng phải là số',
            'monthly_fee.min' => 'Phí hàng tháng không được âm',
            'monthly_fee.max' => 'Phí hàng tháng không được vượt quá 10,000,000',
            'latitude.between' => 'Vĩ độ phải nằm trong khoảng -90 đến 90',
            'longitude.between' => 'Kinh độ phải nằm trong khoảng -180 đến 180',
            'level_requirements.*.level_key.required_with' => 'Khóa cấp độ là bắt buộc khi có yêu cầu cấp độ',
            'level_requirements.*.level_key.in' => 'Khóa cấp độ không hợp lệ',
            'level_requirements.*.level_name.required_with' => 'Tên cấp độ là bắt buộc khi có yêu cầu cấp độ',
            'level_requirements.*.level_name.max' => 'Tên cấp độ không được vượt quá 255 ký tự',
        ];
    }

    /**
     * Get custom attributes for validator errors.
     *
     * @return array<string, string>
     */
    public function attributes(): array
    {
        return [
            'name' => 'tên nhóm',
            'description' => 'mô tả',
            'sport_type' => 'loại thể thao',
            'location' => 'địa điểm',
            'city' => 'thành phố',
            'district' => 'quận/huyện',
            'privacy' => 'chế độ riêng tư',
            'monthly_fee' => 'phí hàng tháng',
        ];
    }
}