import 'package:flutter/material.dart';

import 'store.dart';
import 'theme.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
    this.label, {
    super.key,
    this.onTap,
    this.color = F.teal,
    this.enabled = true,
    this.height = 70,
  });
  final String label;
  final VoidCallback? onTap;
  final Color color;
  final bool enabled;
  final double height;
  @override
  Widget build(BuildContext context) => Material(
    color: enabled ? color : F.grayLight,
    borderRadius: BorderRadius.circular(16),
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: enabled ? onTap : null,
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Center(
          child: Text(
            label.toUpperCase(),
            style: F.button1.copyWith(
              color: color == F.coral ? F.onAccent : Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}

class AmountButton extends StatelessWidget {
  const AmountButton(this.label, {super.key, required this.total, this.onTap});
  final String label;
  final double total;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      PrimaryButton(label, onTap: onTap),
      Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          color: F.petrol,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        child: Row(
          children: [
            Text(
              'Total',
              style: F.body2.copyWith(
                color: F.dark ? Colors.white : Colors.white70,
              ),
            ),
            const Spacer(),
            Text(usd(total), style: F.h4.copyWith(color: F.totalValue)),
          ],
        ),
      ),
    ],
  );
}

class BackBubble extends StatelessWidget {
  const BackBubble({super.key, this.onTap});
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    FoodyStore.of(context);
    return GestureDetector(
      onTap: onTap ?? () => pop(context),
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: F.lightCoral,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.arrow_back_rounded, color: F.coral, size: 20),
      ),
    );
  }
}

class AvatarTitle extends StatelessWidget {
  const AvatarTitle(this.title, {super.key, this.onAvatar});
  final String title;
  final VoidCallback? onAvatar;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      GestureDetector(
        onTap: onAvatar,
        child: const CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage('assets/avatar.png'),
        ),
      ),
      Expanded(
        child: Center(child: Text(title, style: F.h1)),
      ),
      const SizedBox(width: 50),
    ],
  );
}

class FieldBox extends StatelessWidget {
  const FieldBox({
    super.key,
    required this.icon,
    required this.hint,
    this.controller,
    this.obscure = false,
    this.keyboard,
    this.onTap,
    this.autofocus = false,
  });
  final IconData icon;
  final String hint;
  final TextEditingController? controller;
  final bool obscure;
  final TextInputType? keyboard;
  final VoidCallback? onTap;
  final bool autofocus;
  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    obscureText: obscure,
    keyboardType: keyboard,
    autofocus: autofocus,
    onTap: onTap,
    readOnly: onTap != null,
    style: F.h4.copyWith(fontWeight: FontWeight.w500),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: F.body1.copyWith(color: F.grayLight),
      prefixIcon: Icon(icon, color: F.grayLight, size: 20),
      filled: true,
      fillColor: F.field,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: F.teal, width: 1.2),
      ),
    ),
  );
}

class GrayChip extends StatelessWidget {
  const GrayChip(
    this.label, {
    super.key,
    this.active = false,
    this.onTap,
    this.activeColor = F.coral,
  });
  final String label;
  final bool active;
  final VoidCallback? onTap;
  final Color activeColor;
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: active ? activeColor : F.field,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: F.h4.copyWith(
              color: active ? F.onAccent : F.ink,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}

class CuisineTile extends StatelessWidget {
  const CuisineTile(this.label, {super.key, this.active = false, this.onTap});
  final String label;
  final bool active;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: SizedBox(
      width: 64,
      child: Column(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: active ? F.coral : F.line, width: 1.4),
              color: F.surface,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: F.small2.copyWith(
              color: active ? F.coral : F.muted,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}

class ModeToggle extends StatelessWidget {
  const ModeToggle({super.key, required this.value, required this.onChanged});
  final String value;
  final ValueChanged<String> onChanged;
  @override
  Widget build(BuildContext context) => Container(
    height: 45,
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: F.tint,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        for (final m in ['Delivery', 'Pickup'])
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(m),
              child: Container(
                decoration: BoxDecoration(
                  color: value == m ? F.coral : Colors.transparent,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Center(
                  child: Text(
                    m,
                    style: F.h4.copyWith(
                      color: value == m ? F.onAccent : F.coral,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

class Stars extends StatelessWidget {
  const Stars({
    super.key,
    required this.value,
    this.size = 34,
    this.onTap,
    this.spacing = 10,
  });
  final double value;
  final double size;
  final ValueChanged<double>? onTap;
  final double spacing;
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      for (var i = 1; i <= 5; i++)
        Padding(
          padding: EdgeInsets.only(right: i == 5 ? 0 : spacing),
          child: GestureDetector(
            onTap: onTap == null ? null : () => onTap!(i.toDouble()),
            child: Icon(
              i <= value ? Icons.star_rounded : Icons.star_outline_rounded,
              color: F.teal,
              size: size,
            ),
          ),
        ),
    ],
  );
}

class SectionHead extends StatelessWidget {
  const SectionHead(this.title, {super.key, this.action, this.onAction});
  final String title;
  final String? action;
  final VoidCallback? onAction;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(child: Text(title, style: F.h2)),
      if (action != null)
        GestureDetector(
          onTap: onAction,
          child: Text(action!, style: F.button4),
        ),
    ],
  );
}

class StoreLogo extends StatelessWidget {
  const StoreLogo(this.store, {super.key, this.size = 68});
  final Store store;
  final double size;
  @override
  Widget build(BuildContext context) => store.logo != null
      ? Image.asset(store.logo!, width: size, height: size)
      : Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Color(store.logoColor),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              store.name.characters.first,
              style: F.h2.copyWith(color: Colors.white),
            ),
          ),
        );
}

class StoreCard extends StatelessWidget {
  const StoreCard(this.store, {super.key, this.width = 295, this.onTap});
  final Store store;
  final double width;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  store.photo,
                  width: width,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(left: 12, bottom: -24, child: StoreLogo(store)),
            ],
          ),
          const SizedBox(height: 32),
          Text(store.name, style: F.h3.copyWith(fontSize: 19, height: 25 / 19)),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${store.price}   ${store.type}',
                      style: F.body2.copyWith(color: F.ink),
                    ),
                    const SizedBox(height: 4),
                    Center(child: Text('5,100 + ratings', style: F.body2)),
                  ],
                ),
              ),
              Text(
                '${store.minutes} min\ndelivery',
                textAlign: TextAlign.right,
                style: F.body2,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class ProductCard extends StatelessWidget {
  const ProductCard(
    this.product, {
    super.key,
    this.width = 135,
    this.onAdd,
    this.onTap,
  });
  final Product product;
  final double width;
  final VoidCallback? onAdd;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  product.photo,
                  width: width,
                  height: width,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: -6,
                bottom: -10,
                child: GestureDetector(
                  onTap: onAdd,
                  child: Container(
                    width: 38,
                    height: 38,
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
          const SizedBox(height: 16),
          Text(
            usd(product.price),
            style: F.body2.copyWith(color: F.ink, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 2),
          Text(
            product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: F.body2.copyWith(color: F.ink),
          ),
        ],
      ),
    ),
  );
}

class BottomNav extends StatelessWidget {
  const BottomNav({super.key, required this.index, this.onTap});
  final int index;
  final ValueChanged<int>? onTap;
  static const items = [
    (Icons.home_outlined, 'Home'),
    (Icons.shopping_bag_outlined, 'Pickup'),
    (Icons.sell_outlined, 'Offers'),
    (Icons.search_rounded, 'Search'),
    (Icons.receipt_long_outlined, 'Orders'),
  ];
  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    child: SizedBox(
      height: 76,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (var i = 0; i < items.length; i++)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onTap?.call(i),
              child: Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: i == index ? 16 : 12),
                decoration: BoxDecoration(
                  color: i == index ? F.navActive : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      items[i].$1,
                      color: i == index ? Colors.white : F.navIcon,
                      size: 18,
                    ),
                    if (i == index) ...[
                      const SizedBox(width: 8),
                      Text(items[i].$2, style: F.button2),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

void goTab(BuildContext context, int i) {
  final store = FoodyStore.of(context);
  Navigator.of(context).popUntil(ModalRoute.withName('/shell'));
  store.setTab(i);
}

class NavScaffold extends StatelessWidget {
  const NavScaffold({super.key, required this.index, required this.child});
  final int index;
  final Widget child;
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: F.petrol,
    body: Column(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
            child: Container(color: F.bg, child: child),
          ),
        ),
        BottomNav(index: index, onTap: (i) => goTab(context, i)),
      ],
    ),
  );
}

class MapHeader extends StatelessWidget {
  const MapHeader({
    super.key,
    required this.image,
    this.title,
    this.height = 352,
    this.child,
  });
  final String image;
  final String? title;
  final double height;
  final Widget? child;
  @override
  Widget build(BuildContext context) => SizedBox(
    height: height,
    child: Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Positioned.fill(child: Image.asset(image, fit: BoxFit.cover)),
        if (F.dark)
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black54, Colors.transparent],
                  stops: [0, 0.45],
                ),
              ),
            ),
          ),
        if (title != null)
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(child: Text(title!, style: F.h2)),
          ),
        ?child,
      ],
    ),
  );
}

Future<T?> foodySheet<T>(BuildContext context, Widget child) =>
    showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: F.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: child,
      ),
    );

class SheetHandle extends StatelessWidget {
  const SheetHandle({super.key});
  @override
  Widget build(BuildContext context) {
    FoodyStore.of(context);
    return Center(
      child: Container(
        width: 44,
        height: 5,
        margin: const EdgeInsets.only(top: 12, bottom: 8),
        decoration: BoxDecoration(
          color: F.line,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}

class HaloSlider extends StatelessWidget {
  const HaloSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 3,
    this.max = 5,
    this.divisions = 4,
    this.color = F.coral,
    this.labels = const ['3', '3.5', '4', '4.5', '5'],
  });
  final double value;
  final ValueChanged<double> onChanged;
  final double min, max;
  final int divisions;
  final Color color;
  final List<String> labels;
  @override
  Widget build(BuildContext context) => Column(
    children: [
      SliderTheme(
        data: SliderThemeData(
          activeTrackColor: color,
          inactiveTrackColor: F.line,
          thumbColor: color,
          overlayColor: color.withValues(alpha: 0.15),
          trackHeight: 4,
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 9),
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
        ),
        child: Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          onChanged: onChanged,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (final l in labels)
              Text(l, style: F.body2.copyWith(color: F.grayLight)),
          ],
        ),
      ),
    ],
  );
}

class QtyStepper extends StatelessWidget {
  const QtyStepper({super.key, required this.qty, required this.onChanged});
  final int qty;
  final ValueChanged<int> onChanged;
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      _circle(Icons.remove_rounded, () => onChanged(qty - 1)),
      SizedBox(
        width: 44,
        child: Center(child: Text('$qty', style: F.h3)),
      ),
      _circle(Icons.add_rounded, () => onChanged(qty + 1)),
    ],
  );
  Widget _circle(IconData icon, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: F.tint,
        borderRadius: BorderRadius.circular(19),
      ),
      child: Icon(icon, color: F.coral, size: 18),
    ),
  );
}

class CheckRow extends StatelessWidget {
  const CheckRow({
    super.key,
    required this.label,
    required this.checked,
    required this.onTap,
    this.trailing,
  });
  final String label;
  final bool checked;
  final VoidCallback onTap;
  final String? trailing;
  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: checked ? F.coral : F.surface,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: checked ? F.coral : F.grayLight,
                width: 1.4,
              ),
            ),
            child: checked
                ? Icon(Icons.check_rounded, color: F.onAccent, size: 14)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: F.body1.copyWith(color: F.ink)),
          ),
          if (trailing != null) Text(trailing!, style: F.body2),
        ],
      ),
    ),
  );
}

class ThinLine extends StatelessWidget {
  const ThinLine({super.key, this.indent = 0});
  final double indent;
  @override
  Widget build(BuildContext context) {
    FoodyStore.of(context);
    return Container(
      height: 1,
      margin: EdgeInsets.only(left: indent),
      color: F.line,
    );
  }
}

class GiftCardArt extends StatelessWidget {
  const GiftCardArt({
    super.key,
    required this.color,
    required this.text,
    this.width = 295,
    this.brand = 'Foody',
  });
  final int color;
  final String text;
  final double width;
  final String brand;
  @override
  Widget build(BuildContext context) {
    final c = Color(color);
    final textColor = F.dark && c.computeLuminance() > 0.35
        ? F.onAccent
        : Colors.white;
    return Container(
      width: width,
      height: width * 0.62,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [c.withValues(alpha: 0.75), c],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -30,
            top: -40,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(brand, style: F.h4.copyWith(color: textColor)),
                const Spacer(),
                Text(
                  text,
                  style: F.h2.copyWith(color: textColor, fontSize: 24),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
