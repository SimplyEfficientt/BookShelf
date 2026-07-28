import 'package:flutter_test/flutter_test.dart';
import 'package:bookshelf/features/pdf_classifier/domain/entities/book_category.dart';
import 'package:bookshelf/features/metadata_enrichment/domain/entities/book_metadata.dart';
import 'package:bookshelf/features/metadata_enrichment/data/repositories/metadata_enrichment_repository_impl.dart';
import 'package:bookshelf/features/storage_organizer/data/services/storage_directory_organizer_service.dart';

void main() {
  group('Stage 2 Pipeline Tests', () {
    late MetadataEnrichmentRepositoryImpl metadataRepository;
    late StorageDirectoryOrganizerService organizerService;

    setUp(() {
      metadataRepository = MetadataEnrichmentRepositoryImpl();
      organizerService = StorageDirectoryOrganizerService(baseStorageRoot: '/tmp/BookShelfTest');
    });

    test('Generates correct physical folder move prompt based on category', () {
      final prompt = organizerService.generateOrganizationPrompt(
        sourceFilePath: '/downloads/Naruto_Vol_01.pdf',
        category: BookCategory.manga,
      );

      expect(prompt.suggestedDirectoryPath, equals('/tmp/BookShelfTest/Manga'));
      expect(prompt.category, equals(BookCategory.manga));
      expect(prompt.fileName, equals('Naruto_Vol_01.pdf'));
    });

    test('Fallback mechanism produces local metadata entity when offline', () async {
      final metadata = await metadataRepository.enrichMetadata(
        pdfPath: '/storage/sample_paper.pdf',
        rawTitle: '[2024]_sample_paper.pdf',
        category: BookCategory.document,
      );

      expect(metadata.title, equals('sample paper'));
      expect(metadata.source, equals(ApiProviderSource.localPdfFallback));
    });
  });
}
