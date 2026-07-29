import '../../domain/entities/book_category.dart';
import '../../domain/entities/heuristic_score.dart';
import '../../domain/entities/pdf_metadata.dart';

/// Offline-first Heuristic Classifier Service for PDF documents.
class LocalPdfClassifierService {
  // Keyword sets for structural scan
  static const Set<String> _textbookKeywords = {
    'contents',
    'table of contents',
    'index',
    'isbn',
    'edition',
    'references',
    'bibliography',
    'preface',
    'glossary',
    'university',
    'press',
    'copyright',
    'acknowledgements',
  };

  static const Set<String> _mangaKeywords = {
    'manga',
    'comic',
    'volume',
    'chapter',
    'artist',
    'illustrator',
    'graphic novel',
  };

  static const Set<String> _webNovelKeywords = {
    'prologue',
    'web novel',
    'light novel',
    'syosetu',
    'wuxia',
    'xianxia',
    'system',
    'status screen',
    'reincarnat',
    'transmigrat',
    'chapter',
    'volume',
  };

  static const Set<String> _documentKeywords = {
    'report',
    'manual',
    'guide',
    'summary',
    'draft',
    'specification',
    'notice',
    'subject',
    'executive summary',
    'version',
  };

  /// Classifies a PDF document using structural metrics and keyword frequency heuristic scores.
  HeuristicScore evaluateClassification(PdfMetadata metadata) {
    final double avgChars = metadata.averageCharsPerPage;
    final int pageCount = metadata.totalPages;
    final List<String> detectedKeywords = metadata.detectedKeywords.map((k) => k.toLowerCase()).toList();

    int textbookHits = 0;
    int mangaHits = 0;
    int webNovelHits = 0;
    int docHits = 0;

    for (final kw in detectedKeywords) {
      if (_textbookKeywords.any((target) => kw.contains(target))) textbookHits++;
      if (_mangaKeywords.any((target) => kw.contains(target))) mangaHits++;
      if (_webNovelKeywords.any((target) => kw.contains(target))) webNovelHits++;
      if (_documentKeywords.any((target) => kw.contains(target))) docHits++;
    }

    // Heuristic Rule 1: Manga / Comics
    // Low selectable text density (< 120 chars/page) OR manga keyword hits
    if ((avgChars < 120 && pageCount > 15 && pageCount < 400) || (mangaHits >= 2 && avgChars < 300)) {
      return HeuristicScore(
        category: BookCategory.manga,
        confidenceScore: (mangaHits > 2) ? 0.95 : 0.85,
        textDensityRatio: avgChars / 2000.0,
        imageDensityRatio: 0.90,
        matchedStructuralKeywords: detectedKeywords.where((k) => _mangaKeywords.any((t) => k.contains(t))).toList(),
        reasoningSummary: 'Low text density (${avgChars.toStringAsFixed(0)} chars/page) and visual layout indicate Manga/Comic.',
      );
    }

    // Heuristic Rule 2: Textbook / Academic
    // Large page count (> 250), strong index/TOC/ISBN keyword matches
    if ((textbookHits >= 2 && pageCount > 100) || (textbookHits >= 3) || (pageCount > 400 && textbookHits >= 1)) {
      return HeuristicScore(
        category: BookCategory.textbook,
        confidenceScore: 0.90,
        textDensityRatio: (avgChars / 2000.0).clamp(0.0, 1.0),
        imageDensityRatio: 0.30,
        matchedStructuralKeywords: detectedKeywords.where((k) => _textbookKeywords.any((t) => k.contains(t))).toList(),
        reasoningSummary: 'Matched academic keywords ($textbookHits hits) and high page count ($pageCount pages).',
      );
    }

    // Heuristic Rule 3: Web Novel / Light Novel
    // High text density (> 1400 chars/page) with light novel/chapter keywords
    if (webNovelHits >= 2 || (avgChars > 1600 && pageCount > 80 && webNovelHits >= 1)) {
      return HeuristicScore(
        category: BookCategory.webNovel,
        confidenceScore: 0.88,
        textDensityRatio: (avgChars / 2000.0).clamp(0.0, 1.0),
        imageDensityRatio: 0.05,
        matchedStructuralKeywords: detectedKeywords.where((k) => _webNovelKeywords.any((t) => k.contains(t))).toList(),
        reasoningSummary: 'Matched web novel structure and high text density (${avgChars.toStringAsFixed(0)} chars/page).',
      );
    }

    // Heuristic Rule 4: Novel (Standard Fiction)
    // High text density (> 1200 chars/page) and moderate/long page count (> 60 pages)
    if (avgChars >= 1100 && pageCount >= 60) {
      return HeuristicScore(
        category: BookCategory.novel,
        confidenceScore: 0.80,
        textDensityRatio: (avgChars / 2000.0).clamp(0.0, 1.0),
        imageDensityRatio: 0.05,
        matchedStructuralKeywords: [],
        reasoningSummary: 'Continuous high text flow (${avgChars.toStringAsFixed(0)} chars/page) over $pageCount pages.',
      );
    }

    // Heuristic Rule 5: Short Document / Report
    if (pageCount <= 50 || docHits >= 1) {
      return HeuristicScore(
        category: BookCategory.document,
        confidenceScore: 0.75,
        textDensityRatio: (avgChars / 2000.0).clamp(0.0, 1.0),
        imageDensityRatio: 0.20,
        matchedStructuralKeywords: detectedKeywords.where((k) => _documentKeywords.any((t) => k.contains(t))).toList(),
        reasoningSummary: 'Short page count ($pageCount pages) or document structure matching.',
      );
    }

    // Default Fallback: Novel / General
    return HeuristicScore(
      category: BookCategory.novel,
      confidenceScore: 0.60,
      textDensityRatio: (avgChars / 2000.0).clamp(0.0, 1.0),
      imageDensityRatio: 0.10,
      matchedStructuralKeywords: [],
      reasoningSummary: 'Default fallback based on general PDF text layout metrics.',
    );
  }
}
