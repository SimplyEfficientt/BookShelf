import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bookshelf/features/pdf_classifier/domain/entities/book_category.dart';
import '../../domain/entities/book_item.dart';
import '../widgets/book_cover_card.dart';

/// Netflix-Style Home Screen displaying Recently Read Hero Carousel and Categorized Shelves.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Sample local library dataset demonstrating the Netflix-style experience
  final List<BookItem> _recentlyReadBooks = [
    BookItem(
      id: '1',
      filePath: '/storage/manga/solo_leveling_v1.pdf',
      title: 'Solo Leveling: Volume 1',
      authors: ['Chugong'],
      category: BookCategory.manga,
      coverUrl: 'https://m.media-amazon.com/images/I/815-L2+H8qL._AC_UF1000,1000_QL80_.jpg',
      currentPage: 142,
      totalPages: 350,
      lastReadTimestamp: DateTime.now(),
    ),
    BookItem(
      id: '2',
      filePath: '/storage/novels/omniscient_reader.pdf',
      title: 'Omniscient Reader\'s Viewpoint',
      authors: ['singNsong'],
      category: BookCategory.webNovel,
      coverUrl: 'https://m.media-amazon.com/images/I/81q2MmsUedL._AC_UF1000,1000_QL80_.jpg',
      currentPage: 210,
      totalPages: 550,
      lastReadTimestamp: DateTime.now().subtract(const Duration(hours: 4)),
    ),
    BookItem(
      id: '3',
      filePath: '/storage/textbooks/clean_code.pdf',
      title: 'Clean Code: Handbook of Agile Software',
      authors: ['Robert C. Martin'],
      category: BookCategory.textbook,
      coverUrl: 'https://m.media-amazon.com/images/I/51E2055zgUL._AC_UF1000,1000_QL80_.jpg',
      currentPage: 88,
      totalPages: 464,
      lastReadTimestamp: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414), // Netflix dark background
      appBar: AppBar(
        backgroundColor: const Color(0xFF141414),
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.auto_stories, color: Color(0xFFE50914), size: 28), // Netflix Red icon
            const SizedBox(width: 8),
            Text(
              'BOOKSHELF',
              style: GoogleFonts.bebasNeue(
                fontSize: 26,
                letterSpacing: 1.8,
                color: const Color(0xFFE50914),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.folder_open, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Hero Banner Section (Featured / Recently Read)
            _buildTopHeroBanner(_recentlyReadBooks.first),

            const SizedBox(height: 24),

            // Recently Read Section
            _buildCategoryRow('Continue Reading', _recentlyReadBooks),

            // Manga & Comics Section
            _buildCategoryRow(
              'Manga & Graphic Novels',
              _recentlyReadBooks.where((b) => b.category == BookCategory.manga).toList(),
            ),

            // Web Novels & Light Novels Section
            _buildCategoryRow(
              'Web Novels & Light Novels',
              _recentlyReadBooks.where((b) => b.category == BookCategory.webNovel).toList(),
            ),

            // Academic & Textbooks Section
            _buildCategoryRow(
              'Textbooks & Reference',
              _recentlyReadBooks.where((b) => b.category == BookCategory.textbook).toList(),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTopHeroBanner(BookItem heroBook) {
    return Container(
      height: 260,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: heroBook.coverUrl != null
            ? DecorationImage(
                image: NetworkImage(heroBook.coverUrl!),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.55),
                  BlendMode.darken,
                ),
              )
            : null,
        color: const Color(0xFF221133),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [Colors.transparent, Colors.black90],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFE50914),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'RECENTLY READ',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              heroBook.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              heroBook.progressFormatted,
              style: GoogleFonts.inter(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: () {},
              icon: const Icon(Icons.play_arrow, color: Colors.black),
              label: Text(
                'Resume Reading',
                style: GoogleFonts.inter(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryRow(String title, List<BookItem> books) {
    if (books.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 195,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return BookCoverCard(
                  book: book,
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
