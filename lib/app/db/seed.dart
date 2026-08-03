import 'package:hive_ce/hive.dart';
import 'package:notino/features/tags/data/default_tags.dart';
import 'package:notino/features/tags/models/tag_model.dart';

class DatabaseSeeder {


  static Future<void> seedTags() async {


    final box = Hive.isBoxOpen('tags')
        ? Hive.box<TagModel>('tags')
        : await Hive.openBox<TagModel>('tags');


    for (final tag in DefaultTags.tags) {


      if (!box.containsKey(tag.id)) {

        await box.put(
          tag.id,
          tag,
        );

      }

    }

  }

}