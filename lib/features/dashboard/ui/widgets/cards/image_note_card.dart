import 'package:flutter/material.dart';
import 'package:notino/core/constants/dimens.dart';

class ImageNoteCardBox extends StatelessWidget {
  const ImageNoteCardBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimens.borderRadiusXLarge),
              image: DecorationImage(
                image: AssetImage(
                  "assets/img/image_note_bg.webp"
                ),
                fit: .cover,
              )
            ),
            foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimens.borderRadiusXLarge),
              gradient: LinearGradient(
                colors: [
                  Colors.black87,
                  Colors.black.withValues(alpha: 0)
                ],
                begin: .bottomCenter,
                end: .topCenter,
              )
            ),
          ),
        ),
    
    
        Positioned(
          bottom: AppDimens.paddingMedium,
          right: AppDimens.paddingMedium,
          child: Column(
            spacing: 4,
            crossAxisAlignment: .start,
            children: [
              Text(
                'یادداشت جدیـد',
                style: textTheme.labelSmall!.copyWith(
                  fontSize: 14,
                  fontWeight: .bold,
                ),
              ),
    
              Text(
                'همـراه با عکـس',
                style: textTheme.labelSmall!.copyWith(
                  fontSize: 12,
                  fontWeight: .normal,
                ),
              ),
            ],
          )
        )
      ],
    );
  }
}