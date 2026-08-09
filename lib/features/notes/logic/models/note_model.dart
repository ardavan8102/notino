import 'package:hive_ce/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 1)
class NoteModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String content;

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  final List<NoteAttachment> attachments;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.attachments,
  });
}

@HiveType(typeId: 2)
class NoteAttachment {
  @HiveField(0)
  final String type;

  @HiveField(1)
  final String path;

  @HiveField(2)
  final String name;

  NoteAttachment({
    required this.type,
    required this.path,
    required this.name,
  });
}