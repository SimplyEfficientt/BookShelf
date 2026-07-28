import 'package:dio/dio.dart';
import '../../domain/entities/book_metadata.dart';

/// Data source for querying Google Books REST API.
class GoogleBooksDataSource {
  final Dio _dio;
  static const String _baseUrl = 'https://www.googleapis.com/books/v1/volumes';

  GoogleBooksDataSource({Dio? dio}) : _dio = dio ?? Dio();

  /// Search for book metadata by title or ISBN.
  Future<BookMetadata?> fetchBookMetadata(String query) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'q': query,
          'maxResults': 1,
          'printType': 'books',
        },
        options: Options(receiveTimeout: const Duration(seconds: 5)),
      );

      if (response.statusCode == 200 && response.data != null) {
        final items = response.data['items'] as List?;
        if (items != null && items.isNotEmpty) {
          final volumeInfo = items.first['volumeInfo'] as Map<String, dynamic>?;
          if (volumeInfo != null) {
            final imageLinks = volumeInfo['imageLinks'] as Map<String, dynamic>?;
            final coverUrl = imageLinks?['extraLarge'] ??
                imageLinks?['large'] ??
                imageLinks?['medium'] ??
                imageLinks?['thumbnail'];

            final authors = (volumeInfo['authors'] as List?)?.map((e) => e.toString()).toList() ?? ['Unknown Author'];
            final categories = (volumeInfo['categories'] as List?)?.map((e) => e.toString()).toList() ?? [];

            // Upgrade http thumbnail to https if necessary
            final secureCoverUrl = coverUrl?.replaceFirst('http://', 'https://');

            return BookMetadata(
              title: volumeInfo['title'] ?? query,
              authors: authors,
              description: volumeInfo['description'],
              publisher: volumeInfo['publisher'],
              publishedDate: volumeInfo['publishedDate'],
              isbn: _extractIsbn(volumeInfo['industryIdentifiers'] as List?),
              highResCoverUrl: secureCoverUrl,
              source: ApiProviderSource.googleBooks,
              genres: categories,
              rating: (volumeInfo['averageRating'] as num?)?.toDouble(),
            );
          }
        }
      }
    } catch (_) {
      // Network error or timeout: Return null for fallback
    }
    return null;
  }

  String? _extractIsbn(List? identifiers) {
    if (identifiers == null) return null;
    for (final item in identifiers) {
      if (item is Map && item['type'] == 'ISBN_13') {
        return item['identifier'] as String?;
      }
    }
    return null;
  }
}
