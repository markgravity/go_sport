import 'package:flutter/material.dart';
import '../services/groups_service.dart';

class LocationInputWidget extends StatefulWidget {
  final Function(String location, String city, String district, double? lat, double? lng) onLocationChanged;
  final String? sportType;

  const LocationInputWidget({
    super.key,
    required this.onLocationChanged,
    this.sportType,
  });

  @override
  State<LocationInputWidget> createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  final _locationController = TextEditingController();
  final _cityController = TextEditingController();
  final _districtController = TextEditingController();
  
  List<String> _locationSuggestions = [];
  List<String> _citySuggestions = [];
  bool _isLoadingSuggestions = false;

  final List<String> _vietnameseCities = [
    'Hà Nội',
    'TP.HCM',
    'Đà Nẵng',
    'Hải Phòng',
    'Cần Thơ',
    'Biên Hòa',
    'Huế',
    'Nha Trang',
    'Buôn Ma Thuột',
    'Vũng Tàu',
    'Quy Nhon',
    'Thái Nguyên',
    'Nam Định',
    'Hạ Long',
    'Thanh Hóa',
  ];

  @override
  void initState() {
    super.initState();
    _citySuggestions = _vietnameseCities;
    _loadLocationSuggestions();
  }

  Future<void> _loadLocationSuggestions() async {
    if (widget.sportType == null) return;

    try {
      setState(() => _isLoadingSuggestions = true);
      final suggestions = await GroupsService.getLocationSuggestions(
        widget.sportType!,
        city: _cityController.text.isNotEmpty ? _cityController.text : null,
      );
      setState(() => _locationSuggestions = suggestions);
    } catch (e) {
      // Silently fail for location suggestions
      debugPrint('Error loading location suggestions: $e');
    } finally {
      setState(() => _isLoadingSuggestions = false);
    }
  }

  void _updateLocation() {
    widget.onLocationChanged(
      _locationController.text.trim(),
      _cityController.text.trim(),
      _districtController.text.trim(),
      null, // latitude - could be added with maps integration
      null, // longitude - could be added with maps integration
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // City
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return _citySuggestions;
            }
            return _citySuggestions.where((String option) {
              return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: (String city) {
            _cityController.text = city;
            _updateLocation();
            _loadLocationSuggestions(); // Reload location suggestions for this city
          },
          fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
            _cityController.text = controller.text;
            return TextFormField(
              controller: controller,
              focusNode: focusNode,
              decoration: const InputDecoration(
                labelText: 'Thành phố *',
                hintText: 'VD: Hà Nội',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_city),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Vui lòng nhập thành phố';
                }
                return null;
              },
              onChanged: (value) {
                _cityController.text = value;
                _updateLocation();
              },
            );
          },
        ),
        const SizedBox(height: 16),

        // District
        TextFormField(
          controller: _districtController,
          decoration: const InputDecoration(
            labelText: 'Quận/Huyện',
            hintText: 'VD: Ba Đình',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.location_on),
          ),
          onChanged: (value) => _updateLocation(),
        ),
        const SizedBox(height: 16),

        // Location
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return _locationSuggestions;
            }
            return _locationSuggestions.where((String option) {
              return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: (String location) {
            _locationController.text = location;
            _updateLocation();
          },
          fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
            _locationController.text = controller.text;
            return TextFormField(
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                labelText: 'Địa điểm *',
                hintText: 'VD: Sân cầu lông ABC, 123 Đường XYZ',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.place),
                suffixIcon: _isLoadingSuggestions 
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : null,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Vui lòng nhập địa điểm';
                }
                return null;
              },
              onChanged: (value) {
                _locationController.text = value;
                _updateLocation();
              },
              maxLines: 2,
            );
          },
        ),

        if (_locationSuggestions.isNotEmpty && widget.sportType != null) ...[
          const SizedBox(height: 8),
          Text(
            'Gợi ý địa điểm phổ biến:',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: _locationSuggestions.take(3).map((suggestion) {
              return ActionChip(
                label: Text(
                  suggestion,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                onPressed: () {
                  _locationController.text = suggestion;
                  _updateLocation();
                },
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  @override
  void dispose() {
    _locationController.dispose();
    _cityController.dispose();
    _districtController.dispose();
    super.dispose();
  }
}