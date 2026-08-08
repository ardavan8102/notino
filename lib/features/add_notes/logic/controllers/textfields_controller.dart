import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addNewNoteProvider =
    NotifierProvider<AddNewNoteController, AddNewNoteState>(
  AddNewNoteController.new,
);

class AddNewNoteState {
  final bool isSaving;

  const AddNewNoteState({
    this.isSaving = false,
  });
}

class AddNewNoteController extends Notifier<AddNewNoteState> {
  late final TextEditingController titleController;
  late final TextEditingController contentController;

  late final FocusNode titleFocusNode;
  late final FocusNode contentFocusNode;

  @override
  AddNewNoteState build() {
    titleController = TextEditingController();
    contentController = TextEditingController();

    titleFocusNode = FocusNode();
    contentFocusNode = FocusNode();

    ref.onDispose(() {
      titleController.dispose();
      contentController.dispose();

      titleFocusNode.dispose();
      contentFocusNode.dispose();
    });

    return const AddNewNoteState();
  }

  void saveNote() {
    final title = titleController.text.trim();
    final content = contentController.text.trim();

    if (title.isEmpty && content.isEmpty) {
      return;
    }

    // Save logic later
  }

  void focusContent() {
    contentFocusNode.requestFocus();
  }
}