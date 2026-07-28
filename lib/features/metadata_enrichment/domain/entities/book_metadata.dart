/// External metadata provider source enumeration.
enum ApiProviderSource {
  googleBooks('Google Books API'),
  openLibrary('Open Library API'),
  aniList('AniList API'),
  mangaDex('MangaDex API'),
  localPdfFallback('Local PDF Page 1 Render');

  final String displayName;
  const ApiProviderSource(this.displayName);
}

/// Consolidated Metadata Model from external APIs or local PDF fallback.
class BookMetadata {
  final String title;
  final List<String> authors;
  final String? description;
  final String? publisher;
  final String? publishedDate;
  final String? isbn;
  final String? highResCoverUrl;
  final ApiProviderSource source;
  final List<String> genres;
  final double? rating;

  const BookMetadata({
    required this.title,
    required this.authors,
    this.description,
    this.publisher,
    this.publishedDate,
    this.isbn,
    this.highResCoverUrl,
    required this.source,
    this.genres = const [],
    this.rating,
  });

  @override
  String toString() {
    return 'BookMetadata(title: "$title", authors: $authors, source: ${source.displayName}, cover: ${highResCoverUrl != null ? "Available" : "None"})';
  }
}
