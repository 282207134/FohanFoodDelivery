import 'package:flutter/material.dart';

import '../store.dart';
import '../theme.dart';
import '../ui.dart';
import 'auth.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final app = FoodyStore.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: [
        AvatarTitle(
          'Orders',
          onAvatar: () => push(context, const AccountScreen()),
        ),
        const SizedBox(height: 24),
        for (var i = 0; i < app.orders.length; i++) ...[
          if (i > 0) const ThinLine(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    app.orders[i].photo,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(app.orders[i].title, style: F.h3),
                      const SizedBox(height: 4),
                      Text(
                        app.orders[i].sub,
                        style: F.body2.copyWith(color: F.ink),
                      ),
                      const SizedBox(height: 4),
                      Text('5,100 + ratings', style: F.body2),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        app.reorder(app.orders[i]);
                        toast(context, '${app.orders[i].title} added to cart');
                      },
                      child: Text('Reorder', style: F.button4),
                    ),
                    const SizedBox(height: 8),
                    Text(usd(app.orders[i].price), style: F.h4),
                  ],
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final app = FoodyStore.of(context);
    return Scaffold(
      backgroundColor: F.bg,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(40, 12, 40, 24),
          children: [
            const Align(alignment: Alignment.centerLeft, child: BackBubble()),
            const SizedBox(height: 20),
            AvatarTitle('Account'),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () =>
                  toast(context, 'Referral link copied: foody.app/refer/alex'),
              child: Container(
                height: 110,
                padding: const EdgeInsets.all(20),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFFF9A76), F.coral],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -24,
                      top: -30,
                      child: Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.14),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Referals',
                          style: F.h3.copyWith(color: F.onAccent),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Refer to Friends and get \nUSD\$10.00',
                          style: F.body2.copyWith(color: F.onAccent),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),
            SectionHead('Notifications'),
            const SizedBox(height: 8),
            for (final key in app.notifications.keys)
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  app.toggleNotification(key);
                  toast(
                    context,
                    '$key ${app.notifications[key]! ? 'on' : 'off'}',
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    key,
                    style: F.h4.copyWith(
                      color: app.notifications[key]! ? F.ink : F.grayLight,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            SectionHead('More'),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Dark Mode',
                      style: F.h4.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Switch(
                    value: app.darkMode,
                    activeThumbColor: F.teal,
                    onChanged: (_) => app.toggleDark(),
                  ),
                ],
              ),
            ),
            for (final row in ['Become a Partner Restaurant', 'Legal'])
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => toast(context, row),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    row,
                    style: F.h4.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            const SizedBox(height: 28),
            Center(
              child: GestureDetector(
                onTap: () {
                  app.reset();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const SignUpScreen()),
                    (_) => false,
                  );
                },
                child: Text('Log Out', style: F.button3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
