import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';

class ShelfItemData {
  final String title;
  final int count;

  const ShelfItemData({required this.title, required this.count});
}

/// 5 Vertical Shelf Book Spines Row (YOUR SHELVES section)
class ShelvesRowWidget extends StatelessWidget {
  final bool isDarkMode;
  final List<ShelfItemData> shelves;
  final ValueChanged<ShelfItemData>? onShelfTap;

  const ShelvesRowWidget({
    super.key,
    required this.isDarkMode,
    required this.shelves,
    this.onShelfTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeMap = isDarkMode ? AppTheme.darkShelves : AppTheme.lightShelves;
    final sectionTitleColor = isDarkMode ? AppTheme.darkTextMuted : AppTheme.lightSectionTitle;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'YOUR SHELVES',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 10.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0,
            color: sectionTitleColor,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: shelves.map((shelf) {
            final theme = themeMap[shelf.title] ?? themeMap.values.first;

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.5),
                child: GestureDetector(
                  onTap: () => onShelfTap?.call(shelf),
                  child: Container(
                    height: 135,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                    decoration: BoxDecoration(
                      gradient: theme.gradient,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: isDarkMode
                          ? Border.all(color: Colors.white.withOpacity(0.06))
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Vertical Rotated Title Text
                        Expanded(
                          child: Center(
                            child: RotatedBox(
                              quarterTurns: 3,
                              child: Text(
                                shelf.title,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.2,
                                  color: theme.textColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        // Circular Count Badge
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: theme.badgeBackgroundColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              '${shelf.count}',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: theme.badgeTextColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
