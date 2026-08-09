import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notino/features/notes/logic/data/note_repository.dart';
import 'package:notino/features/notes/logic/models/note_model.dart';

final noteRepositoryProvider = Provider<NoteRepository>((ref) {
  return NoteRepository();
});

final noteControllerProvider =
    NotifierProvider<NoteController, List<NoteModel>>(
  NoteController.new,
);

class NoteController extends Notifier<List<NoteModel>> {
  late final NoteRepository _repository;

  @override
  List<NoteModel> build() {
    _repository = ref.read(noteRepositoryProvider);

    return _repository.getNotes();
  }

  // ------------------------------------------------------------
  // Refresh notes
  // ------------------------------------------------------------

  void refresh() {
    state = _repository.getNotes();
  }

  // ------------------------------------------------------------
  // Save
  // ------------------------------------------------------------

  Future<void> saveNote({
    required String title,
    required String content,
    required List<NoteAttachment> attachments,
  }) async {
    final note = NoteModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
      content: content.trim(),
      createdAt: DateTime.now(),
      attachments: attachments,
    );

    await _repository.saveNote(note);

    refresh();
  }

  // ------------------------------------------------------------
  // Delete
  // ------------------------------------------------------------

  Future<void> deleteNote(String id) async {
    await _repository.deleteNote(id);

    refresh();
  }

  // ------------------------------------------------------------
  // Get single note
  // ------------------------------------------------------------

  NoteModel? getNote(String id) {
    return _repository.getNote(id);
  }
}