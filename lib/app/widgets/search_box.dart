import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';

/// 中日文 IME 友善的搜尋框：
/// 1. 組字中（composing range 有效且非 collapsed）不觸發 onChanged
/// 2. 觸發後 debounce，避免快速打字連續查 DB
class DebouncedSearchBox extends StatefulWidget {
  const DebouncedSearchBox({
    super.key,
    required this.controller,
    required this.onChanged,
    this.placeholder,
    this.debounce = const Duration(milliseconds: 300),
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String? placeholder;
  final Duration debounce;

  @override
  State<DebouncedSearchBox> createState() => _DebouncedSearchBoxState();
}

class _DebouncedSearchBoxState extends State<DebouncedSearchBox> {
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _handleChanged(String value) {
    final composing = widget.controller.value.composing;
    if (composing.isValid && !composing.isCollapsed) {
      return;
    }
    _timer?.cancel();
    _timer = Timer(widget.debounce, () {
      if (!mounted) return;
      widget.onChanged(value);
    });
  }

  void _handleSubmitted(String value) {
    _timer?.cancel();
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return TextBox(
      controller: widget.controller,
      placeholder: widget.placeholder,
      prefix: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Icon(FluentIcons.search),
      ),
      onChanged: _handleChanged,
      onSubmitted: _handleSubmitted,
    );
  }
}
