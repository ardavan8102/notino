import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notino/app/db/hive_database.dart';
import 'package:notino/app/db/seed.dart';
import 'package:notino/app/routes/router_provider.dart';
import 'package:notino/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveDatabase.initialize();

  await HiveDatabase.openBoxes();

  await DatabaseSeeder.seedTags();
  
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(
    const ProviderScope(
      child: MyApp(),
    )
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final router = ref.watch(AppRouter().routerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Notino',
      locale: const Locale('fa', 'IR'),
      supportedLocales: const [
        Locale('fa', 'IR')
      ],
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}