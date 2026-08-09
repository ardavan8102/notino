import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notino/features/notes/ui/add_notes/view/add_note_page.dart';
import 'package:notino/features/dashboard/ui/views/dashboard_screen.dart';
import 'package:notino/features/notes/ui/notes_page.dart';
import 'package:notino/features/page_handling/ui/views/page_handler.dart';
import 'package:notino/features/settings/ui/settings_page.dart';

class AppRouter {

  final routerProvider = Provider<GoRouter>((ref) {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const PageHandler(),
        ),

        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const DashboardPage(),
        ),

        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsPage(),
        ),

        GoRoute(
          path: '/add_note',
          builder: (context, state) => const AddNewNotePage(),
        ),

        GoRoute(
          path: '/notes',
          builder: (context, state) => const NotesPage(),
        ),
      ],
    );
  });

}