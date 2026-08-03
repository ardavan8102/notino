import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:notino/core/constants/dimens.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .15),
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusLarge),
      ),
      height: size.height * .09,
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingLarge, vertical: AppDimens.paddingSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(0, LucideIcons.home, 'خــانـه', textTheme),
          _buildNavItem(1, LucideIcons.fileText, 'یادداشت‌ها', textTheme),
          _buildNavItem(2, LucideIcons.settings, 'تنظیمات', textTheme),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, TextTheme textTheme) {
    final isSelected = currentIndex == index;

    final Color activeColor = Colors.white;
    final Color inactiveColor = Colors.white.withValues(alpha: .3);
    final Color currentColor = isSelected ? activeColor : inactiveColor;

    return InkWell(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 5, 
        children: [
          AnimatedScale(
            scale: isSelected ? 1.2 : 1.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutBack,
            child: Icon(
              icon,
              size: 24,
              color: currentColor, 
            ),
          ),
          
          AnimatedDefaultTextStyle(
            style: textTheme.labelSmall!.copyWith(
              fontSize: isSelected ? 12 : 10,
              color: currentColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Text(label),
          ),
        ],
      ),
    );
  }

}