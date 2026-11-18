import 'package:flutter/material.dart';

import '../store.dart';
import '../theme.dart';
import '../ui.dart';

class EnterPromoScreen extends StatefulWidget {
  const EnterPromoScreen({super.key});
  @override
  State<EnterPromoScreen> createState() => _EnterPromoState();
}

class _EnterPromoState extends State<EnterPromoScreen> {
  final code = TextEditingController();

  @override
  void initState() {
    super.initState();
    code.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: F.bg,
    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(40, 12, 40, 24),
        children: [
          const Align(alignment: Alignment.centerLeft, child: BackBubble()),
          const SizedBox(height: 28),
          Text('Promotions', style: F.h1),
          const SizedBox(height: 24),
          Text('Have a promo code?', style: F.h4),
          const SizedBox(height: 16),
          Row(
            children: [
              Text('Have a Gift Card?', style: F.h4),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => push(context, const PromotionsScreen()),
                child: Text('Redeem now', style: F.button4),
              ),
            ],
          ),
          const SizedBox(height: 24),
          FieldBox(
            icon: Icons.local_offer_outlined,
            hint: 'Enter Promo Code',
            controller: code,
          ),
          const SizedBox(height: 28),
          PrimaryButton(
            'Submit',
            enabled: code.text.trim().isNotEmpty,
            onTap: () {
              FoodyStore.of(context).applyPromo(code.text.trim().toUpperCase());
              pop(context);
              toast(context, 'Promo code applied');
            },
          ),
        ],
      ),
    ),
  );
}

class PromotionsScreen extends StatefulWidget {
  const PromotionsScreen({super.key});
  @override
  State<PromotionsScreen> createState() => _PromotionsState();
}

class _PromotionsState extends State<PromotionsScreen> {
  final pin = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: F.bg,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(40, 12, 40, 24),
          children: [
            const Align(alignment: Alignment.centerLeft, child: BackBubble()),
            const SizedBox(height: 28),
            Text('Promotions', style: F.h1),
            const SizedBox(height: 12),
            Text(
              'Connect your favorite people with their favorites. Customize and buy gift card,',
              style: F.body2,
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 250,
              child: ClipRect(
                child: OverflowBox(
                  alignment: Alignment.topLeft,
                  maxWidth: double.infinity,
                  maxHeight: double.infinity,
                  child: Image.asset(
                    'assets/promo_illustration.png',
                    width: 660.5,
                    height: 576,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Have a Gift Card?', style: F.h2),
            const SizedBox(height: 8),
            Text('Redeem it with your gift card PIN', style: F.body2),
            const SizedBox(height: 16),
            FieldBox(
              icon: Icons.card_giftcard_outlined,
              hint: 'Gift card PIN',
              controller: pin,
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  if (pin.text.trim().isEmpty) {
                    toast(context, 'Enter a gift card PIN');
                    return;
                  }
                  FoodyStore.of(context).giftCards.add(
                    GiftCard(color: 0xFF30B9B2, text: 'Redeemed', value: 25),
                  );
                  FoodyStore.of(context).notify();
                  toast(context, 'Gift card redeemed: US\$ 25.00');
                },
                child: Text('Redeem', style: F.button3),
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              'Buy Gift Card',
              onTap: () => push(context, const GiftCardScreen()),
            ),
          ],
        ),
      ),
    );
  }
}

class GiftCardScreen extends StatefulWidget {
  const GiftCardScreen({super.key});
  @override
  State<GiftCardScreen> createState() => _GiftCardState();
}

class _GiftCardState extends State<GiftCardScreen> {
  static const colors = [
    0xFFFF7A4F,
    0xFF30B9B2,
    0xFF004A63,
    0xFF0070BA,
    0xFF7B61FF,
    0xFFE455AE,
    0xFFFF8FB1,
    0xFFE5484D,
  ];
  int color = colors.first;
  double value = 25;
  final text = TextEditingController(text: 'Congratulations!');

  @override
  void initState() {
    super.initState();
    text.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: F.bg,
    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(40, 12, 40, 24),
        children: [
          const Align(alignment: Alignment.centerLeft, child: BackBubble()),
          const SizedBox(height: 28),
          Text('Customize\nGift Card', style: F.h1),
          const SizedBox(height: 24),
          GiftCardArt(
            color: color,
            text: text.text.isEmpty ? 'Foody' : text.text,
          ),
          const SizedBox(height: 28),
          Text('Select Color', style: F.h4),
          const SizedBox(height: 14),
          Row(
            children: [
              for (final c in colors)
                GestureDetector(
                  onTap: () => setState(() => color = c),
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: F.dark ? 46 : 26,
                    height: F.dark ? 46 : 26,
                    decoration: BoxDecoration(
                      color: F.dark ? F.field : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: Color(c),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: color == c ? Color(c) : Colors.transparent,
                            width: 2,
                          ),
                          boxShadow: color == c && !F.dark
                              ? [
                                  BoxShadow(
                                    color: Color(c).withValues(alpha: 0.35),
                                    blurRadius: 0,
                                    spreadRadius: 4,
                                  ),
                                ]
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Change text', style: F.h4),
          const SizedBox(height: 10),
          FieldBox(
            icon: Icons.edit_outlined,
            hint: 'Card message',
            controller: text,
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Value', style: F.h2),
              const SizedBox(width: 6),
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text('(USD)', style: F.body2),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final v in [25.0, 80.0, 50.0, 100.0, 200.0])
                GrayChip(
                  '\$${v.toStringAsFixed(0)}',
                  active: value == v,
                  onTap: () => setState(() => value = v),
                ),
            ],
          ),
          const SizedBox(height: 28),
          PrimaryButton(
            'Make',
            onTap: () {
              final app = FoodyStore.of(context);
              app.giftCards.add(
                GiftCard(color: color, text: text.text, value: value),
              );
              app.notify();
              pop(context);
              toast(context, 'Gift card created: ${usd(value)}');
            },
          ),
        ],
      ),
    ),
  );
}
