import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'theme.dart';

class Store {
  const Store({
    required this.id,
    required this.name,
    required this.price,
    required this.type,
    required this.photo,
    this.logo,
    this.logoColor = 0xFF30B9B2,
    this.distance = '1.8 km',
    this.hours = 'From 9-5',
    this.minutes = 30,
    this.rating = 4.8,
    this.menu = const [],
  });
  final String id, name, price, type, photo;
  final String? logo;
  final int logoColor;
  final String distance, hours;
  final int minutes;
  final double rating;
  final List<Product> menu;
}

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.photo,
    this.desc = '',
    this.storeId = 'dalah',
  });
  final String id, name, photo, desc, storeId;
  final double price;
}

class CartLine {
  CartLine({
    required this.product,
    this.qty = 1,
    this.addons = const [],
    this.note = '',
  });
  final Product product;
  int qty;
  List<String> addons;
  String note;
  double get unit =>
      product.price + addons.fold(0.0, (s, a) => s + addonPrice(a));
  double get total => unit * qty;
}

double addonPrice(String name) => switch (name) {
  'Stuffed edge' => 2.50,
  _ => 0.50,
};

const addonOptions = [
  'Stuffed edge',
  'Cheese',
  'Bacon',
  'Smoked ham',
  'Olives',
];

const stores = [
  Store(
    id: 'dalah',
    name: 'Dalah',
    price: '\$',
    type: 'Restaurant',
    photo: 'assets/store_hero.png',
    logo: 'assets/logo_dalah.png',
    menu: [
      Product(
        id: 'burger',
        name: 'Burger',
        price: 6.99,
        photo: 'assets/menu_burger.png',
      ),
      Product(
        id: 'wing',
        name: 'Chicken Wing',
        price: 6.99,
        photo: 'assets/menu_wing.png',
      ),
      Product(
        id: 'burrito',
        name: 'Burrito',
        price: 6.99,
        photo: 'assets/menu_burrito.png',
      ),
      Product(
        id: 'taco',
        name: 'Taco',
        price: 6.99,
        photo: 'assets/menu_taco.png',
      ),
    ],
  ),
  Store(
    id: 'bobbys',
    name: "Bobby's",
    price: '\$',
    type: 'Restaurant',
    photo: 'assets/store_bobbys.png',
    logo: 'assets/logo_bobbys.png',
    logoColor: 0xFFFF7A4F,
  ),
  Store(
    id: 'monini',
    name: 'Monini',
    price: '\$\$',
    type: 'Pastry Shop',
    photo: 'assets/store_monini.png',
    logo: 'assets/logo_monini.png',
  ),
  Store(
    id: 'chickenrice',
    name: 'Chicken Rice',
    price: '\$',
    type: 'Restaurant',
    photo: 'assets/order3.png',
  ),
  Store(
    id: 'chickfila',
    name: 'Chick fill A',
    price: '\$',
    type: 'Fast Food',
    photo: 'assets/order4.png',
  ),
  Store(
    id: 'muffins',
    name: 'Muffins',
    price: '\$',
    type: 'Bakery',
    photo: 'assets/home_muffins.png',
  ),
  Store(
    id: 'icecream',
    name: 'Ice cream',
    price: '\$',
    type: 'Deserts',
    photo: 'assets/home_icecream.png',
  ),
  Store(
    id: 'caffe',
    name: 'Caffe',
    price: '\$',
    type: 'Coffee',
    photo: 'assets/home_caffe.png',
  ),
  Store(
    id: 'dessert',
    name: 'Dessert',
    price: '\$\$',
    type: 'Deserts',
    photo: 'assets/home_dessert.png',
  ),
];

Store storeById(String id) =>
    stores.firstWhere((s) => s.id == id, orElse: () => stores.first);

const pizza = Product(
  id: 'pizza',
  name: 'Dalah Pizza',
  price: 20.50,
  photo: 'assets/item_hero.png',
  desc: 'Peeled tomato, oregano, cheese, prosciutto, mushrooms, olives, tomato, ham, rocket',
);

const alsoLike = [
  Product(
    id: 'hotdog',
    name: 'Hot Dog',
    price: 5.99,
    photo: 'assets/also_hotdog.png',
  ),
  Product(
    id: 'pizza2',
    name: 'Pizza',
    price: 5.99,
    photo: 'assets/also_pizza.png',
  ),
  Product(
    id: 'pizza3',
    name: 'Pizza',
    price: 5.99,
    photo: 'assets/also_pizza.png',
  ),
  Product(
    id: 'hotdog2',
    name: 'Hot Dog',
    price: 5.99,
    photo: 'assets/also_hotdog.png',
  ),
];

const favorites = [
  Product(
    id: 'fav1',
    name: 'Ice Cream Raspberries',
    price: 6.99,
    photo: 'assets/fav1.png',
    storeId: 'icecream',
  ),
  Product(
    id: 'fav2',
    name: 'Ice Cream Chocolate',
    price: 6.99,
    photo: 'assets/fav2.png',
    storeId: 'icecream',
  ),
  Product(
    id: 'fav3',
    name: 'Ice Cream Raspberries',
    price: 6.99,
    photo: 'assets/fav3.png',
    storeId: 'icecream',
  ),
  Product(
    id: 'fav4',
    name: 'Ice Cream Chocolate',
    price: 6.99,
    photo: 'assets/fav4.png',
    storeId: 'icecream',
  ),
];

const cuisines = [
  'Convenience',
  'Fast food',
  'Healthy',
  'Chicken',
  'Deserts',
  'Breakfast',
];

class OrderLine {
  const OrderLine({
    required this.storeId,
    required this.title,
    required this.sub,
    required this.price,
    required this.photo,
  });
  final String storeId, title, sub, photo;
  final double price;
}

class GiftCard {
  const GiftCard({
    required this.color,
    required this.text,
    required this.value,
  });
  final int color;
  final String text;
  final double value;
}

class FoodyStore extends ChangeNotifier {
  static FoodyStore of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FoodyScope>()!.notifier!;

  bool onboarded = false;
  bool signedUp = false;
  bool trialActive = false;
  bool darkMode = false;
  String userName = 'Alex Morgan';
  String address = 'New York Elk Street';
  int tab = 0;

  String mode = 'Delivery';
  String dropOff = 'Leave it at my door';
  String phone = '+123 45678978';
  String payment = 'MasterCard...8594';
  String deliveryTime = 'Standard';
  double tip = 2;
  int pickupMinutes = 30;

  final List<CartLine> cart = [];
  final List<OrderLine> orders = [
    const OrderLine(
      storeId: 'bobbys',
      title: "Bobby's",
      sub: '\$ Restaurant',
      price: 5.99,
      photo: 'assets/order1.png',
    ),
    const OrderLine(
      storeId: 'dalah',
      title: 'Dalah',
      sub: 'Burger',
      price: 6.99,
      photo: 'assets/order2.png',
    ),
    const OrderLine(
      storeId: 'chickenrice',
      title: 'Chicken Rice',
      sub: 'Chicken Wings',
      price: 6.99,
      photo: 'assets/order3.png',
    ),
    const OrderLine(
      storeId: 'chickfila',
      title: 'Chick fill A',
      sub: 'Chicken Ring',
      price: 6.99,
      photo: 'assets/order4.png',
    ),
  ];
  final Set<String> liked = {};
  final Map<String, double> storeRatings = {};
  final Map<String, String> storeReviews = {};

  String cuisine = 'Convenience';
  bool cuisinesOpen = false;
  double ratingMin = 3;
  int priceLevel = 2;
  bool under30 = false;
  bool pickupOnly = false;
  String offerType = 'All';
  String query = '';

  String promo = '';
  final List<GiftCard> giftCards = [];
  final Map<String, bool> notifications = {
    'Delivery Push Notifications': true,
    'Delivery SMS Notifications': false,
    'Promotional Push Notifications': true,
  };

  int get cartCount => cart.fold(0, (s, l) => s + l.qty);
  double get cartTotal =>
      cart.fold(0.0, (s, l) => s + l.total) + (mode == 'Delivery' ? tip : 0);
  double get discount => promo.isEmpty ? 0 : 2.0;

  void notify() => notifyListeners();

  void setTab(int i) {
    tab = i;
    notifyListeners();
  }

  void add(
    Product p, {
    int qty = 1,
    List<String> addons = const [],
    String note = '',
  }) {
    final existing = cart
        .where((l) => l.product.id == p.id && listEquals(l.addons, addons))
        .toList();
    if (existing.isEmpty) {
      cart.add(CartLine(product: p, qty: qty, addons: addons, note: note));
    } else {
      existing.first.qty += qty;
    }
    notifyListeners();
  }

  void setQty(CartLine line, int qty) {
    if (qty <= 0) {
      cart.remove(line);
    } else {
      line.qty = qty;
    }
    notifyListeners();
  }

  void remove(CartLine line) {
    cart.remove(line);
    notifyListeners();
  }

  void placeOrder() {
    for (final l in cart) {
      orders.insert(
        0,
        OrderLine(
          storeId: l.product.storeId,
          title: storeById(l.product.storeId).name,
          sub: l.product.name,
          price: l.total,
          photo: l.product.photo,
        ),
      );
    }
    cart.clear();
    promo = '';
    notifyListeners();
  }

  void reorder(OrderLine o) {
    final s = storeById(o.storeId);
    final p = s.menu.isEmpty
        ? Product(
            id: o.title,
            name: o.sub,
            price: o.price,
            photo: o.photo,
            storeId: o.storeId,
          )
        : s.menu.first;
    add(p);
  }

  void toggleLike(String id) {
    liked.contains(id) ? liked.remove(id) : liked.add(id);
    notifyListeners();
  }

  void submitReview(String storeId, double stars, String text) {
    storeRatings[storeId] = stars;
    storeReviews[storeId] = text;
    notifyListeners();
  }

  void applyPromo(String code) {
    promo = code;
    notifyListeners();
  }

  void toggleDark() {
    darkMode = !darkMode;
    F.dark = darkMode;
    notifyListeners();
  }

  void toggleNotification(String key) {
    notifications[key] = !(notifications[key] ?? false);
    notifyListeners();
  }

  void reset() {
    signedUp = false;
    trialActive = false;
    cart.clear();
    promo = '';
    tab = 0;
    notifyListeners();
  }
}

class FoodyScope extends InheritedNotifier<FoodyStore> {
  const FoodyScope({super.key, required FoodyStore store, required super.child})
    : super(notifier: store);
}
