import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';
import 'package:notino/features/tags/models/tag_model.dart';
import 'package:notino/features/tags/repository/tag_repository.dart';

final tagRepositoryProvider =
Provider<TagRepository>((ref){

  return TagRepository(
    Hive.box<TagModel>('tags')
  );

});


final tagsProvider =
Provider<List<TagModel>>((ref){

final repo =
ref.watch(tagRepositoryProvider);


return repo.getTags();

});