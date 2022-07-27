import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:score_keeper/common/constants/app_colors.dart';
import 'package:score_keeper/common/constants/display_properties.dart';
import 'package:score_keeper/common/text/text_style.dart';

class BasicTextField extends StatefulWidget {
  const BasicTextField({
    Key? key,
    required this.width,
    this.initialValue = '',
    this.labelText,
    this.onChange,
    this.autoFocus = true,
    this.textInputType = TextInputType.text,
    this.style,
    this.cursorColor,
    this.inputFormatters,
    this.floatingLabelStyle,
  }) : super(key: key);

  final bool autoFocus;
  final double width;
  final String initialValue;
  final Function(String)? onChange;
  final String? labelText;
  final TextInputType textInputType;
  final TextStyle? style;
  final TextStyle? floatingLabelStyle;
  final Color? cursorColor;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<BasicTextField> createState() => _EditorTextInputState();
}

class _EditorTextInputState extends State<BasicTextField> {
  final FocusNode _focus = FocusNode();
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BasicTextField oldWidget) {
    _controller.text = widget.initialValue;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    );
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextField(
        autofocus: widget.autoFocus,
        maxLines: 1,
        style: widget.style ?? TextStyles.heading02,
        cursorColor: widget.cursorColor ?? AppColors.black100,
        inputFormatters: widget.inputFormatters,
        textAlign: TextAlign.center,
        keyboardType: widget.textInputType,
        decoration: InputDecoration(
          isDense: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelStyle: widget.floatingLabelStyle ?? TextStyles.body01,
          border: DisplayProperties.focusedBorder,
          enabledBorder: DisplayProperties.focusedBorder,
          focusedBorder: DisplayProperties.focusedBorder,
          labelStyle: TextStyles.body01,
          labelText: widget.labelText,
        ),
        focusNode: _focus,
        controller: _controller,
        onChanged: widget.onChange,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
