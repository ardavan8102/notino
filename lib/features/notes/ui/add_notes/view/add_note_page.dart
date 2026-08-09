import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notino/app/extensions/sizedbox.dart';
import 'package:notino/core/constants/colors.dart';
import 'package:notino/core/constants/dimens.dart';

import 'package:notino/features/notes/logic/controllers/note_controller.dart';
import 'package:notino/features/notes/logic/controllers/add_note_controller.dart';
import 'package:notino/features/notes/logic/models/note_model.dart';

import 'package:notino/features/notes/ui/add_notes/widgets/custom_textfield.dart';
import 'package:notino/features/dashboard/ui/widgets/auto_sized_border.dart';

import 'package:notino/features/page_handling/providers/navigation_provider.dart';

class AddNewNotePage extends ConsumerWidget {
  const AddNewNotePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fieldController = ref.read(addNoteControllerProvider.notifier);

    final attachments = ref.watch(addNoteControllerProvider);

    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ------------------------------------------------------
        // Top bar
        // ------------------------------------------------------
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('یـادداشت جدید', style: textTheme.titleSmall),

            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(AppDimens.borderRadiusLarge),
              child: InkWell(
                borderRadius: BorderRadius.circular(
                  AppDimens.borderRadiusLarge,
                ),
                splashColor: Colors.white.withValues(alpha: .3),
                onTap: () async {
                  final title = fieldController.titleController.text.trim();

                  final content = fieldController.contentController.text.trim();

                  // Optional validation
                  if (title.isEmpty && content.isEmpty) {
                    return;
                  }

                  try {
                    await ref
                        .read(noteControllerProvider.notifier)
                        .saveNote(
                          title: title,
                          content: content,
                          attachments: List.from(attachments),
                        );

                    // Reset Add Note page
                    fieldController.reset();

                    // Go back to Notes page
                    ref.read(navigationProvider.notifier).state = 2;
                  } catch (e) {
                    debugPrint('Failed to save note: $e');
                  }
                },
                child: AutoSizedContainer(
                  color: AppColors.yellow,
                  child: Text('ذخیره', style: textTheme.labelSmall),
                ),
              ),
            ),
          ],
        ),

        AppDimens.marginLarge.height,

        // ------------------------------------------------------
        // Content
        // ------------------------------------------------------
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ------------------------------------------------
                // Title
                // ------------------------------------------------
                CustomTextFieldWithTitle(
                  controller: fieldController.titleController,
                  title: 'عنوان',
                  fieldHint: 'لیست خرید، درس‌های فردا و ...',
                  onSubmitted: (value) {
                    fieldController.contentFocusNode.requestFocus();
                  },
                  focusNode: fieldController.titleFocusNode,
                ),

                AppDimens.marginXLarge.height,

                // ------------------------------------------------
                // Content
                // ------------------------------------------------
                CustomTextFieldWithTitle(
                  controller: fieldController.contentController,
                  title: 'محتوا',
                  fieldHint: 'متن یادداشت خود را اینجا بنویسید...',
                  maxLines: 4,
                  onSubmitted: (value) {},
                  focusNode: fieldController.contentFocusNode,
                ),

                AppDimens.marginXLarge.height,

                // ------------------------------------------------
                // Images
                // ------------------------------------------------
                _AttachmentSection(
                  title: 'تصـاویـر',
                  buttonColor: Colors.greenAccent,
                  attachments: attachments
                      .where((item) => item.type == 'image')
                      .toList(),
                  onAdd: fieldController.addImages,
                  controller: fieldController,
                ),

                const SizedBox(height: 20),

                // ------------------------------------------------
                // Audio
                // ------------------------------------------------
                _AttachmentSection(
                  title: 'فایــل صـوتی',
                  buttonColor: Colors.lightBlueAccent,
                  attachments: attachments
                      .where((item) => item.type == 'audio')
                      .toList(),
                  onAdd: fieldController.addAudio,
                  controller: fieldController,
                ),

                const SizedBox(height: 20),

                // ------------------------------------------------
                // Files
                // ------------------------------------------------
                _AttachmentSection(
                  title: 'سـایـر فایـل‌هـا',
                  buttonColor: Colors.redAccent,
                  attachments: attachments
                      .where((item) => item.type == 'file')
                      .toList(),
                  onAdd: fieldController.addFiles,
                  controller: fieldController,
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// Attachment Section
// ============================================================

class _AttachmentSection extends StatelessWidget {
  final String title;
  final Color buttonColor;
  final List<NoteAttachment> attachments;
  final VoidCallback onAdd;
  final AddNoteController controller;

  const _AttachmentSection({
    required this.title,
    required this.buttonColor,
    required this.attachments,
    required this.onAdd,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: textTheme.labelLarge),

            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(AppDimens.borderRadiusLarge),
              child: InkWell(
                borderRadius: BorderRadius.circular(
                  AppDimens.borderRadiusLarge,
                ),
                onTap: onAdd,
                child: AutoSizedContainer(
                  color: buttonColor,
                  child: Text('افـزودن جدید', style: textTheme.labelSmall),
                ),
              ),
            ),
          ],
        ),

        if (attachments.isNotEmpty) ...[
          const SizedBox(height: 10),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: attachments.length,
            separatorBuilder: (_, _) {
              return const SizedBox(height: 8);
            },
            itemBuilder: (context, index) {
              final attachment = attachments[index];

              return _AttachmentItem(
                attachment: attachment,
                onRemove: () {
                  controller.removeAttachment(attachment);
                },
              );
            },
          ),
        ],
      ],
    );
  }
}

// ============================================================
// Attachment Item
// ============================================================

class _AttachmentItem extends StatelessWidget {
  final NoteAttachment attachment;
  final VoidCallback onRemove;

  const _AttachmentItem({required this.attachment, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusMedium),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: .15),
        ),
      ),
      child: Row(
        children: [
          _leading(),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              attachment.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textDirection: TextDirection.rtl,
            ),
          ),

          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: onRemove,
            icon: const Icon(Icons.close, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _leading() {
    if (attachment.type == 'image') {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          File(attachment.path),
          width: 45,
          height: 45,
          fit: BoxFit.cover,
        ),
      );
    }

    if (attachment.type == 'audio') {
      return const Icon(Icons.audiotrack, size: 32);
    }

    return const Icon(Icons.insert_drive_file_outlined, size: 32);
  }
}
