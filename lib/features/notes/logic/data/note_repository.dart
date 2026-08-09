import 'package:hive_ce/hive.dart';
import 'package:notino/features/notes/logic/models/note_model.dart';

class NoteRepository {
  static const String boxName = 'notes';

  Box<NoteModel> get _box => Hive.box<NoteModel>(boxName);

  Future<void> saveNote(NoteModel note) async {
    await _box.put(note.id, note);
  }

  Future<void> deleteNote(String id) async {
    await _box.delete(id);
  }

  NoteModel? getNote(String id) {
    return _box.get(id);
  }

  List<NoteModel> getNotes() {
    return _box.values.toList();
  }

  Stream<BoxEvent> watchNotes() {
    return _box.watch();
  }
}