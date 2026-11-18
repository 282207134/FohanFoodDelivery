import 'package:flutter/material.dart';

import '../main.dart';
import '../store.dart';
import '../theme.dart';
import 'auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start after the first frame so slow cold starts still show the splash.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 1400), () {
        if (!mounted) return;
        final store = FoodyStore.of(context);
        final next = store.onboarded
            ? (store.signedUp ? const MainShell() : const SignUpScreen())
            : const OnboardingScreen();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => next,
            settings: const RouteSettings(name: '/shell'),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    FoodyStore.of(context);
    return Scaffold(
      backgroundColor: F.bg,
      body: Center(
        child: Image.asset('assets/logo.png', width: 83, height: 107),
      ),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingState();
}

class _OnboardingState extends State<OnboardingScreen> {
  final controller = PageController();
  int page = 0;

  static const pages = [
    (
      'assets/onb1.png',
      'All Your Favorites',
      'Order from the best local restaurants with easy, on-demand delivery.',
    ),
    (
      'assets/onb2.png',
      'Free Delivery',
      'For new customers, Foody will offer you free delivery for 30 days',
    ),
    (
      'assets/onb3.png',
      'Here for You',
      'For new customers, Foody will offer you free delivery for 30 days',
    ),
  ];

  void next() {
    if (page == 2) {
      finish();
    } else {
      controller.nextPage(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void finish() {
    FoodyStore.of(context).onboarded = true;
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    FoodyStore.of(context);
    return Scaffold(
      backgroundColor: F.bg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
              child: Row(
                children: [
                  const Spacer(),
                  Image.asset('assets/logo.png', width: 44, height: 57),
                  const Spacer(),
                  GestureDetector(
                    onTap: finish,
                    child: Text('Skip', style: F.button3),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: pages.length,
                onPageChanged: (i) => setState(() => page = i),
                itemBuilder: (_, i) => GestureDetector(
                  onTap: next,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        const Spacer(),
                        Image.asset(
                          pages[i].$1,
                          height: 300,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 36),
                        Text(
                          pages[i].$2,
                          style: F.h1,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          pages[i].$3,
                          style: F.body1,
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < 3; i++)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: i == page ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: i == page ? F.coral : Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: F.coral, width: 1.4),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
