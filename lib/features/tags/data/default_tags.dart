import 'package:flutter/material.dart';
import 'package:notino/core/constants/colors.dart';
import 'package:notino/features/tags/models/tag_model.dart';


class DefaultTags {


  static List<TagModel> tags = [

    TagModel(
      id: "all",
      name: "هـمــه",
      color: AppColors.yellow.toARGB32(),
      isDefault: true,
    ),

    TagModel(
      id: "important",
      name: "مهـم",
      color: Colors.white.withValues(alpha: .6).toARGB32(),
      isDefault: true,
    ),


    TagModel(
      id: "personal",
      name: "شـخصـی",
      color: Colors.white.withValues(alpha: .6).toARGB32(),
      isDefault: true,
    ),


    TagModel(
      id: "shop",
      name: "خـریــد",
      color: Colors.white.withValues(alpha: .6).toARGB32(),
      isDefault: true,
    ),


    TagModel(
      id: "study",
      name: "مطـالـعه",
      color: Colors.white.toARGB32(),
      isDefault: true,
    ),


  ];


}