import 'package:flutter/material.dart';

import 'screens/discover.dart';
import 'screens/onboarding.dart';
import 'screens/orders.dart';
import 'store.dart';
import 'theme.dart';
import 'ui.dart';

void main() {
  runApp(FoodyScope(store: FoodyStore(), child: const FoodyApp()));
}

class FoodyApp extends StatelessWidget {
  const FoodyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final store = FoodyStore.of(context);
    F.dark = store.darkMode;
    return MaterialApp(
      title: 'Foody',
      debugShowCheckedModeBanner: false,
      theme: foodyTheme(),
      themeMode: store.darkMode ? ThemeMode.dark : ThemeMode.light,
      home: const SplashScreen(),
      routes: {'/shell': (_) => const MainShell()},
    );
  }
}

class MainShell extends StatelessWidget {
  const MainShell({super.key});
  @override
  Widget build(BuildContext context) {
    final store = FoodyStore.of(context);
    return NavScaffold(
      index: store.tab,
      child: IndexedStack(
        index: store.tab,
        children: const [
          HomeScreen(),
          PickupScreen(),
          OffersScreen(),
          SearchScreen(),
          OrdersScreen(),
        ],
      ),
    );
  }
}
