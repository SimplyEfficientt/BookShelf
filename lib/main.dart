import 'package:flutter/material.dart';
import 'package:bookshelf/core/theme/app_theme.dart';
import 'features/home_library/presentation/screens/home_screen.dart';

void main() {
  runApp(const BookShelfApp());
}

class BookShelfApp extends StatelessWidget {
  const BookShelfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookShelf',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightThemeData(context),
      darkTheme: AppTheme.darkThemeData(context),
      themeMode: ThemeMode.system,
      home: const MobilePhoneFrameWrapper(
        child: HomeScreen(initialDarkMode: true),
      ),
    );
  }
}

/// Responsive Wrapper displaying a sleek mobile phone shell on desktop screens.
class MobilePhoneFrameWrapper extends StatelessWidget {
  final Widget child;
  const MobilePhoneFrameWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 500) {
          return Scaffold(
            backgroundColor: const Color(0xFF0A0A0A),
            body: Center(
              child: Container(
                width: 400,
                height: 820,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: const Color(0xFF2A2D3A), width: 8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.8),
                      blurRadius: 30,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: child,
              ),
            ),
          );
        }
        return child;
      },
    );
  }
}
