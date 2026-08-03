import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:notino/core/constants/dimens.dart';
import 'package:notino/features/dashboard/ui/widgets/auto_sized_border.dart';

class BigCardWidget extends StatelessWidget {
  const BigCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .2),
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusXLarge),
      ),
      child: Stack(
        children: [
          
          // title
          Positioned(
            top: 20,
            left: 15,
            right: 15,
            child: Column(
              children: [
                Text(
                  'یـادداشـتــ',
                  style: textTheme.titleMedium,
                ),

                Text(
                  'صـــوتــی',
                  style: textTheme.titleMedium,
                ),
              ],
            ),
          ),

          // circle shapes
          Positioned(
            bottom: 80,
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
            bottom: 60,
            right: -180,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                shape: .circle,
                color: Colors.white.withValues(alpha: .08),
              ),
              height: size.width * .1,
              width: size.width * .1,
            ),
          ),

          // icon button
          Positioned(
            bottom: 20,
            left: 15,
            right: 15,
            child: AutoSizedContainer(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimens.paddingSmall,
                vertical: AppDimens.paddingSmall
              ),
              color: Colors.white,
              child: GestureDetector(
                onTap: () {
                  
                },
                child: Row(
                  mainAxisAlignment: .center,
                  crossAxisAlignment: .center,
                  spacing: AppDimens.marginSmall,
                  children: [
                    Text(
                      'ضبط کنید',
                      style: textTheme.labelMedium,
                    ),
                
                    Icon(LucideIcons.mic),
                  ],
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}