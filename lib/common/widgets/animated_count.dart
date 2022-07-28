import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AnimatedCount extends ImplicitlyAnimatedWidget {
  const AnimatedCount({
    required this.count,
    required this.style,
    this.textAlign = TextAlign.center,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.fastOutSlowIn,
    Key? key,
  }) : super(duration: duration, curve: curve, key: key);

  final TextStyle style;
  final TextAlign textAlign;
  final int count;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() {
    return _AnimatedCountState();
  }
}

class _AnimatedCountState extends AnimatedWidgetBaseState<AnimatedCount> {
  IntTween _intCountTween = IntTween(begin: 0, end: 1);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      _intCountTween.evaluate(animation).toString(),
      style: widget.style,
      textAlign: widget.textAlign,
      maxLines: 1,
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _intCountTween = visitor(
      _intCountTween,
      widget.count,
      (dynamic value) => IntTween(begin: value! as int?),
    )! as IntTween;
  }
}
