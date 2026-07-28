import 'package:flutter_test/flutter_test.dart';
import 'package:bookshelf/features/pdf_classifier/domain/entities/book_category.dart';
import 'package:bookshelf/features/pdf_classifier/domain/entities/pdf_metadata.dart';
import 'package:bookshelf/features/pdf_classifier/data/services/local_pdf_classifier_service.dart';

void main() {
  group('LocalPdfClassifierService Heuristic Tests', () {
    late LocalPdfClassifierService classifierService;

    setUp(() {
      classifierService = LocalPdfClassifierService();
    });

    test('Classifies low text density PDF with manga keywords as Manga', () {
      const metadata = PdfMetadata(
        filePath: '/storage/manga_vol_1.pdf',
        fileName: 'Manga_Volume_01.pdf',
        totalPages: 180,
        isEncrypted: false,
        totalCharacterCount: 5400,
        averageCharsPerPage: 30.0, // Low text density = graphic pages
        detectedKeywords: ['manga', 'volume', 'chapter 1'],
      );

      final result = classifierService.evaluateClassification(metadata);

      expect(result.category, equals(BookCategory.manga));
      expect(result.confidenceScore, greaterThanOrEqualTo(0.85));
    });

    test('Classifies high page count document with ISBN and TOC keywords as Textbook', () {
      const metadata = PdfMetadata(
        filePath: '/storage/calculus_10th_edition.pdf',
        fileName: 'Calculus_10th_Edition.pdf',
        totalPages: 850,
        isEncrypted: false,
        totalCharacterCount: 1275000,
        averageCharsPerPage: 1500.0,
        detectedKeywords: ['table of contents', 'isbn', 'edition', 'index', 'chapter', 'references'],
      );

      final result = classifierService.evaluateClassification(metadata);

      expect(result.category, equals(BookCategory.textbook));
      expect(result.confidenceScore, greaterThanOrEqualTo(0.90));
    });

    test('Classifies uniform high-density text with Web Novel keywords as Web Novel', () {
      const metadata = PdfMetadata(
        filePath: '/storage/solo_leveling_v1.pdf',
        fileName: 'Solo_Leveling_V1.pdf',
        totalPages: 320,
        isEncrypted: false,
        totalCharacterCount: 576000,
        averageCharsPerPage: 1800.0,
        detectedKeywords: ['prologue', 'status screen', 'chapter', 'web novel'],
      );

      final result = classifierService.evaluateClassification(metadata);

      expect(result.category, equals(BookCategory.webNovel));
      expect(result.confidenceScore, greaterThanOrEqualTo(0.85));
    });

    test('Classifies short page count file as General Document', () {
      const metadata = PdfMetadata(
        filePath: '/storage/project_report.pdf',
        fileName: 'Q3_Project_Report.pdf',
        totalPages: 12,
        isEncrypted: false,
        totalCharacterCount: 8400,
        averageCharsPerPage: 700.0,
        detectedKeywords: ['report', 'summary', 'draft'],
      );

      final result = classifierService.evaluateClassification(metadata);

      expect(result.category, equals(BookCategory.document));
      expect(result.confidenceScore, greaterThanOrEqualTo(0.70));
    });
  });
}
