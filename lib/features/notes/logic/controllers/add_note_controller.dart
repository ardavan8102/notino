import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:notino/features/notes/logic/models/note_model.dart';

final addNoteControllerProvider =
    NotifierProvider<AddNoteController, List<NoteAttachment>>(
  AddNoteController.new,
);

class AddNoteController extends Notifier<List<NoteAttachment>> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  final titleFocusNode = FocusNode();
  final contentFocusNode = FocusNode();

  final ImagePicker _imagePicker = ImagePicker();

  @override
  List<NoteAttachment> build() {
    ref.onDispose(() {
      titleController.dispose();
      contentController.dispose();

      titleFocusNode.dispose();
      contentFocusNode.dispose();
    });

    return [];
  }

  // ------------------------------------------------------------
  // Images
  // ------------------------------------------------------------

  Future<void> addImages() async {
    final images = await _imagePicker.pickMultiImage();

    if (images.isEmpty) return;

    final newAttachments = images.map(
      (image) {
        return NoteAttachment(
          type: 'image',
          path: image.path,
          name: image.name,
        );
      },
    ).toList();

    state = [
      ...state,
      ...newAttachments,
    ];
  }

  // ------------------------------------------------------------
  // Audio
  // ------------------------------------------------------------

  Future<void> addAudio() async {
    final result = await FilePicker.pickFiles(
      type: FileType.audio,
      allowMultiple: true,
    );

    if (result == null) return;

    final newAttachments = result.files
        .where((file) => file.path != null)
        .map(
          (file) => NoteAttachment(
            type: 'audio',
            path: file.path!,
            name: file.name,
          ),
        )
        .toList();

    state = [
      ...state,
      ...newAttachments,
    ];
  }

  // ------------------------------------------------------------
  // Other files
  // ------------------------------------------------------------

  Future<void> addFiles() async {
    final result = await FilePicker.pickFiles(
      allowMultiple: true,
    );

    if (result == null) return;

    final newAttachments = result.files
        .where((file) => file.path != null)
        .map(
          (file) => NoteAttachment(
            type: 'file',
            path: file.path!,
            name: file.name,
          ),
        )
        .toList();

    state = [
      ...state,
      ...newAttachments,
    ];
  }

  // ------------------------------------------------------------
  // Remove attachment
  // ------------------------------------------------------------

  void removeAttachment(NoteAttachment attachment) {
    state = state
        .where(
          (item) => item.path != attachment.path,
        )
        .toList();
  }

  // ------------------------------------------------------------
  // Reset
  // ------------------------------------------------------------

  void reset() {
    titleController.clear();
    contentController.clear();

    titleFocusNode.unfocus();
    contentFocusNode.unfocus();

    state = [];
  }
}