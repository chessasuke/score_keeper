import 'package:flutter/material.dart';
import 'package:score_keeper/board/widgets/simple_button.dart';
import 'package:score_keeper/common/constants/app_colors.dart';
import 'package:score_keeper/common/constants/display_properties.dart';
import 'package:score_keeper/common/text/text_style.dart';
import 'package:score_keeper/common/widgets/basic_text_field.dart';

class ButtonWithInputDialog extends StatelessWidget {
  const ButtonWithInputDialog({
    required this.child,
    required this.onPressed,
    required this.onChangedInput,
    required this.dialogBtnText,
    this.labelText,
    this.initialValue,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final String? labelText;
  final String? initialValue;
  final String dialogBtnText;
  final void Function(String) onChangedInput;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onTap: () => showDialog(
        context: context,
        builder: (context) => _DialogWithInput(
          initialValue: initialValue ?? '',
          text: dialogBtnText,
          labelText: labelText ?? '',
          onChangedInput: onChangedInput,
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class _DialogWithInput extends StatelessWidget {
  const _DialogWithInput({
    required this.text,
    required this.onChangedInput,
    required this.onPressed,
    required this.labelText,
    required this.initialValue,
    Key? key,
  }) : super(key: key);

  final String text;
  final String labelText;
  final String initialValue;
  final Function(String) onChangedInput;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DisplayProperties.mainHorizontalPadding,
            vertical: DisplayProperties.defaultContentPadding,
          ),
          child: Column(
            children: [
              BasicTextField(
                textInputType: TextInputType.number,
                style: TextStyles.body01,
                onChange: onChangedInput,
                labelText: labelText,
                width: 150,
                initialValue: initialValue,
              ),
              const SizedBox(height: DisplayProperties.defaultContentPadding),
              SimpleButton(
                onTap: onPressed,
                text: Text(
                  text,
                  style: TextStyles.heading03.copyWith(
                    color: AppColors.white100,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
