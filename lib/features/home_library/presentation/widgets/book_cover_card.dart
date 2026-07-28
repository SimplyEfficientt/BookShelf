import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/book_item.dart';

/// Netflix-style Book Cover Card with reading progress overlay badge.
class BookCoverCard extends StatelessWidget {
  final BookItem book;
  final VoidCallback onTap;
  final double width;
  final double height;

  const BookCoverCard({
    super.key,
    required this.book,
    required this.onTap,
    this.width = 130,
    this.height = 190,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFF1E1E1E),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Book Cover Image
            Positioned.fill(
              child: book.coverUrl != null && book.coverUrl!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: book.coverUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: const Color(0xFF2A2A2A),
                        child: const Center(child: CircularProgressIndicator(strokeWidth: 2, color: Colors.redAccent)),
                      ),
                      errorWidget: (context, url, error) => _buildFallbackCover(),
                    )
                  : _buildFallbackCover(),
            ),

            // Subtle dark gradient vignette at the bottom for text readability
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 70,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black87, Colors.black],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),

            // Reading Progress Indicator Overlay (Netflix-style progress bar & badge)
            Positioned(
              bottom: 6,
              left: 6,
              right: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Progress Bar Line
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: LinearProgressIndicator(
                      value: book.progressPercentage,
                      minHeight: 3,
                      backgroundColor: Colors.white24,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.redAccent),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    book.progressFormatted,
                    style: GoogleFonts.inter(
                      color: Colors.white70,
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackCover() {
    return Container(
      color: const Color(0xFF332244),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.book, color: Colors.white70, size: 36),
          const SizedBox(height: 8),
          Text(
            book.title,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
