import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';


part 'tag_model.g.dart';


@HiveType(typeId: 0)
class TagModel extends HiveObject {


  @HiveField(0)
  late String id;


  @HiveField(1)
  late String name;


  @HiveField(2)
  late int color;


  @HiveField(3)
  late bool isDefault;


  TagModel({
    required this.id,
    required this.name,
    required this.color,
    this.isDefault = false,
  });


  Color get tagColor {
    return Color(color);
  }

}