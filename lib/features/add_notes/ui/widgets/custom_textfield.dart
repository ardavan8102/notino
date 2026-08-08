import 'package:flutter/material.dart';
import 'package:notino/app/extensions/sizedbox.dart';
import 'package:notino/core/constants/colors.dart';
import 'package:notino/core/constants/dimens.dart';

class CustomTextFieldWithTitle extends StatelessWidget {
  const CustomTextFieldWithTitle({
    super.key,
    required this.controller, 
    required this.title, 
    required this.fieldHint,
    this.maxLines = 1, required this.onSubmitted, required this.focusNode,
  });
  
  final TextEditingController controller;
  final String title;
  final String fieldHint;
  final int maxLines;
  final Function(String) onSubmitted;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          title,
          style: textTheme.labelLarge
        ),

        AppDimens.marginSmall.height,
    
        TextField(
          controller: controller,
          focusNode: focusNode,
          autocorrect: false,
          textInputAction: TextInputAction.next,
          onSubmitted: onSubmitted,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: fieldHint,
            hintStyle: textTheme.labelSmall?.copyWith(
              color: Colors.white.withValues(alpha: .5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimens.borderRadiusLarge),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: .3),
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimens.borderRadiusLarge),
              borderSide: BorderSide(
                color: AppColors.yellow,
                width: 1.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}