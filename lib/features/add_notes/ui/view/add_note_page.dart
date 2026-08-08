import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notino/app/extensions/sizedbox.dart';
import 'package:notino/core/constants/colors.dart';
import 'package:notino/core/constants/dimens.dart';
import 'package:notino/features/add_notes/logic/controllers/textfields_controller.dart';
import 'package:notino/features/add_notes/ui/widgets/custom_textfield.dart';
import 'package:notino/features/dashboard/ui/widgets/auto_sized_border.dart';

class AddNewNotePage extends ConsumerWidget {
  const AddNewNotePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(addNewNoteProvider.notifier);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // top bar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'یـادداشت جدید',
              style: textTheme.titleSmall,
            ),
            
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(AppDimens.borderRadiusLarge),
              child: InkWell(
                borderRadius: BorderRadius.circular(AppDimens.borderRadiusLarge),
                splashColor: Colors.white.withValues(alpha: .3),
                onTap: () {
                  // Handle save action
                },
                child: AutoSizedContainer(
                  color: AppColors.yellow,
                  child: Text(
                    'ذخیره',
                    style: textTheme.labelSmall,
                  ),
                ),
              ),
            ),
          ],
        ),

        AppDimens.marginLarge.height,

        // Text field with title
        CustomTextFieldWithTitle(
          controller: controller.titleController,
          title: 'عنوان',
          fieldHint: 'لیست خرید، درس‌های فردا و ...',
          onSubmitted: (value) {
            controller.contentFocusNode.requestFocus();
          },
          focusNode: controller.titleFocusNode,
        ),

        AppDimens.marginXLarge.height,

        // Content TextField
        CustomTextFieldWithTitle(
          controller: controller.contentController,
          title: 'محتوا',
          fieldHint: 'متن یادداشت خود را اینجا بنویسید...',
          maxLines: 4,
          onSubmitted: (value) {
            // Handle save action
          },
          focusNode: controller.contentFocusNode,
        ),
      ],
    );
  }
}

