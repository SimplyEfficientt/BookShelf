import 'package:dio/dio.dart';
import '../../domain/entities/book_metadata.dart';

/// Data source for querying AniList GraphQL API for Manga & Light Novels.
class AniListMangaDataSource {
  final Dio _dio;
  static const String _graphqlUrl = 'https://graphql.anilist.co';

  AniListMangaDataSource({Dio? dio}) : _dio = dio ?? Dio();

  static const String _query = '''
  query (\$search: String) {
    Media(search: \$search, type: MANGA) {
      id
      title {
        romaji
        english
        native
      }
      description
      coverImage {
        extraLarge
        large
        medium
      }
      genres
      averageScore
      staff {
        nodes {
          name {
            full
          }
        }
      }
    }
  }
  ''';

  /// Search AniList for Manga/Light Novel metadata.
  Future<BookMetadata?> fetchMangaMetadata(String queryTitle) async {
    try {
      final response = await _dio.post(
        _graphqlUrl,
        data: {
          'query': _query,
          'variables': {'search': queryTitle},
        },
        options: Options(
          headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
          receiveTimeout: const Duration(seconds: 5),
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final media = response.data['data']?['Media'] as Map<String, dynamic>?;
        if (media != null) {
          final titleMap = media['title'] as Map<String, dynamic>?;
          final title = titleMap?['english'] ?? titleMap?['romaji'] ?? queryTitle;
          final coverImage = media['coverImage'] as Map<String, dynamic>?;
          final coverUrl = coverImage?['extraLarge'] ?? coverImage?['large'];

          final genres = (media['genres'] as List?)?.map((e) => e.toString()).toList() ?? [];
          final staffNodes = media['staff']?['nodes'] as List?;
          final authors = staffNodes?.map((node) => node['name']?['full']?.toString() ?? '').where((s) => s.isNotEmpty).toList() ?? ['Manga Creator'];

          final rawScore = media['averageScore'] as num?;
          final rating = rawScore != null ? (rawScore / 20.0) : null; // Convert 0-100 to 0-5 stars scale

          return BookMetadata(
            title: title,
            authors: authors.isEmpty ? ['Manga Creator'] : authors,
            description: media['description']?.toString().replaceAll(RegExp(r'<[^>]*>'), ''), // Strip HTML
            highResCoverUrl: coverUrl,
            source: ApiProviderSource.aniList,
            genres: genres,
            rating: rating,
          );
        }
      }
    } catch (_) {
      // Fallback handling if offline or no result
    }
    return null;
  }
}
