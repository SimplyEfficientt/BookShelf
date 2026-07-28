import 'dart:typed_data';
import 'package:bookshelf/features/pdf_classifier/domain/entities/book_category.dart';
import '../../domain/entities/book_metadata.dart';
import '../datasources/google_books_datasource.dart';
import '../datasources/anilist_manga_datasource.dart';

/// Central Metadata & Cover Art Enrichment Pipeline.
class MetadataEnrichmentRepositoryImpl {
  final GoogleBooksDataSource _googleBooksDataSource;
  final AniListMangaDataSource _aniListMangaDataSource;

  MetadataEnrichmentRepositoryImpl({
    GoogleBooksDataSource? googleBooksDataSource,
    AniListMangaDataSource? aniListMangaDataSource,
  })  : _googleBooksDataSource = googleBooksDataSource ?? GoogleBooksDataSource(),
        _aniListMangaDataSource = aniListMangaDataSource ?? AniListMangaDataSource();

  /// Enriches book metadata by targeting category-specific external APIs,
  /// falling back seamlessly to local PDF extraction if offline or unfound.
  Future<BookMetadata> enrichMetadata({
    required String pdfPath,
    required String rawTitle,
    required BookCategory category,
    Uint8List? fallbackPageOneBytes,
  }) async {
    final cleanTitle = _cleanTitleForQuery(rawTitle);
    BookMetadata? enrichedResult;

    // 1. Target Manga or Light Novels via AniList API first
    if (category == BookCategory.manga || category == BookCategory.webNovel) {
      enrichedResult = await _aniListMangaDataSource.fetchMangaMetadata(cleanTitle);
    }

    // 2. Target Google Books API for Novels, Textbooks, or if AniList missed
    enrichedResult ??= await _googleBooksDataSource.fetchBookMetadata(cleanTitle);

    // 3. Fallback Mechanism: If offline or no API match, return Local PDF Metadata
    if (enrichedResult != null && enrichedResult.highResCoverUrl != null) {
      return enrichedResult;
    }

    return BookMetadata(
      title: cleanTitle,
      authors: ['Local Document'],
      description: 'Imported local PDF document.',
      source: ApiProviderSource.localPdfFallback,
      genres: [category.displayName],
    );
  }

  /// Sanitizes raw PDF filenames into clean search terms (strips extension, underscores, tags).
  String _cleanTitleForQuery(String rawFilename) {
    String name = rawFilename.split('/').last;
    if (name.contains('.')) {
      name = name.substring(0, name.lastIndexOf('.'));
    }
    // Remove bracket tags like [MangaDex] or (2024)
    name = name.replaceAll(RegExp(r'\[.*?\]|\(.*?\)', caseSensitive: false), '');
    // Replace underscores and dashes with spaces
    name = name.replaceAll(RegExp(r'[_]+'), ' ').replaceAll('-', ' ');
    return name.trim();
  }
}
