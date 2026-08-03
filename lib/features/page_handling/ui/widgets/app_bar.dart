import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:notino/core/constants/dimens.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Text(
          'یـادداشتــ‌هــای مـــن',
          style: textTheme.titleSmall
        ),
    
        const Spacer(),
    
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .15),
            borderRadius: BorderRadius.circular(AppDimens.borderRadiusLarge),
          ),
          padding: EdgeInsets.all(AppDimens.paddingSmall),
          child: Icon(
            LucideIcons.heart300
          ),
        ),
      ],
    );
  }
}