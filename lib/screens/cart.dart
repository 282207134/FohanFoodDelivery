import 'package:flutter/material.dart';

import '../store.dart';
import '../theme.dart';
import '../ui.dart';
import 'promo.dart';
import 'sheets.dart';
import 'store_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final app = FoodyStore.of(context);
    final storeId = app.cart.isEmpty ? 'dalah' : app.cart.first.product.storeId;
    final store = storeById(storeId);
    return Scaffold(
      backgroundColor: F.bg,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(40, 12, 40, 24),
          children: [
            Row(
              children: [
                const BackBubble(),
                Expanded(
                  child: Center(child: Text(store.name, style: F.h1)),
                ),
                const SizedBox(width: 45),
              ],
            ),
            const SizedBox(height: 20),
            ModeToggle(
              value: app.mode,
              onChanged: (m) {
                app.mode = m;
                app.notify();
              },
            ),
            const SizedBox(height: 20),
            if (app.mode == 'Pickup')
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/map_thumb.png',
                      width: 80,
                      height: 80,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      '123 Shopping Center',
                      style: F.button4.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: F.coral,
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 24),
            Text('Items:', style: F.h4),
            const SizedBox(height: 8),
            if (app.cart.isEmpty) Text('Your cart is empty', style: F.body2),
            for (final line in app.cart) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Text('${line.qty}x ', style: F.h4.copyWith(color: F.teal)),
                    Expanded(child: Text(line.product.name, style: F.h4)),
                    Text(usd(line.total), style: F.h4),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        final removed = line;
                        app.remove(line);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${removed.product.name} removed'),
                            action: SnackBarAction(
                              label: 'UNDO',
                              textColor: F.coral,
                              onPressed: () => app.add(
                                removed.product,
                                qty: removed.qty,
                                addons: removed.addons,
                              ),
                            ),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.close_rounded,
                        color: F.grayLight,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const ThinLine(),
            ],
            const SizedBox(height: 14),
            GestureDetector(
              onTap: () => push(context, StoreScreen(store)),
              child: Text('Add more Items', style: F.button3),
            ),
            const SizedBox(height: 24),
            Text('Promotions:', style: F.h4),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => push(context, const EnterPromoScreen()),
              child: Text(
                app.promo.isEmpty
                    ? 'Add Foody promo code'
                    : 'Promo ${app.promo} applied (-${usd(app.discount)})',
                style: F.button3,
              ),
            ),
            const SizedBox(height: 24),
            Text('People also like:', style: F.h4),
            const SizedBox(height: 16),
            SizedBox(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                children: [
                  for (final p in alsoLike)
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: SizedBox(
                        width: 102,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    p.photo,
                                    width: 83,
                                    height: 83,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  right: -6,
                                  bottom: -8,
                                  child: GestureDetector(
                                    onTap: () {
                                      app.add(p);
                                      toast(
                                        context,
                                        '${p.name} added to order',
                                      );
                                    },
                                    child: Container(
                                      width: 32,
                                      height: 32,
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
                                        size: 17,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              p.name,
                              style: F.body2.copyWith(
                                color: F.ink,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(p.price.toStringAsFixed(2), style: F.body2),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            AmountButton(
              'Continue',
              total: app.cartTotal - app.discount,
              onTap: () {
                if (app.cart.isEmpty) {
                  toast(context, 'Add items to your order first');
                  return;
                }
                push(context, const CheckoutScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final app = FoodyStore.of(context);
    final pickup = app.mode == 'Pickup';
    final store = storeById(
      app.cart.isEmpty ? 'dalah' : app.cart.first.product.storeId,
    );
    return Scaffold(
      backgroundColor: F.bg,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          MapHeader(
            image: pickup
                ? 'assets/map_pickup_details.png'
                : 'assets/map_delivery.png',
            title: pickup ? 'Pickup Details' : 'Delivery Details',
            child: Positioned(
              top: MediaQuery.paddingOf(context).top + 12,
              left: 40,
              child: const BackBubble(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 8, 40, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _row('Address:', pickup ? '123 Shopping Center' : app.address),
                const ThinLine(),
                if (!pickup) ...[
                  _row(
                    'Drop-Off:',
                    app.dropOff,
                    onTap: () => foodySheet(context, const DropOffSheet()),
                  ),
                  const ThinLine(),
                  _row('Phone number:', app.phone),
                  const ThinLine(),
                  const SizedBox(height: 16),
                  Text('Delivery Time:', style: F.h3),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          app.deliveryTime == 'Standard'
                              ? 'Standard'
                              : app.deliveryTime,
                          style: F.h4,
                        ),
                      ),
                      Text(
                        app.deliveryTime == 'Standard'
                            ? '35-45 min'
                            : 'Scheduled',
                        style: F.body2,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: Text('Schedule Ahead', style: F.h4)),
                      GestureDetector(
                        onTap: () => foodySheet(context, const ScheduleSheet()),
                        child: Text('Choose time', style: F.button4),
                      ),
                    ],
                  ),
                  const ThinLine(),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text('Tip', style: F.h4),
                      const Spacer(),
                      Text(
                        'US\$${app.tip.toStringAsFixed(0)} Tip',
                        style: F.h4.copyWith(color: F.teal),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      for (final v in [2.0, 3.0, 5.0])
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GrayChip(
                            '\$${v.toStringAsFixed(0)}',
                            active: app.tip == v,
                            activeColor: F.teal,
                            onTap: () {
                              app.tip = v;
                              app.notify();
                            },
                          ),
                        ),
                      GrayChip(
                        'Other',
                        active: ![2.0, 3.0, 5.0].contains(app.tip),
                        activeColor: F.teal,
                        onTap: () => foodySheet(context, const TipSheet()),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const ThinLine(),
                ] else ...[
                  const SizedBox(height: 16),
                  Text('Pickup Time:', style: F.h3),
                  const SizedBox(height: 8),
                  HaloSlider(
                    value: app.pickupMinutes.toDouble(),
                    min: 10,
                    max: 60,
                    divisions: 5,
                    color: F.teal,
                    labels: const ['10', '20', '30', '40', '50', '60'],
                    onChanged: (v) {
                      app.pickupMinutes = v.round();
                      app.notify();
                    },
                  ),
                  const SizedBox(height: 16),
                  const ThinLine(),
                ],
                const SizedBox(height: 16),
                _row(
                  'Payment:',
                  app.payment,
                  onTap: () => foodySheet(context, const PaymentSelectSheet()),
                ),
                if (pickup) ...[
                  const SizedBox(height: 28),
                  Center(child: Text('This is a Pickup order', style: F.h4)),
                  const SizedBox(height: 6),
                  Center(
                    child: Text(
                      'You\'ll need to go to ${store.name} to pick up this order',
                      style: F.body2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                const SizedBox(height: 28),
                AmountButton(
                  'Place Order',
                  total: app.cartTotal - app.discount,
                  onTap: () {
                    app.placeOrder();
                    goTab(context, 4);
                    toast(context, 'Order placed successfully');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value, {VoidCallback? onTap}) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: F.h3),
              const SizedBox(height: 6),
              Text(value, style: F.h4.copyWith(color: F.teal)),
            ],
          ),
        ),
      );
}

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});
  @override
  State<AddCardScreen> createState() => _AddCardState();
}

class _AddCardState extends State<AddCardScreen> {
  final number = TextEditingController(text: '1234   5678   9123   4567');
  final country = TextEditingController(text: 'United States');
  bool isDefault = true;

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
              Expanded(
                child: Center(child: Text('Add Card', style: F.h1)),
              ),
              const SizedBox(width: 45),
            ],
          ),
          const SizedBox(height: 28),
          FieldBox(
            icon: Icons.credit_card_outlined,
            hint: 'Card number',
            controller: number,
            keyboard: TextInputType.number,
          ),
          const SizedBox(height: 14),
          FieldBox(
            icon: Icons.public_rounded,
            hint: 'Country',
            controller: country,
          ),
          const SizedBox(height: 20),
          CheckRow(
            label: 'Default for Foody Subscription',
            checked: isDefault,
            onTap: () => setState(() => isDefault = !isDefault),
          ),
          const SizedBox(height: 28),
          PrimaryButton(
            'Save',
            onTap: () {
              final digits = number.text.replaceAll(RegExp(r'\D'), '');
              FoodyStore.of(context).payment =
                  'MasterCard...${digits.length >= 4 ? digits.substring(digits.length - 4) : '8594'}';
              FoodyStore.of(context).notify();
              pop(context);
              toast(context, 'Card saved');
            },
          ),
        ],
      ),
    ),
  );
}
