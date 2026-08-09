import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notino/core/constants/colors.dart';
import 'package:notino/core/constants/dimens.dart';
import 'package:notino/features/notes/ui/add_notes/view/add_note_page.dart';
import 'package:notino/features/dashboard/ui/views/dashboard_screen.dart';
import 'package:notino/features/notes/ui/notes_page.dart';
import 'package:notino/features/page_handling/providers/navigation_provider.dart';
import 'package:notino/features/page_handling/ui/widgets/app_bar.dart';
import 'package:notino/features/page_handling/ui/widgets/bottom_navbar.dart';

class PageHandler extends ConsumerWidget {
  const PageHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final size = MediaQuery.of(context).size;

    final List<Widget> pages = [
      DashboardPage(),

      AddNewNotePage(),

      NotesPage(),
    ];

    final pageIndex = ref.watch(navigationProvider);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: EdgeInsets.all(AppDimens.paddingLarge),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primary,
                AppColors.backgroundScaffoldColor,
              ],
            ),
          ),
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              
              // Content
              Positioned(
                top: size.height * .12,
                left: 0,
                right: 0,
                bottom: size.height * .12,
                child: IndexedStack(
                  index: pageIndex,
                  children: pages,
                ),
              ),
        
              // App Bar
              Positioned(
                top: size.height * .05,
                right: 0,
                left: 0,
                child: MainAppBar(),
              ),
        
        
              // Bottom Navigation
              Positioned(
                bottom: size.height * .02,
                right: 0,
                left: 0,
                child: BottomNavBar(
                  currentIndex: pageIndex,
                  onTap: (index) {
                    ref.read(navigationProvider.notifier).state = index;
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}