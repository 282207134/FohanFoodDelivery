import 'package:flutter/material.dart';

import '../store.dart';
import '../theme.dart';
import '../ui.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen(this.store, {super.key});
  final Store store;
  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  double stars = 0;
  final text = TextEditingController();

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
          Text('Add a Review', style: F.h1),
          const SizedBox(height: 24),
          Stars(value: stars, onTap: (v) => setState(() => stars = v)),
          const SizedBox(height: 28),
          Text(
            stars == 0 ? 'Have a Gift Card?' : 'Rating description',
            style: F.h2,
          ),
          const SizedBox(height: 12),
          Text(
            stars == 0
                ? 'Consider sharing which dishes you enjoyed or didn\'t enjoy, what to order or skip and how this store compares to others.'
                : 'Tell other customers what you loved about ${widget.store.name}.',
            style: F.body2,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: text,
            maxLines: 4,
            style: F.h4.copyWith(fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              hintText: 'Write your review',
              hintStyle: F.body1.copyWith(color: F.grayLight),
              filled: true,
              fillColor: F.field,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 28),
          PrimaryButton(
            'Submit',
            enabled: stars > 0 && text.text.trim().isNotEmpty,
            onTap: () {
              FoodyStore.of(context)
                  .submitReview(widget.store.id, stars, text.text.trim());
              push(context, ThankYouScreen(review: text.text.trim()));
            },
          ),
        ],
      ),
    ),
  );
}

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key, required this.review});
  final String review;
  @override
  Widget build(BuildContext context) {
    FoodyStore.of(context);
    return Scaffold(
      backgroundColor: F.bg,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(40, 24, 40, 24),
          children: [
            Text('Thank you for\nsubmitting a review', style: F.h1),
            const SizedBox(height: 16),
            Text(
              'We\'ll check your review to ensure it meets our Review Guidelines then email you when it\'s approved and added to this store\'s page.',
              style: F.body2,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: F.lightTeal,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/avatar.png'),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(review, style: F.h4.copyWith(color: F.teal)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Image.asset(
              'assets/thanks_illustration.png',
              height: 270,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              'Done',
              onTap: () {
                final nav = Navigator.of(context);
                nav.pop();
                nav.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
