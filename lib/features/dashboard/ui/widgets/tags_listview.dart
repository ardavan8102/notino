import 'package:flutter/material.dart';
import 'package:notino/core/constants/dimens.dart';
import 'package:notino/features/dashboard/ui/widgets/auto_sized_border.dart';
import 'package:notino/features/tags/models/tag_model.dart';

class TagsListView extends StatelessWidget {
  const TagsListView({
    super.key,
    required this.tags,
  });

  final List<TagModel> tags;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListView.builder(
      itemCount: 5,
      scrollDirection: .horizontal,
      itemBuilder: (context, index) {
        
        final tag = tags[index];
    
        return Padding(
          padding: EdgeInsets.only(
            left: index == tags.length - 1 ? 0 : AppDimens.marginMedium,
          ),
          child: AutoSizedContainer(
            color: Color(tag.color),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  tag.name,
                  style: textTheme.labelMedium
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}