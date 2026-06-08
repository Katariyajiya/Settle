import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colors.dart';
import '../widgets/common.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _page = 0;
  final _ctrl = PageController();

  final _data = const [
    _PageData(
      title: 'Effortless Splitting',
      body:
          "Say goodbye to awkward money talks. Settle expenses with friends instantly, whether it's a coffee or a cross-country trip.",
      badge: 'Diner settled',
      badgeSub: 'Split with 4 friends',
    ),
    _PageData(
      title: 'Track Every Expense',
      body: 'Real-time updates on who owes what. Never lose track of shared bills across all your groups.',
      badge: 'Payment received',
      badgeSub: '₹1,200 from Aryan',
    ),
    _PageData(
      title: 'Settle in Seconds',
      body: 'One tap to settle all dues. Built-in smart routing ensures everyone gets paid fastest.',
      badge: 'All settled! 🎉',
      badgeSub: 'Trip expenses cleared',
    ),
  ];

  void _next() {
    if (_page < _data.length - 1) {
      _ctrl.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      Navigator.pushReplacementNamed(context, '/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bg,
      body: SafeArea(
        child: Column(
          children: [
            // Top: "Settle" red text centered
            const SizedBox(height: 18),
            Text('Settle',
                style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700, color: C.red)),
            const SizedBox(height: 16),

            // Page view
            Expanded(
              child: PageView.builder(
                controller: _ctrl,
                itemCount: _data.length,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (_, i) => _OnboardPage(data: _data[i]),
              ),
            ),

            // Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_data.length, (i) {
                final sel = i == _page;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: sel ? 20 : 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: sel ? C.red : const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),

            // Next button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: RedButton(
                label: 'Next →',
                onTap: _next,
              ),
            ),
            const SizedBox(height: 12),

            // Skip for now
            GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(context, '/welcome'),
              child: Text('Skip for now',
                  style: GoogleFonts.inter(fontSize: 13, color: C.t3)),
            ),
            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}

class _PageData {
  final String title, body, badge, badgeSub;
  const _PageData({required this.title, required this.body, required this.badge, required this.badgeSub});
}

class _OnboardPage extends StatelessWidget {
  final _PageData data;
  const _OnboardPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Photo card with floating badge
          Expanded(
            child: Stack(
              children: [
                // Main image card - warm gradient simulating photo
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFE8D5C4), Color(0xFFD4A88A)],
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Silhouette people illustration
                        Positioned.fill(
                          child: CustomPaint(painter: _PeoplePainter()),
                        ),
                      ],
                    ),
                  ),
                ),

                // Floating badge - bottom left
                Positioned(
                  bottom: 16,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: C.greenBg,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check_rounded, color: C.green, size: 16),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(data.badge,
                                style: GoogleFonts.inter(
                                    fontSize: 12, fontWeight: FontWeight.w600, color: C.t1)),
                            Text(data.badgeSub,
                                style: GoogleFonts.inter(fontSize: 10, color: C.t3)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Title
          Text(
            data.title,
            style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w700, color: C.t1),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),

          // Body text
          Text(
            data.body,
            style: GoogleFonts.inter(fontSize: 13, color: C.t2, height: 1.6),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _PeoplePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = const Color(0xFFC4956A).withOpacity(0.4);
    // simple silhouette shapes
    canvas.drawCircle(Offset(size.width * 0.38, size.height * 0.35), 30, p);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.22, size.height * 0.48, 60, 80),
        const Radius.circular(30),
      ),
      p,
    );
    canvas.drawCircle(Offset(size.width * 0.62, size.height * 0.32), 26, p);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.48, size.height * 0.44, 54, 75),
        const Radius.circular(27),
      ),
      p,
    );
  }

  @override
  bool shouldRepaint(_) => false;
}
