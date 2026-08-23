import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';

/// Search Input Bar Widget for Home v2
class SearchBarWidget extends StatelessWidget {
  final bool isDarkMode;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const SearchBarWidget({
    super.key,
    required this.isDarkMode,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isDarkMode ? AppTheme.darkSearchBackground : AppTheme.lightSearchBackground;
    final borderColor = isDarkMode ? AppTheme.darkSearchBorder : Colors.transparent;
    final textColor = isDarkMode ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final hintColor = isDarkMode ? AppTheme.darkTextMuted : AppTheme.lightTextMuted;

    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: isDarkMode ? Border.all(color: borderColor) : null,
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 18,
            color: hintColor,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.5,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
              decoration: InputDecoration(
                hintText: 'Search your shelf...',
                hintStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                  color: hintColor,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
