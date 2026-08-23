import 'package:flutter/material.dart';
import 'package:bookshelf/core/theme/app_theme.dart';
import 'package:bookshelf/features/pdf_classifier/domain/entities/book_category.dart';
import '../../domain/entities/book_item.dart';
import '../widgets/app_header_widget.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/quick_actions_widget.dart';
import '../widgets/shelves_row_widget.dart';
import '../widgets/recent_bento_grid_widget.dart';
import '../widgets/bottom_nav_bar_widget.dart';

/// Bookshelf Home Screen v2 implementing Light & Dark mode designs
class HomeScreen extends StatefulWidget {
  final bool initialDarkMode;
  const HomeScreen({super.key, this.initialDarkMode = true});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool _isDarkMode;
  int _selectedNavIndex = 0;
  String _searchQuery = '';

  // Shelves Dataset matching v2 mockup
  final List<ShelfItemData> _shelves = const [
    ShelfItemData(title: 'Work', count: 14),
    ShelfItemData(title: 'Personal', count: 9),
    ShelfItemData(title: 'Receipts', count: 22),
    ShelfItemData(title: 'Signed', count: 6),
    ShelfItemData(title: 'Shared', count: 11),
  ];

  // Recent Documents Dataset matching v2 mockup
  late List<BookItem> _recentBooks;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.initialDarkMode;

    _recentBooks = [
      BookItem(
        id: '1',
        filePath: '/storage/docs/lease_agreement.pdf',
        title: 'Lease Agreement',
        authors: ['Legal Dept'],
        category: BookCategory.document,
        totalPages: 9,
        fileSizeBytes: 1153433, // 1.1 MB
        lastReadTimestamp: DateTime.now(),
      ),
      BookItem(
        id: '2',
        filePath: '/storage/finance/tax_return_2025.pdf',
        title: 'Tax Return 2025',
        authors: ['IRS / Finance'],
        category: BookCategory.document,
        totalPages: 22,
        fileSizeBytes: 3984588, // 3.8 MB
        lastReadTimestamp: DateTime.now().subtract(const Duration(hours: 3)),
      ),
      BookItem(
        id: '3',
        filePath: '/storage/personal/resume_final.pdf',
        title: 'Resume — Final',
        authors: ['User'],
        category: BookCategory.document,
        totalPages: 2,
        fileSizeBytes: 245760, // 240 KB
        lastReadTimestamp: DateTime.now().subtract(const Duration(days: 1)),
      ),
      BookItem(
        id: '4',
        filePath: '/storage/academic/db_systems_notes.pdf',
        title: 'DB Systems Notes',
        authors: ['CS Dept'],
        category: BookCategory.textbook,
        totalPages: 31,
        fileSizeBytes: 4613734, // 4.4 MB
        lastReadTimestamp: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  List<BookItem> get _filteredBooks {
    if (_searchQuery.trim().isEmpty) return _recentBooks;
    final query = _searchQuery.toLowerCase();
    return _recentBooks.where((book) => book.title.toLowerCase().contains(query)).toList();
  }

  void _showActionSnackBar(String actionName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$actionName feature triggered'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldBg = _isDarkMode ? AppTheme.darkCanvas : AppTheme.lightCanvas;

    return Theme(
      data: _isDarkMode ? AppTheme.darkThemeData(context) : AppTheme.lightThemeData(context),
      child: Scaffold(
        backgroundColor: scaffoldBg,
        body: SafeArea(
          child: Column(
            children: [
              // Main Scrollable Screen Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Top Header
                      AppHeaderWidget(
                        isDarkMode: _isDarkMode,
                        onToggleTheme: _toggleTheme,
                        onProfileTap: () => _showActionSnackBar('User Profile'),
                      ),

                      const SizedBox(height: 18),

                      // 2. Search Input Bar
                      SearchBarWidget(
                        isDarkMode: _isDarkMode,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                      ),

                      const SizedBox(height: 18),

                      // 3. Quick Action Grid (Scan, Import, Merge, New)
                      QuickActionsWidget(
                        isDarkMode: _isDarkMode,
                        onScanTap: () => _showActionSnackBar('Camera Scanner'),
                        onImportTap: () => _showActionSnackBar('File Import Picker'),
                        onMergeTap: () => _showActionSnackBar('PDF Merge Utility'),
                        onNewTap: () => _showActionSnackBar('Create New Shelf'),
                      ),

                      const SizedBox(height: 22),

                      // 4. YOUR SHELVES Vertical Spines Row
                      ShelvesRowWidget(
                        isDarkMode: _isDarkMode,
                        shelves: _shelves,
                        onShelfTap: (shelf) => _showActionSnackBar('Shelf: ${shelf.title}'),
                      ),

                      const SizedBox(height: 22),

                      // 5. RECENT Bento Grid
                      RecentBentoGridWidget(
                        isDarkMode: _isDarkMode,
                        books: _filteredBooks,
                        totalFilesCount: 18,
                        onBookTap: (book) => _showActionSnackBar('Open PDF: ${book.title}'),
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              // 6. Floating Bottom Navigation Bar
              BottomNavBarWidget(
                isDarkMode: _isDarkMode,
                selectedIndex: _selectedNavIndex,
                onTabSelected: (index) {
                  setState(() {
                    _selectedNavIndex = index;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
