import 'package:bookshelf/features/pdf_classifier/domain/entities/book_category.dart';

/// Core domain model representing a book in the user's BookShelf library.
class BookItem {
  final String id;
  final String filePath;
  final String title;
  final List<String> authors;
  final BookCategory category;
  final String? coverUrl;
  final int currentPage;
  final int totalPages;
  final DateTime lastReadTimestamp;
  final List<String> virtualShelves;

  const BookItem({
    required this.id,
    required this.filePath,
    required this.title,
    required this.authors,
    required this.category,
    this.coverUrl,
    this.currentPage = 1,
    required this.totalPages,
    required this.lastReadTimestamp,
    this.virtualShelves = const [],
  });

  /// Calculates exact reading progress percentage.
  double get progressPercentage => totalPages > 0 ? (currentPage / totalPages).clamp(0.0, 1.0) : 0.0;

  /// Formatted progress string (e.g. "Page 142 / 350 • 41%")
  String get progressFormatted => 'Page $currentPage / $totalPages • ${(progressPercentage * 100).toStringAsFixed(0)}%';

  BookItem copyWith({
    int? currentPage,
    DateTime? lastReadTimestamp,
    List<String>? virtualShelves,
    String? coverUrl,
  }) {
    return BookItem(
      id: id,
      filePath: filePath,
      title: title,
      authors: authors,
      category: category,
      coverUrl: coverUrl ?? this.coverUrl,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages,
      lastReadTimestamp: lastReadTimestamp ?? this.lastReadTimestamp,
      virtualShelves: virtualShelves ?? this.virtualShelves,
    );
  }
}
