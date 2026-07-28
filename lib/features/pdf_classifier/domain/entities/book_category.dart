/// Standardized book categories for BookShelf local classification.
enum BookCategory {
  manga(
    displayName: 'Manga / Comic',
    description: 'Graphic novels, comics, and manga with high visual density.',
    defaultFolder: 'Manga',
  ),
  webNovel(
    displayName: 'Web Novel',
    description: 'Serialized novels, light novels, and web fiction.',
    defaultFolder: 'WebNovels',
  ),
  novel(
    displayName: 'Novel',
    description: 'Literature, fiction, and long-form narrative books.',
    defaultFolder: 'Novels',
  ),
  textbook(
    displayName: 'Textbook / Academic',
    description: 'Educational books, courseware, and reference manuals with index/TOC.',
    defaultFolder: 'Textbooks',
  ),
  document(
    displayName: 'General Document',
    description: 'Short documents, reports, whitepapers, and guides.',
    defaultFolder: 'Documents',
  );

  final String displayName;
  final String description;
  final String defaultFolder;

  const BookCategory({
    required this.displayName,
    required this.description,
    required this.defaultFolder,
  });
}
