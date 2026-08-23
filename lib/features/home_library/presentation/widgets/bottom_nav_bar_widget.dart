import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// Bottom Navigation Bar Widget matching v2 design
class BottomNavBarWidget extends StatelessWidget {
  final bool isDarkMode;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const BottomNavBarWidget({
    super.key,
    required this.isDarkMode,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final navBg = isDarkMode ? AppTheme.darkBottomNavBackground : AppTheme.lightBottomNavBackground;
    final navBorder = isDarkMode ? AppTheme.darkBottomNavBorder : AppTheme.lightBottomNavBorder;
    final activePillBg = isDarkMode ? AppTheme.darkNavActivePill : AppTheme.lightNavActivePill;
    final activeIconColor = isDarkMode ? AppTheme.darkNavActiveIcon : AppTheme.lightNavActiveIcon;
    final inactiveIconColor = isDarkMode ? AppTheme.darkNavInactiveIcon : AppTheme.lightNavInactiveIcon;

    final navItems = [
      Icons.home_filled,
      Icons.folder_outlined,
      Icons.search_outlined,
      Icons.settings_outlined,
    ];

    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: navBg,
        border: Border(top: BorderSide(color: navBorder)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(navItems.length, (index) {
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () => onTabSelected(index),
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isSelected ? activePillBg : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: activePillBg.withOpacity(isDarkMode ? 0.25 : 0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                navItems[index],
                color: isSelected ? activeIconColor : inactiveIconColor,
                size: 22,
              ),
            ),
          );
        }),
      ),
    );
  }
}
