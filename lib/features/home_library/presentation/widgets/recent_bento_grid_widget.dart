import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/book_item.dart';

/// 2-Column Bento Grid Widget for Recent Documents (RECENT section)
class RecentBentoGridWidget extends StatelessWidget {
  final bool isDarkMode;
  final List<BookItem> books;
  final int totalFilesCount;
  final ValueChanged<BookItem>? onBookTap;

  const RecentBentoGridWidget({
    super.key,
    required this.isDarkMode,
    required this.books,
    required this.totalFilesCount,
    this.onBookTap,
  });

  @override
  Widget build(BuildContext context) {
    final sectionTitleColor = isDarkMode ? AppTheme.darkTextMuted : AppTheme.lightSectionTitle;
    final metaColor = isDarkMode ? AppTheme.darkTextMuted : AppTheme.lightTextMuted;
    final cardBg = isDarkMode ? AppTheme.darkCardBackground : AppTheme.lightCardBackground;
    final cardBorder = isDarkMode ? AppTheme.darkCardBorder : AppTheme.lightCardBorder;
    final previewBg = isDarkMode ? AppTheme.darkPreviewBoxBackground : AppTheme.lightPreviewBoxBackground;
    final titleColor = isDarkMode ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;

    return Column(
      children: [
        // Section Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'RECENT',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.0,
                color: sectionTitleColor,
              ),
            ),
            Text(
              '$totalFilesCount files',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: metaColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // 2-Column Bento Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: books.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.95,
          ),
          itemBuilder: (context, index) {
            final book = books[index];
            final isFirst = index == 0;

            return GestureDetector(
              onTap: () => onBookTap?.call(book),
              child: Container(
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: cardBorder),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDarkMode ? 0.2 : 0.03),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Thumbnail / Preview Box
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: previewBg,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(13)),
                        ),
                        child: Center(
                          child: book.coverUrl != null
                              ? Image.network(
                                  book.coverUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Icon(
                                    Icons.insert_drive_file_outlined,
                                    color: isDarkMode ? const Color(0xFF4A4A52) : const Color(0xFFA0A0AA),
                                    size: 28,
                                  ),
                                )
                              : Icon(
                                  Icons.insert_drive_file_outlined,
                                  color: isDarkMode ? const Color(0xFF4A4A52) : const Color(0xFFA0A0AA),
                                  size: 28,
                                ),
                        ),
                      ),
                    ),

                    // Bottom Document Metadata Area
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (isDarkMode) ...[
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: isFirst ? Colors.white : const Color(0xFF64748B),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                              ],
                              Expanded(
                                child: Text(
                                  book.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w700,
                                    color: titleColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            book.formattedSizeAndPages,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: metaColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
