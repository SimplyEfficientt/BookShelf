import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Top App Bar Header Widget (Consistent Centered Layout for Light & Dark Mode)
class AppHeaderWidget extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;
  final VoidCallback? onProfileTap;

  const AppHeaderWidget({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    final avatarBg = isDarkMode ? const Color(0xFF1A1A1E) : Colors.white;
    final avatarBorder = isDarkMode ? const Color(0xFF2C2C32) : const Color(0xFFE2E2E8);
    final iconColor = isDarkMode ? const Color(0xFFE2E8F0) : const Color(0xFF111115);
    final titleColor = isDarkMode ? Colors.white : const Color(0xFF111115);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Avatar Badge (Smiling Face Outline Circle)
        GestureDetector(
          onTap: onProfileTap,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: avatarBg,
              shape: BoxShape.circle,
              border: Border.all(color: avatarBorder, width: 1.5),
            ),
            child: Icon(
              Icons.sentiment_satisfied_alt_outlined,
              color: iconColor,
              size: 19,
            ),
          ),
        ),

        // Centered App Title
        Text(
          'Bookshelf',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: titleColor,
          ),
        ),

        // Right Actions (Theme Toggle + User Profile Circle)
        Row(
          children: [
            IconButton(
              icon: Icon(
                isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: isDarkMode ? const Color(0xFFFACC15) : const Color(0xFF111115),
                size: 20,
              ),
              onPressed: onToggleTheme,
              tooltip: isDarkMode ? 'Switch to Light Theme' : 'Switch to Dark Theme',
            ),
            GestureDetector(
              onTap: onProfileTap,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: avatarBg,
                  shape: BoxShape.circle,
                  border: Border.all(color: avatarBorder, width: 1.5),
                ),
                child: Icon(
                  Icons.person_outline,
                  color: iconColor,
                  size: 19,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
