import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:notino/features/tags/models/tag_model.dart';

class HiveDatabase {

  static Future<void> initialize() async {

    await Hive.initFlutter();

    Hive.registerAdapter(
      TagModelAdapter()
    );

  }


  static Future<void> openBoxes() async {

    await Hive.openBox<TagModel>('tags');

    await Hive.openBox('notes');

    await Hive.openBox('settings');

  }

}