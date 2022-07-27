import 'package:flutter/material.dart';
import 'package:score_keeper/board/model/point.dart';
import 'package:score_keeper/common/constants/app_colors.dart';
import 'package:score_keeper/common/constants/display_properties.dart';
import 'package:score_keeper/common/text/text_style.dart';
import 'package:score_keeper/generated/i18n.dart';

class DraggablePoint extends StatelessWidget {
  const DraggablePoint({
    required this.point,
    required this.removePoints,
    Key? key,
  }) : super(key: key);

  final Point point;
  final void Function(int) removePoints;

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<Point>(
      data: Point(
        point: point.point,
        currentPointOwnerPlayerId: point.currentPointOwnerPlayerId,
      ),
      childWhenDragging: const SizedBox(),
      feedback: Text(
        '${point.point}',
        style: TextStyles.heading03,
      ),
      child: GestureDetector(
        onTap: () => _tapPoint(
          context: context,
          point: point,
          removePoints: removePoints,
        ),
        child: Container(
          margin:
              const EdgeInsets.all(DisplayProperties.defaultContentPadding / 2),
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(DisplayProperties.defaultBorderRadius),
              border: Border.all(color: AppColors.black100)),
          child: Padding(
            padding: const EdgeInsets.all(
                DisplayProperties.defaultContentPadding / 2),
            child: Text(
              point.point.toString(),
              style: TextStyles.heading03,
            ),
          ),
        ),
      ),
    );
  }
}

void _tapPoint({
  required BuildContext context,
  required Point point,
  required Function(int) removePoints,
}) {
  showDialog(
    context: context,
    builder: (context) => _RemovePointsDialog(
      removePoints: removePoints,
      point: point,
    ),
  );
}

class _RemovePointsDialog extends StatelessWidget {
  const _RemovePointsDialog({
    required this.point,
    required this.removePoints,
    Key? key,
  }) : super(key: key);

  final Function(int) removePoints;
  final Point point;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(S.of(context).deletePoints, style: TextStyles.heading02),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () => _removePoints(context),
              child: Text(S.of(context).yes, style: TextStyles.heading03),
            ),
            TextButton(
              child: Text(S.of(context).no, style: TextStyles.heading03),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ],
    );
  }

  void _removePoints(BuildContext context) {
    removePoints(point.point);
    Navigator.pop(context);
  }
}
