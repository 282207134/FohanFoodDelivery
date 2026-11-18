import 'package:flutter/material.dart';

import '../store.dart';
import '../theme.dart';
import '../ui.dart';
import 'cart.dart';

class PreferredPaymentSheet extends StatelessWidget {
  const PreferredPaymentSheet({super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(40, 0, 40, 32),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SheetHandle(),
        const SizedBox(height: 12),
        Text('Preferred\nPayment Method', style: F.h1),
        const SizedBox(height: 12),
        Text(
          'You must add a payment method to continue your\nFoody description.',
          style: F.body2,
        ),
        const SizedBox(height: 24),
        Stack(
          clipBehavior: Clip.none,
          children: [
            GestureDetector(
              onTap: () => push(context, const AddCardScreen()),
              child: Container(
                height: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF39C6BE), F.petrol],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -20,
                      top: -30,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Foody',
                            style: F.h4.copyWith(color: Colors.white),
                          ),
                          const Spacer(),
                          Text(
                            '••••  ••••  ••••  8594',
                            style: F.h4.copyWith(
                              color: Colors.white,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: -8,
              bottom: -12,
              child: GestureDetector(
                onTap: () => push(context, const AddCardScreen()),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: F.surface,
                    shape: BoxShape.circle,
                    boxShadow: F.dark
                        ? null
                        : [
                            const BoxShadow(
                              color: Color(0x14000000),
                              blurRadius: 8,
                            ),
                          ],
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    color: F.coral,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Center(
          child: GestureDetector(
            onTap: () {
              FoodyStore.of(context).trialActive = false;
              pop(context);
            },
            child: Text('End Subscription', style: F.button3),
          ),
        ),
      ],
    ),
  );
}

class RatingSheet extends StatefulWidget {
  const RatingSheet({super.key});
  @override
  State<RatingSheet> createState() => _RatingSheetState();
}

class _RatingSheetState extends State<RatingSheet> {
  late double value = FoodyStore.of(context).ratingMin;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(40, 0, 40, 32),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SheetHandle(),
        const SizedBox(height: 8),
        Text('RATINGS', style: F.caption1),
        const SizedBox(height: 6),
        Text(
          'Over ${value.toStringAsFixed(value == value.roundToDouble() ? 0 : 1)}',
          style: F.h1,
        ),
        const SizedBox(height: 20),
        HaloSlider(value: value, onChanged: (v) => setState(() => value = v)),
        const SizedBox(height: 28),
        PrimaryButton(
          'View Results',
          onTap: () {
            FoodyStore.of(context).ratingMin = value;
            pop(context);
          },
        ),
      ],
    ),
  );
}

class PriceSheet extends StatefulWidget {
  const PriceSheet({super.key});
  @override
  State<PriceSheet> createState() => _PriceSheetState();
}

class _PriceSheetState extends State<PriceSheet> {
  late int level = FoodyStore.of(context).priceLevel;
  static const labels = [
    'Cheap',
    'Cheap - Medium',
    'Medium - Expensive',
    'Expensive',
  ];
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(40, 0, 40, 32),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SheetHandle(),
        const SizedBox(height: 8),
        Text('MANU PRICE', style: F.caption1),
        const SizedBox(height: 6),
        Text(labels[level - 1], style: F.h1),
        const SizedBox(height: 24),
        Row(
          children: [
            for (var i = 1; i <= 4; i++)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GrayChip(
                  '\$' * i,
                  active: i == level,
                  onTap: () => setState(() => level = i),
                ),
              ),
          ],
        ),
        const SizedBox(height: 28),
        PrimaryButton(
          'View Results',
          onTap: () {
            FoodyStore.of(context).priceLevel = level;
            pop(context);
          },
        ),
      ],
    ),
  );
}

class PaymentSelectSheet extends StatelessWidget {
  const PaymentSelectSheet({super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(40, 0, 40, 32),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SheetHandle(),
        const SizedBox(height: 8),
        Text('SELECT', style: F.caption1),
        const SizedBox(height: 6),
        Text('Payment Method', style: F.h1),
        const SizedBox(height: 28),
        PrimaryButton(
          'PayPal',
          color: F.blue,
          onTap: () {
            FoodyStore.of(context).payment = 'PayPal';
            pop(context);
          },
        ),
        const SizedBox(height: 14),
        PrimaryButton(
          'Credit or Debit Card',
          color: F.coral,
          onTap: () => push(context, const AddCardScreen()),
        ),
      ],
    ),
  );
}

class TipSheet extends StatefulWidget {
  const TipSheet({super.key});
  @override
  State<TipSheet> createState() => _TipSheetState();
}

class _TipSheetState extends State<TipSheet> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(40, 0, 40, 32),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SheetHandle(),
        const SizedBox(height: 8),
        Text('TIP FOR DRIVER', style: F.caption1),
        const SizedBox(height: 6),
        Text('Enter Amount', style: F.h1),
        const SizedBox(height: 20),
        TextField(
          controller: controller,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          style: F.h1,
          decoration: InputDecoration(
            prefixText: 'US\$ ',
            prefixStyle: F.h1.copyWith(color: F.grayLight),
            filled: true,
            fillColor: F.field,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 24),
        PrimaryButton(
          'View Results',
          onTap: () {
            final v = double.tryParse(controller.text);
            if (v != null && v >= 0) FoodyStore.of(context).tip = v;
            pop(context);
          },
        ),
        const SizedBox(height: 16),
        Center(
          child: GestureDetector(
            onTap: () => pop(context),
            child: Text('Cancel', style: F.button3),
          ),
        ),
      ],
    ),
  );
}

class DropOffSheet extends StatelessWidget {
  const DropOffSheet({super.key});
  @override
  Widget build(BuildContext context) {
    final store = FoodyStore.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SheetHandle(),
          const SizedBox(height: 8),
          Text('DROP-OFF', style: F.caption1),
          const SizedBox(height: 6),
          Text('Drop-Off Option', style: F.h1),
          const SizedBox(height: 16),
          for (final o in [
            'Leave it at my door',
            'Meet at the door',
            'Meet outside',
          ])
            CheckRow(
              label: o,
              checked: store.dropOff == o,
              onTap: () {
                store.dropOff = o;
                store.notify();
                pop(context);
              },
            ),
        ],
      ),
    );
  }
}

class ScheduleSheet extends StatefulWidget {
  const ScheduleSheet({super.key});
  @override
  State<ScheduleSheet> createState() => _ScheduleSheetState();
}

class _ScheduleSheetState extends State<ScheduleSheet> {
  double minutes = 45;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(40, 0, 40, 32),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SheetHandle(),
        const SizedBox(height: 8),
        Text('DELIVERY TIME', style: F.caption1),
        const SizedBox(height: 6),
        Text('In ${minutes.round()} min', style: F.h1),
        const SizedBox(height: 20),
        HaloSlider(
          value: minutes,
          min: 15,
          max: 90,
          divisions: 5,
          color: F.teal,
          labels: const ['15', '30', '45', '60', '75', '90'],
          onChanged: (v) => setState(() => minutes = v),
        ),
        const SizedBox(height: 28),
        PrimaryButton(
          'View Results',
          onTap: () {
            FoodyStore.of(context).deliveryTime = 'In ${minutes.round()} min';
            pop(context);
          },
        ),
      ],
    ),
  );
}

class OfferTypeSheet extends StatelessWidget {
  const OfferTypeSheet({super.key});
  @override
  Widget build(BuildContext context) {
    final store = FoodyStore.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SheetHandle(),
          const SizedBox(height: 8),
          Text('OFFER TYPE', style: F.caption1),
          const SizedBox(height: 6),
          Text('Offer Type', style: F.h1),
          const SizedBox(height: 16),
          for (final o in ['All', 'Free delivery', 'Discount'])
            CheckRow(
              label: o,
              checked: store.offerType == o,
              onTap: () {
                store.offerType = o;
                store.notify();
                pop(context);
              },
            ),
        ],
      ),
    );
  }
}
