import 'package:flutter/material.dart';

import '../store.dart';
import '../theme.dart';
import '../ui.dart';
import 'cart.dart';
import 'review.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen(this.store, {super.key});
  final Store store;
  @override
  Widget build(BuildContext context) {
    final app = FoodyStore.of(context);
    return NavScaffold(
      index: 1,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset(
                store.photo,
                height: 307,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: MediaQuery.paddingOf(context).top + 12,
                left: 20,
                child: const BackBubble(),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: -57,
                child: Center(child: StoreLogo(store, size: 114)),
              ),
            ],
          ),
          const SizedBox(height: 70),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Text(store.name, style: F.h1),
                const SizedBox(height: 8),
                Text(
                  '${store.price}   ${store.type}',
                  style: F.body1.copyWith(color: F.ink),
                ),
                const SizedBox(height: 4),
                Text('5,100 + ratings', style: F.body2),
                const SizedBox(height: 4),
                Text(store.distance, style: F.body2),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: _stat(store.distance, 'Distance')),
                    const SizedBox(width: 14),
                    Expanded(child: _stat('Open', store.hours)),
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
                if (app.mode == 'Pickup') ...[
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Pickup this order at:', style: F.h4),
                  ),
                  const SizedBox(height: 10),
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
                ],
                const SizedBox(height: 28),
                SectionHead(
                  "What's good here",
                  action: 'See all',
                  onAction: () => toast(context, 'Full menu coming soon'),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'These items are best sellers with most customers, \nand we think you\'ll like them too',
                    style: F.body2,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 210,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.none,
                    padding: const EdgeInsets.only(right: 40),
                    children: [
                      for (final p
                          in store.menu.isEmpty ? alsoLike : store.menu)
                        Padding(
                          padding: const EdgeInsets.only(right: 25),
                          child: ProductCard(
                            p,
                            onAdd: () {
                              app.add(p);
                              toast(context, '${p.name} added to order');
                            },
                            onTap: () => push(context, ItemScreen(p)),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                SectionHead('Rate the store'),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Share your thoughts on the store with \nother customers',
                    style: F.body2,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      (app.storeRatings[store.id] ?? store.rating)
                          .toStringAsFixed(1),
                      style: F.h1,
                    ),
                    const SizedBox(width: 12),
                    Text('5,100 + ratings', style: F.body2),
                  ],
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => push(context, ReviewScreen(store)),
                  child: Container(
                    height: 110,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: F.lightTeal,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 24,
                          backgroundImage: AssetImage('assets/avatar.png'),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'Tap to rate',
                          style: F.h4.copyWith(color: F.teal),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                if (app.cartCount > 0)
                  GestureDetector(
                    onTap: () => push(context, const CartScreen()),
                    child: Container(
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: F.teal,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: F.dark ? F.tealDark : Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              color: F.dark ? Colors.white : F.teal,
                              size: 20,
                            ),
                          ),
                          const Spacer(),
                          Text('VIEW CART', style: F.button1),
                          const Spacer(),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: F.dark ? F.tealDark : F.coral,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text('${app.cartCount}', style: F.button2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(String value, String label) => Container(
    padding: const EdgeInsets.symmetric(vertical: 14),
    decoration: BoxDecoration(
      color: F.dark ? Colors.transparent : F.field,
      borderRadius: BorderRadius.circular(12),
      border: F.dark ? Border.all(color: F.line) : null,
    ),
    child: Column(
      children: [
        Text(value, style: F.h4),
        const SizedBox(height: 2),
        Text(label, style: F.small2),
      ],
    ),
  );
}

class ItemScreen extends StatefulWidget {
  const ItemScreen(this.product, {super.key});
  final Product product;
  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  final Set<String> addons = {};
  final note = TextEditingController();
  int qty = 1;

  double get total =>
      (widget.product.price + addons.fold(0.0, (s, a) => s + addonPrice(a))) *
      qty;

  @override
  Widget build(BuildContext context) {
    final store = storeById(widget.product.storeId);
    final app = FoodyStore.of(context);
    return Scaffold(
      backgroundColor: F.bg,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset(
                widget.product.id == 'pizza'
                    ? widget.product.photo
                    : store.photo,
                height: 307,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: MediaQuery.paddingOf(context).top + 12,
                left: 20,
                child: const BackBubble(),
              ),
              Positioned(
                left: 20,
                bottom: -34,
                child: StoreLogo(store, size: 68),
              ),
              Positioned(
                right: 20,
                bottom: 20,
                child: GestureDetector(
                  onTap: () => push(context, StoreScreen(store)),
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: F.coral,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'GO TO STORE',
                        style: F.button2.copyWith(color: F.onAccent),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.product.name, style: F.h2),
                const SizedBox(height: 8),
                Text(
                  widget.product.desc.isEmpty
                      ? 'Freshly made to order with the best local ingredients'
                      : widget.product.desc,
                  style: F.body2,
                ),
                const SizedBox(height: 24),
                Text('Protein Add', style: F.h4),
                const SizedBox(height: 2),
                Text('Select up to 2', style: F.small1),
                const SizedBox(height: 8),
                for (final a in addonOptions)
                  CheckRow(
                    label: a,
                    trailing: usd(addonPrice(a)),
                    checked: addons.contains(a),
                    onTap: () {
                      if (!addons.contains(a) && addons.length == 2) {
                        toast(context, 'Select up to 2 additions');
                        return;
                      }
                      setState(
                        () => addons.contains(a)
                            ? addons.remove(a)
                            : addons.add(a),
                      );
                    },
                  ),
                const SizedBox(height: 20),
                Text('Preferences', style: F.h4),
                const SizedBox(height: 10),
                FieldBox(
                  icon: Icons.edit_outlined,
                  hint: 'Add a note for the store',
                  controller: note,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text('Quantity', style: F.h4),
                    const Spacer(),
                    QtyStepper(
                      qty: qty,
                      onChanged: (v) => setState(() => qty = v < 1 ? 1 : v),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                AmountButton(
                  'Add to Order',
                  total: total,
                  onTap: () {
                    app.add(
                      widget.product,
                      qty: qty,
                      addons: addons.toList(),
                      note: note.text,
                    );
                    pop(context);
                    toast(context, '${widget.product.name} added to order');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
