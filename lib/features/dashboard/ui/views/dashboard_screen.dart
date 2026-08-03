import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:notino/app/extensions/sizedbox.dart';
import 'package:notino/core/constants/dimens.dart';
import 'package:notino/features/dashboard/ui/widgets/auto_sized_border.dart';
import 'package:notino/features/dashboard/ui/widgets/cards/big_card.dart';
import 'package:notino/features/dashboard/ui/widgets/cards/image_note_card.dart';
import 'package:notino/features/dashboard/ui/widgets/tags_listview.dart';
import 'package:notino/features/tags/providers/tag_provider.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    final tags = ref.watch(tagsProvider);

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
      
          // title & Version
          Row(
            mainAxisAlignment: .spaceBetween,
            crossAxisAlignment: .center,
            spacing: AppDimens.marginMedium,
            children: [
              Text(
                'نــوتیــنــو',
                style: textTheme.headlineSmall,
              ),
      
              Text(
                'نسخـه 0.1.0',
                style: textTheme.labelMedium,
              ),
            ],
          ),
      
          AppDimens.marginLarge.height,
      
          // tags
          SizedBox(
            height: size.height * .06,
            width: size.width,
            child: Row(
              spacing: AppDimens.marginMedium,
              children: [
                Expanded(
                  child: TagsListView(
                    tags: tags
                  )
                ),
      
                // add tag icon button
                Material(
                  color: Colors.white.withValues(alpha: .15),
                  borderRadius: BorderRadius.circular(AppDimens.borderRadiusLarge),
                  child: InkWell(
                    onTap: () {
                      // Your tap logic here
                    },
                    splashColor: Colors.white.withValues(alpha: .5),
                    borderRadius: BorderRadius.circular(AppDimens.borderRadiusLarge),
                    child: SizedBox(
                      width: size.width * .13,
                      height: double.infinity,
                      child: Icon(
                        LucideIcons.plus300,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      
          AppDimens.marginLarge.height,
      
          // bento grid 1/2
          SizedBox(
            height: size.height * .4,
            width: size.width,
            child: Row(
              spacing: AppDimens.marginMedium,
              children: [

                // right Column
                Expanded(
                  flex: 1,
                  child: BigCardWidget(),
                ),
      
                // left Column
                Expanded(
                  flex: 1,
                  child: Column(
                    spacing: AppDimens.marginMedium,
                    children: [
      
                      // Top Box
                      Expanded(
                        flex: 4,
                        child: ImageNoteCardBox(),
                      ),
      
                      // Down Box
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: .2),
                            borderRadius: BorderRadius.circular(AppDimens.borderRadiusXLarge),
                          ),
                          child: Stack(
                            children: [

                              // circle shapes
                              Positioned(
                                bottom: 30,
                                left: -200,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: .circle,
                                    color: Colors.white.withValues(alpha: .05),
                                  ),
                                  height: size.width * .4,
                                  width: size.width * .4,
                                ),
                              ),

                              Positioned(
                                top: 20,
                                right: -200,
                                left: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: .circle,
                                    color: Colors.white.withValues(alpha: .1),
                                  ),
                                  height: size.width * .2,
                                  width: size.width * .2,
                                ),
                              ),

                              Positioned(
                                top: AppDimens.paddingMedium,
                                right: AppDimens.paddingMedium,
                                child: Column(
                                  spacing: 4,
                                  crossAxisAlignment: .start,
                                  children: [

                                    Text(
                                      'ذخـیره فـایـل‌هـا',
                                      style: textTheme.labelLarge!.copyWith(
                                        fontSize: 14,
                                        fontWeight: .bold
                                      )
                                    ),

                                    Text(
                                      'در یادداشت',
                                      style: textTheme.labelLarge!.copyWith(
                                        fontSize: 12,
                                        fontWeight: .normal
                                      )
                                    ),
                                  ],
                                ),
                              ),


                              Positioned(
                                bottom: AppDimens.paddingMedium,
                                left: AppDimens.paddingMedium,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: .3),
                                    borderRadius: BorderRadius.circular(AppDimens.borderRadiusLarge),
                                  ),
                                  padding: EdgeInsets.all(AppDimens.paddingSmall),
                                  child: Icon(
                                    LucideIcons.arrowLeft,
                                    size: 24,
                                  ),
                                )
                              )

                            ],
                          ),
                        ),
                      ),
      
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // big right column - vocal note
}