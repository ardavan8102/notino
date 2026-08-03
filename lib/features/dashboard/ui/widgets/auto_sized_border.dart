import 'package:flutter/material.dart';
import 'package:notino/core/constants/dimens.dart';
import 'package:notino/features/dashboard/ui/widgets/painter/border_painter.dart';

class AutoSizedContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color color;

  const AutoSizedContainer({
    super.key, 
    required this.child, 
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DoubleFadeBorderPainter(color: color),
      child: Container(
        decoration: BoxDecoration(
          color: color.withValues(alpha: .25),
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusLarge)
        ),
        padding: padding,
        child: child,
      ),
    );
  }
}