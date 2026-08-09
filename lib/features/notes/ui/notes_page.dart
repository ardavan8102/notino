import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notino/core/constants/colors.dart';
import 'package:notino/core/constants/dimens.dart';

import 'package:notino/features/notes/logic/controllers/note_controller.dart';
import 'package:notino/features/notes/logic/models/note_model.dart';

class NotesPage extends ConsumerWidget {
  const NotesPage({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final notes = ref.watch(noteControllerProvider);

    final textTheme = Theme.of(context).textTheme;

    if (notes.isEmpty) {
      return _EmptyNotes(
        textTheme: textTheme,
      );
    }

    final sortedNotes = [...notes];

    sortedNotes.sort(
      (a, b) => b.createdAt.compareTo(a.createdAt),
    );

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: sortedNotes.length,
      separatorBuilder: (_, _) {
        return const SizedBox(height: 12);
      },
      itemBuilder: (context, index) {
        final note = sortedNotes[index];

        return _NoteCard(
          note: note,
          onDelete: () {
            _deleteNote(
              context: context,
              ref: ref,
              note: note,
            );
          },
        );
      },
    );
  }

  Future<void> _deleteNote({
    required BuildContext context,
    required WidgetRef ref,
    required NoteModel note,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'حذف یادداشت',
            textDirection: TextDirection.rtl,
          ),
          content: const Text(
            'آیا از حذف این یادداشت مطمئن هستید؟',
            textDirection: TextDirection.rtl,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('انصراف'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('حذف'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    await ref
        .read(noteControllerProvider.notifier)
        .deleteNote(note.id);
  }
}


// ============================================================
// Note Card
// ============================================================

class _NoteCard extends StatelessWidget {
  final NoteModel note;
  final VoidCallback onDelete;

  const _NoteCard({
    required this.note,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final images = note.attachments
        .where(
          (item) => item.type == 'image',
        )
        .toList();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(
          AppDimens.borderRadiusLarge,
        ),
        onTap: () {
          // TODO:
          // Navigate to NoteDetailsPage
        },
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(
              AppDimens.borderRadiusLarge,
            ),
            border: Border.all(
              color: Theme.of(context)
                  .dividerColor
                  .withValues(alpha: .15),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ------------------------------------------------
              // Header
              // ------------------------------------------------

              Row(
                children: [
                  Expanded(
                    child: Text(
                      note.title.isEmpty
                          ? 'بدون عنوان'
                          : note.title,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                    ),
                  ),

                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: onDelete,
                    icon: const Icon(
                      Icons.delete_outline,
                      size: 20,
                    ),
                  ),
                ],
              ),

              // ------------------------------------------------
              // Content
              // ------------------------------------------------

              if (note.content.trim().isNotEmpty) ...[
                const SizedBox(height: 5),

                Text(
                  note.content,
                  style: textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.rtl,
                ),
              ],

              // ------------------------------------------------
              // Images
              // ------------------------------------------------

              if (images.isNotEmpty) ...[
                const SizedBox(height: 12),

                _ImagePreview(
                  images: images,
                ),
              ],

              const SizedBox(height: 12),

              // ------------------------------------------------
              // Bottom
              // ------------------------------------------------

              Row(
                children: [
                  Icon(
                    Icons.access_time_outlined,
                    size: 15,
                    color: textTheme.bodySmall?.color,
                  ),

                  const SizedBox(width: 5),

                  Text(
                    _formatDate(note.createdAt),
                    style: textTheme.bodySmall,
                  ),

                  const Spacer(),

                  if (note.attachments.isNotEmpty)
                    Row(
                      children: [
                        const Icon(
                          Icons.attach_file,
                          size: 16,
                        ),

                        const SizedBox(width: 3),

                        Text(
                          '${note.attachments.length}',
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final local = date.toLocal();

    final hour = local.hour.toString().padLeft(2, '0');
    final minute = local.minute.toString().padLeft(2, '0');

    return '${local.year}/${local.month}/${local.day} '
        '$hour:$minute';
  }
}


// ============================================================
// Image Preview
// ============================================================

class _ImagePreview extends StatelessWidget {
  final List<NoteAttachment> images;

  const _ImagePreview({
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    final previewImages = images.take(3).toList();

    return SizedBox(
      height: 80,
      child: Row(
        children: [
          for (int i = 0; i < previewImages.length; i++) ...[
            Expanded(
              child: _ImageItem(
                attachment: previewImages[i],
              ),
            ),

            if (i != previewImages.length - 1)
              const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}


// ============================================================
// Image Item
// ============================================================

class _ImageItem extends StatelessWidget {
  final NoteAttachment attachment;

  const _ImageItem({
    required this.attachment,
  });

  @override
  Widget build(BuildContext context) {
    final file = File(attachment.path);

    if (!file.existsSync()) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(
            AppDimens.borderRadiusMedium,
          ),
        ),
        child: const Icon(
          Icons.image_not_supported_outlined,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(
        AppDimens.borderRadiusMedium,
      ),
      child: Image.file(
        file,
        fit: BoxFit.cover,
      ),
    );
  }
}


// ============================================================
// Empty State
// ============================================================

class _EmptyNotes extends StatelessWidget {
  final TextTheme textTheme;

  const _EmptyNotes({
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: AppColors.yellow.withValues(
                  alpha: .15,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.note_alt_outlined,
                size: 34,
              ),
            ),

            const SizedBox(height: 18),

            Text(
              'هنوز یادداشتی ندارید',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textDirection: TextDirection.rtl,
            ),

            const SizedBox(height: 7),

            Text(
              'اولین یادداشت خود را ایجاد کنید',
              style: textTheme.bodyMedium,
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }
}