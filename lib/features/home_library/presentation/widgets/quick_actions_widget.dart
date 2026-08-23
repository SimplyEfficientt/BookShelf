import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';

class QuickActionItem {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const QuickActionItem({
    required this.label,
    required this.icon,
    required this.onTap,
  });
}

/// 4-Column Quick Action Button Grid (Scan, Import, Merge, New)
class QuickActionsWidget extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onScanTap;
  final VoidCallback onImportTap;
  final VoidCallback onMergeTap;
  final VoidCallback onNewTap;

  const QuickActionsWidget({
    super.key,
    required this.isDarkMode,
    required this.onScanTap,
    required this.onImportTap,
    required this.onMergeTap,
    required this.onNewTap,
  });

  @override
  Widget build(BuildContext context) {
    final actions = [
      QuickActionItem(label: 'Scan', icon: Icons.qr_code_scanner, onTap: onScanTap),
      QuickActionItem(label: 'Import', icon: Icons.file_upload_outlined, onTap: onImportTap),
      QuickActionItem(label: 'Merge', icon: Icons.layers_outlined, onTap: onMergeTap),
      QuickActionItem(label: 'New', icon: Icons.create_new_folder_outlined, onTap: onNewTap),
    ];

    final cardBg = isDarkMode ? AppTheme.darkCardBackground : AppTheme.lightCardBackground;
    final cardBorder = isDarkMode ? AppTheme.darkCardBorder : AppTheme.lightCardBorder;
    final textColor = isDarkMode ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;

    return Row(
      children: actions.map((action) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Material(
              color: cardBg,
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                onTap: action.onTap,
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: cardBorder),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(action.icon, color: textColor, size: 22),
                      const SizedBox(height: 8),
                      Text(
                        action.label,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
