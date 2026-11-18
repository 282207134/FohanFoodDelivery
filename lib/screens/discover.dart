import 'package:flutter/material.dart';

import '../store.dart';
import '../theme.dart';
import '../ui.dart';
import 'orders.dart';
import 'sheets.dart';
import 'store_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final app = FoodyStore.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => push(context, const AccountScreen()),
              child: const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/avatar.png'),
              ),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Delivering to', style: F.caption1),
                const SizedBox(height: 2),
                Text(app.address, style: F.h3),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 76,
          child: ListView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            children: [
              for (final c in cuisines)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CuisineTile(
                    c,
                    active: app.cuisine == c,
                    onTap: () {
                      app.cuisine = c;
                      app.notify();
                    },
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 45,
          child: ListView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            children: [
              GrayChip(
                'Pickup',
                active: app.pickupOnly,
                onTap: () {
                  app.pickupOnly = !app.pickupOnly;
                  app.notify();
                },
              ),
              const SizedBox(width: 10),
              GrayChip(
                'Over 4',
                active: app.ratingMin > 4,
                onTap: () => foodySheet(context, const RatingSheet()),
              ),
              const SizedBox(width: 10),
              GrayChip(
                'Under 30 min',
                active: app.under30,
                onTap: () {
                  app.under30 = !app.under30;
                  app.notify();
                },
              ),
              const SizedBox(width: 10),
              GrayChip(
                '\$',
                active: app.priceLevel != 2,
                onTap: () => foodySheet(context, const PriceSheet()),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () => push(context, ItemScreen(pizza)),
          child: Container(
            height: 146,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: F.coral,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -12,
                  top: -24,
                  bottom: -12,
                  child: Image.asset(
                    'assets/banner_pizza.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Best Pizza Near You',
                        style: F.h3.copyWith(color: F.onAccent, fontSize: 19),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Choose your flavor',
                        style: F.body2.copyWith(color: F.onAccent),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: F.surface,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text('Order Now', style: F.button4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 28),
        SectionHead(
          'Stores near you',
          action: 'See all',
          onAction: () => goTab(context, 1),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 272,
          child: ListView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            children: [
              StoreCard(
                storeById('dalah'),
                onTap: () => push(context, StoreScreen(storeById('dalah'))),
              ),
              const SizedBox(width: 20),
              StoreCard(
                storeById('bobbys'),
                onTap: () => push(context, StoreScreen(storeById('bobbys'))),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        SectionHead(
          'Try Something new',
          action: 'See all',
          onAction: () => goTab(context, 2),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            children: [
              _photoTile(context, 'muffins', '30 min - free delivery'),
              const SizedBox(width: 20),
              _photoTile(context, 'icecream', '30 min delivery'),
            ],
          ),
        ),
        const SizedBox(height: 28),
        SectionHead(
          'Fastest Near You',
          action: 'See all',
          onAction: () => goTab(context, 1),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            children: [
              _photoTile(context, 'caffe', '30 min - free delivery'),
              const SizedBox(width: 20),
              _photoTile(context, 'dessert', '30 min delivery'),
            ],
          ),
        ),
        const SizedBox(height: 28),
        SectionHead('Fastest Near You'),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _TaglineCard('Tasty and reliable\nrated 4.5+')),
            SizedBox(width: 20),
            Expanded(
              child: _TaglineCard('Best Spaghetti and \nquick delivery'),
            ),
          ],
        ),
        const SizedBox(height: 28),
        SectionHead('All stores'),
        const SizedBox(height: 20),
        StoreCard(
          storeById('bobbys'),
          width: double.infinity,
          onTap: () => push(context, StoreScreen(storeById('bobbys'))),
        ),
        const SizedBox(height: 28),
        StoreCard(
          storeById('monini'),
          width: double.infinity,
          onTap: () => push(context, StoreScreen(storeById('monini'))),
        ),
      ],
    );
  }

  Widget _photoTile(BuildContext context, String id, String sub) {
    final s = storeById(id);
    return GestureDetector(
      onTap: () => push(context, StoreScreen(s)),
      child: SizedBox(
        width: 295,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                s.photo,
                width: 295,
                height: 160,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(s.name, style: F.h4),
            const SizedBox(height: 2),
            Text(sub, style: F.body2),
          ],
        ),
      ),
    );
  }
}

class _TaglineCard extends StatelessWidget {
  const _TaglineCard(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 190),
      Text(text, style: F.body2.copyWith(color: F.grayLight)),
    ],
  );
}

class PickupScreen extends StatelessWidget {
  const PickupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final app = FoodyStore.of(context);
    final w = MediaQuery.sizeOf(context).width;
    final visible = stores
        .where(
          (s) =>
              s.rating >= app.ratingMin &&
              s.minutes <= (app.under30 ? 30 : 99) &&
              s.price.length <= app.priceLevel,
        )
        .toList();
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MapHeader(
                  image: 'assets/map_pickup.png',
                  title: 'Add Address',
                  child: Positioned(
                    top: 118,
                    left: 40,
                    right: 40,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: F.field.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(child: Text(app.address, style: F.h4)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: SizedBox(
                    height: 45,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      children: [
                        GrayChip(
                          'Cuisines',
                          active: app.cuisinesOpen,
                          onTap: () {
                            app.cuisinesOpen = !app.cuisinesOpen;
                            app.notify();
                          },
                        ),
                        const SizedBox(width: 10),
                        GrayChip(
                          'Over 4',
                          active: app.ratingMin > 4,
                          onTap: () => foodySheet(context, const RatingSheet()),
                        ),
                        const SizedBox(width: 10),
                        GrayChip(
                          'Under 30 min',
                          active: app.under30,
                          onTap: () {
                            app.under30 = !app.under30;
                            app.notify();
                          },
                        ),
                        const SizedBox(width: 10),
                        GrayChip(
                          '\$',
                          active: app.priceLevel != 2,
                          onTap: () => foodySheet(context, const PriceSheet()),
                        ),
                      ],
                    ),
                  ),
                ),
                if (app.cuisinesOpen)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: SizedBox(
                      height: 76,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        children: [
                          for (final c in cuisines)
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: CuisineTile(
                                c,
                                active: app.cuisine == c,
                                onTap: () {
                                  app.cuisine = c;
                                  app.notify();
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            for (final p in [
              Offset(w * 0.25, 187),
              Offset(w * 0.28, 202),
              Offset(w * 0.07, 262),
              Offset(w * 0.35, 282),
              Offset(w * 0.60, 260),
              Offset(w * 0.78, 257),
            ])
              Positioned(
                left: p.dx,
                top: p.dy,
                child: Image.asset('assets/logo.png', width: 85, height: 110),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHead('All stores'),
              const SizedBox(height: 20),
              for (final s in visible) ...[
                StoreCard(
                  s,
                  width: double.infinity,
                  onTap: () => push(context, StoreScreen(s)),
                ),
                const SizedBox(height: 28),
              ],
              if (visible.isEmpty)
                Text('No stores match your filters', style: F.body2),
            ],
          ),
        ),
      ],
    );
  }
}

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final app = FoodyStore.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: [
        AvatarTitle(
          'Offers',
          onAvatar: () => push(context, const AccountScreen()),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 76,
          child: ListView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            children: [
              for (final c in cuisines)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CuisineTile(
                    c,
                    active: app.cuisine == c,
                    onTap: () {
                      app.cuisine = c;
                      app.notify();
                    },
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 45,
          child: ListView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            children: [
              GrayChip(
                'Offer type',
                active: app.offerType != 'All',
                onTap: () => foodySheet(context, const OfferTypeSheet()),
              ),
              const SizedBox(width: 10),
              GrayChip(
                'Pickup',
                active: app.pickupOnly,
                onTap: () {
                  app.pickupOnly = !app.pickupOnly;
                  app.notify();
                },
              ),
              const SizedBox(width: 10),
              GrayChip(
                'Over 4',
                active: app.ratingMin > 4,
                onTap: () => foodySheet(context, const RatingSheet()),
              ),
              const SizedBox(width: 10),
              GrayChip(
                'Under 30 min',
                active: app.under30,
                onTap: () {
                  app.under30 = !app.under30;
                  app.notify();
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 146,
          child: PageView(
            controller: PageController(viewportFraction: 0.82, initialPage: 1),
            children: [
              for (final img in [
                'assets/offer_left.png',
                'assets/offer_center.png',
                'assets/offer_right.png',
              ])
                GestureDetector(
                  onTap: () => push(context, StoreScreen(storeById('dalah'))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(img, fit: BoxFit.cover),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        SectionHead('62 New Offers'),
        const SizedBox(height: 20),
        StoreCard(
          storeById('bobbys'),
          width: double.infinity,
          onTap: () => push(context, StoreScreen(storeById('bobbys'))),
        ),
        const SizedBox(height: 28),
        StoreCard(
          storeById('monini'),
          width: double.infinity,
          onTap: () => push(context, StoreScreen(storeById('monini'))),
        ),
      ],
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final query = TextEditingController();

  @override
  void initState() {
    super.initState();
    query.addListener(() => setState(() {}));
  }

  static const suggestions = [
    ('Chick fill A', 'chickfila'),
    ('Chicken Collection', 'chickenrice'),
    ('Chicken Rice', 'chickenrice'),
  ];

  @override
  Widget build(BuildContext context) {
    FoodyStore.of(context);
    final q = query.text.toLowerCase();
    final matches = stores
        .where((s) => s.name.toLowerCase().contains(q))
        .toList();
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: [
        AvatarTitle(
          'Search',
          onAvatar: () => push(context, const AccountScreen()),
        ),
        const SizedBox(height: 24),
        FieldBox(
          icon: Icons.search_rounded,
          hint: 'Search stores or dishes',
          controller: query,
        ),
        const SizedBox(height: 20),
        if (q.isEmpty)
          for (final s in suggestions)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => push(context, StoreScreen(storeById(s.$2))),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.$1, style: F.h4),
                    const SizedBox(height: 2),
                    Text('Chicken, Fast Food, Brekfast', style: F.body2),
                  ],
                ),
              ),
            )
        else
          for (final s in matches) ...[
            StoreCard(
              s,
              width: double.infinity,
              onTap: () => push(context, StoreScreen(s)),
            ),
            const SizedBox(height: 24),
          ],
        if (q.isNotEmpty && matches.isEmpty)
          Text('Nothing found for "${query.text}"', style: F.body2),
      ],
    );
  }
}
