import 'package:hive_ce/hive.dart';

import '../models/tag_model.dart';


class TagRepository {


  final Box<TagModel> box;


  TagRepository(this.box);



  List<TagModel> getTags(){

    return box.values.toList();

  }



  Future<void> addTag(TagModel tag) async {

    await box.put(
    tag.id,
    tag,
    );

  }



  Future<void> deleteTag(String id) async {

    await box.delete(id);

  }


}