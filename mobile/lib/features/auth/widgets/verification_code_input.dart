import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerificationCodeInput extends StatefulWidget {
  final int length;
  final Function(String) onChanged;
  final Function(String)? onCompleted;
  final double fieldWidth;
  final double fieldHeight;

  const VerificationCodeInput({
    super.key,
    required this.length,
    required this.onChanged,
    this.onCompleted,
    this.fieldWidth = 45,
    this.fieldHeight = 50,
  });

  @override
  State<VerificationCodeInput> createState() => _VerificationCodeInputState();
}

class _VerificationCodeInputState extends State<VerificationCodeInput> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  String _code = '';

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.length,
      (index) => TextEditingController(),
    );
    _focusNodes = List.generate(
      widget.length,
      (index) => FocusNode(),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1) {
      // Move to next field
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        // Last field, remove focus
        _focusNodes[index].unfocus();
      }
    } else if (value.isEmpty) {
      // Move to previous field
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    } else if (value.length > 1) {
      // Handle paste or multiple characters
      _handlePasteOrMultipleInput(value, index);
      return;
    }

    _updateCode();
  }

  void _handlePasteOrMultipleInput(String value, int startIndex) {
    // Clear all fields first
    for (var controller in _controllers) {
      controller.clear();
    }

    // Fill fields with the pasted value
    for (int i = 0; i < value.length && (startIndex + i) < widget.length; i++) {
      _controllers[startIndex + i].text = value[i];
    }

    // Focus on the last filled field or next empty field
    int focusIndex = (startIndex + value.length - 1).clamp(0, widget.length - 1);
    if (focusIndex < widget.length - 1) {
      _focusNodes[focusIndex + 1].requestFocus();
    } else {
      _focusNodes[focusIndex].unfocus();
    }

    _updateCode();
  }

  void _updateCode() {
    _code = _controllers.map((controller) => controller.text).join();
    widget.onChanged(_code);

    if (_code.length == widget.length) {
      widget.onCompleted?.call(_code);
    }
  }

  void _onKeyDown(KeyEvent event, int index) {
    if (event is KeyDownEvent) {
      // Handle backspace when field is empty
      if (event.logicalKey == LogicalKeyboardKey.backspace &&
          _controllers[index].text.isEmpty &&
          index > 0) {
        _focusNodes[index - 1].requestFocus();
        _controllers[index - 1].clear();
        _updateCode();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        widget.length,
        (index) => SizedBox(
          width: widget.fieldWidth,
          height: widget.fieldHeight,
          child: KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: (event) => _onKeyDown(event, index),
            child: TextFormField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(1),
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF2E5BDA),
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: _controllers[index].text.isNotEmpty
                        ? const Color(0xFF2E5BDA).withOpacity(0.3)
                        : Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                filled: true,
                fillColor: _controllers[index].text.isNotEmpty
                    ? const Color(0xFF2E5BDA).withOpacity(0.05)
                    : Colors.grey.shade50,
              ),
              onChanged: (value) => _onChanged(value, index),
              onTap: () {
                // Select all text when tapped
                _controllers[index].selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: _controllers[index].text.length,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}