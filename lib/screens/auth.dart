import 'package:flutter/material.dart';

import '../store.dart';
import '../theme.dart';
import '../ui.dart';
import 'sheets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  bool login = false;

  @override
  void initState() {
    super.initState();
    for (final c in [name, email, phone, password]) {
      c.addListener(() => setState(() {}));
    }
  }

  bool get valid => login
      ? email.text.contains('@') && password.text.length >= 4
      : name.text.isNotEmpty &&
            email.text.contains('@') &&
            phone.text.length >= 6 &&
            password.text.length >= 4;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: F.bg,
    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(40, 12, 40, 24),
        children: [
          Row(
            children: [
              const BackBubble(),
              const Spacer(),
              GestureDetector(
                onTap: () => setState(() => login = !login),
                child: Text(login ? 'Sign Up' : 'Log In', style: F.button3),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Text(login ? 'Log In' : 'Sign Up', style: F.h1),
          const SizedBox(height: 28),
          if (!login) ...[
            FieldBox(
              icon: Icons.person_outline_rounded,
              hint: 'Name',
              controller: name,
            ),
            const SizedBox(height: 14),
          ],
          FieldBox(
            icon: Icons.mail_outline_rounded,
            hint: 'Email',
            controller: email,
            keyboard: TextInputType.emailAddress,
          ),
          const SizedBox(height: 14),
          if (!login) ...[
            FieldBox(
              icon: Icons.phone_outlined,
              hint: 'Phone',
              controller: phone,
              keyboard: TextInputType.phone,
            ),
            const SizedBox(height: 14),
          ],
          FieldBox(
            icon: Icons.lock_outline_rounded,
            hint: 'Password',
            controller: password,
            obscure: true,
          ),
          const SizedBox(height: 28),
          PrimaryButton(
            login ? 'Log In' : 'Sign Up',
            enabled: valid,
            onTap: () {
              FoodyStore.of(context).signedUp = true;
              push(context, const AddAddressScreen());
            },
          ),
          const SizedBox(height: 20),
          Text.rich(
            TextSpan(
              style: F.body2,
              children: [
                const TextSpan(text: 'By clicking Sign up, you agree to your '),
                TextSpan(text: 'Terms and Conditions', style: F.button4),
                const TextSpan(text: ' and '),
                TextSpan(text: 'Privacy Statement', style: F.button4),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});
  @override
  State<AddAddressScreen> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddressScreen> {
  final query = TextEditingController();

  @override
  void initState() {
    super.initState();
    query.addListener(() => setState(() {}));
  }

  static const suggestions = [
    ('New York Elk Street', 'NY, USA'),
    ('New York Elk Prospect Park Southwest', 'Brooklyn, NY'),
    ('New York Elk Division Place', 'Brooklyn, NY'),
  ];

  @override
  Widget build(BuildContext context) {
    final matches = suggestions
        .where((s) => s.$1.toLowerCase().contains(query.text.toLowerCase()))
        .toList();
    return Scaffold(
      backgroundColor: F.bg,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(40, 12, 40, 24),
          children: [
            const Align(alignment: Alignment.centerLeft, child: BackBubble()),
            const SizedBox(height: 28),
            Text('Add Address', style: F.h1),
            const SizedBox(height: 24),
            FieldBox(
              icon: Icons.location_on_outlined,
              hint: 'Enter your address',
              controller: query,
              autofocus: true,
            ),
            const SizedBox(height: 20),
            for (final s in matches)
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  FoodyStore.of(context).address = s.$1;
                  push(context, const AddAddressMapScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Icon(Icons.place_outlined, color: F.grayLight, size: 22),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(s.$1, style: F.h4),
                            const SizedBox(height: 2),
                            Text(s.$2, style: F.body2),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class AddAddressMapScreen extends StatelessWidget {
  const AddAddressMapScreen({super.key});
  @override
  Widget build(BuildContext context) {
    FoodyStore.of(context);
    return Scaffold(
      backgroundColor: F.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 12, 40, 24),
          child: Column(
            children: [
              Row(
                children: [
                  const BackBubble(),
                  Expanded(
                    child: Center(child: Text('Add Address', style: F.h2)),
                  ),
                  const SizedBox(width: 45),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset('assets/map_address.png', fit: BoxFit.cover),
                      Center(
                        child: Image.asset(
                          'assets/logo.png',
                          width: 44,
                          height: 57,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                'Sign Up',
                onTap: () => push(context, const TrialScreen()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TrialScreen extends StatelessWidget {
  const TrialScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final store = FoodyStore.of(context);
    return Scaffold(
      backgroundColor: F.bg,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ShaderMask(
            shaderCallback: (rect) => const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.black, Colors.transparent],
              stops: [0, 0.65, 1],
            ).createShader(rect),
            blendMode: BlendMode.dstIn,
            child: Image.asset(
              'assets/try_photo.png',
              height: 192,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 8, 40, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    style: F.h1,
                    children: [
                      const TextSpan(text: 'Try '),
                      TextSpan(
                        text: 'Foody',
                        style: F.h1.copyWith(color: F.coral),
                      ),
                      const TextSpan(text: ' for\n30 days'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                for (final b in [
                  'Save 4-5\$ per order',
                  'Free delivery',
                  'Free 30 days trial, \$5.99 monthly after',
                ])
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle_rounded,
                          color: F.coral,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            b,
                            style: F.h4.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 16),
                PrimaryButton(
                  'Continue',
                  onTap: () async {
                    store.trialActive = true;
                    await foodySheet(context, const PreferredPaymentSheet());
                    if (context.mounted) push(context, const FavoritesScreen());
                  },
                ),
                const SizedBox(height: 16),
                Center(
                  child: GestureDetector(
                    onTap: () => push(context, const FavoritesScreen()),
                    child: Text('Skip', style: F.button3),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'You agree to a recurring monthly charge (currently \$5.99) until you cancel. Cancel in app or online prior to avoid feature charges,',
                  style: F.small2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final store = FoodyStore.of(context);
    return Scaffold(
      backgroundColor: F.petrol,
      body: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
              child: Container(
                color: F.bg,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Stack(
                      children: [
                        ShaderMask(
                          shaderCallback: (rect) => const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black,
                              Colors.black,
                              Colors.transparent,
                            ],
                            stops: [0, 0.6, 1],
                          ).createShader(rect),
                          blendMode: BlendMode.dstIn,
                          child: Image.asset(
                            'assets/fav_header.png',
                            height: 178,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.paddingOf(context).top + 12,
                          left: 20,
                          child: const BackBubble(),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 24),
                      child: Column(
                        children: [
                          Text(
                            'Your favorite \nIce Cream brands',
                            style: F.h1,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 28),
                          GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            mainAxisSpacing: 28,
                            crossAxisSpacing: 25,
                            childAspectRatio: 135 / 190,
                            children: [
                              for (final p in favorites)
                                ProductCard(
                                  p,
                                  onAdd: () {
                                    store.toggleLike(p.id);
                                    toast(
                                      context,
                                      store.liked.contains(p.id)
                                          ? '${p.name} added to favorites'
                                          : '${p.name} removed',
                                    );
                                  },
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          BottomNav(
            index: 0,
            onTap: (i) {
              store.setTab(i);
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/shell', (_) => false);
            },
          ),
        ],
      ),
    );
  }
}
