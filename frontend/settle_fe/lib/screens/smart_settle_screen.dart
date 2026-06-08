import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colors.dart';
import '../widgets/common.dart';

class SmartSettleScreen extends StatelessWidget {
  const SmartSettleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bg,
      body: Column(
        children: [
          // App bar
          SettleAppBarLogo(actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none_rounded, size: 22, color: C.t2),
              onPressed: () {},
            )
          ]),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Total Expenses card ───────────────────────────
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: C.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: C.div),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Expenses',
                            style: GoogleFonts.inter(fontSize: 12, color: C.t3)),
                        const SizedBox(height: 4),
                        Text('₹24,500',
                            style: GoogleFonts.inter(
                                fontSize: 30, fontWeight: FontWeight.w700, color: C.t1)),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            _StatBadge(label: 'Transactions', value: '8', color: C.t2),
                            const SizedBox(width: 14),
                            _StatBadge(label: 'Saved', value: '63%', color: C.green),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ── Net position ──────────────────────────────────
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: C.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: C.div),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Net Position',
                                  style: GoogleFonts.inter(fontSize: 11, color: C.t3)),
                              const SizedBox(height: 2),
                              Text('You are owed',
                                  style: GoogleFonts.inter(fontSize: 13, color: C.t2)),
                              Text('₹2,350',
                                  style: GoogleFonts.inter(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: C.green)),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: C.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text('Net +₹2,350',
                              style: GoogleFonts.inter(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ── Smart Flow Optimization ───────────────────────
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: C.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: C.div),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Smart Flow Optimization',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: C.t1)),
                        const SizedBox(height: 14),
                        SizedBox(
                          height: 100,
                          child: CustomPaint(
                            painter: _FlowPainter(),
                            size: const Size(double.infinity, 100),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ── Overall Progress ──────────────────────────────
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: C.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: C.div),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Overall Progress',
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: C.t1)),
                                  const SizedBox(height: 2),
                                  Text('4/5 payments completed • 1 payment remaining',
                                      style: GoogleFonts.inter(fontSize: 10, color: C.t3)),
                                ],
                              ),
                            ),
                            Text('80%',
                                style: GoogleFonts.inter(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: C.red)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: 0.80,
                            minHeight: 7,
                            backgroundColor: C.div,
                            color: C.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // ── Pending (3) ───────────────────────────────────
                  Text('Pending (3)',
                      style: GoogleFonts.inter(
                          fontSize: 15, fontWeight: FontWeight.w600, color: C.t1)),
                  const SizedBox(height: 10),

                  _PendingCard(
                    name: 'Aryan',
                    sub: 'Travel Expenses',
                    amount: '₹1,200',
                    owedToYou: true,
                  ),
                  _PendingCard(
                    name: 'Riya',
                    sub: 'Dinner Split',
                    amount: '₹3,450',
                    owedToYou: false,
                    overdueTag: 'OVERDUE',
                  ),
                  const SizedBox(height: 18),

                  // ── Recently Settled ──────────────────────────────
                  Text('Recently Settled',
                      style: GoogleFonts.inter(
                          fontSize: 15, fontWeight: FontWeight.w600, color: C.t1)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _SettledCard(name: 'Karan', label: 'PAID/BACK'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _SettledCard(name: 'Jyok', label: 'VIA UDHAAR'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // ── Settle All button ─────────────────────────────
                  RedButton(
                    label: '⚡  Settle All',
                    onTap: () {},
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(
          index: 2,
          onTap: (i) {
            if (i == 0) Navigator.pushReplacementNamed(context, '/dashboard');
            if (i == 1) Navigator.pushNamed(context, '/group-workspace');
            if (i == 3) Navigator.pushNamed(context,  '/ai-scanner');
          }),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final String label, value;
  final Color color;
  const _StatBadge({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(value,
            style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: color)),
        const SizedBox(width: 5),
        Text(label, style: GoogleFonts.inter(fontSize: 11, color: C.t3)),
      ],
    );
  }
}

// ── Flow Diagram Painter ──────────────────────────────────────────────────────
class _FlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = C.red.withOpacity(0.25)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()..style = PaintingStyle.fill;

    // node positions
    final nodes = {
      'Aryan': Offset(size.width * 0.12, size.height * 0.15),
      'You': Offset(size.width * 0.5, size.height * 0.4),
      'Riya': Offset(size.width * 0.85, size.height * 0.15),
      'Karan': Offset(size.width * 0.25, size.height * 0.82),
      'Jyok': Offset(size.width * 0.75, size.height * 0.82),
    };

    // Draw edges
    final edges = [
      ('Aryan', 'You'),
      ('Riya', 'You'),
      ('You', 'Karan'),
      ('You', 'Jyok'),
      ('Aryan', 'Riya'),
    ];
    for (final e in edges) {
      canvas.drawLine(nodes[e.$1]!, nodes[e.$2]!, linePaint);
    }

    // Draw nodes
    for (final entry in nodes.entries) {
      final isYou = entry.key == 'You';
      final r = isYou ? 16.0 : 13.0;
      dotPaint.color = isYou ? C.red : C.red.withOpacity(0.18);
      canvas.drawCircle(entry.value, r, dotPaint);

      // border for non-you
      if (!isYou) {
        canvas.drawCircle(
          entry.value,
          r,
          Paint()
            ..color = C.red.withOpacity(0.4)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5,
        );
      }

      // label
      final tp = TextPainter(
        text: TextSpan(
          text: entry.key,
          style: TextStyle(
            fontSize: isYou ? 9 : 8,
            fontWeight: FontWeight.w600,
            color: isYou ? Colors.white : C.red,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        entry.value - Offset(tp.width / 2, tp.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

// ── Pending Card ──────────────────────────────────────────────────────────────
class _PendingCard extends StatelessWidget {
  final String name, sub, amount;
  final bool owedToYou;
  final String? overdueTag;
  const _PendingCard({
    required this.name,
    required this.sub,
    required this.amount,
    required this.owedToYou,
    this.overdueTag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: C.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: C.div),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AvatarCircle(label: name[0], color: const Color(0xFF8E6B3C), size: 36),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(owedToYou ? '$name owes you' : 'You owe $name',
                        style: GoogleFonts.inter(
                            fontSize: 13, fontWeight: FontWeight.w600, color: C.t1)),
                    Text(sub,
                        style: GoogleFonts.inter(fontSize: 11, color: C.t3)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(amount,
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: owedToYou ? C.green : C.redNeg)),
                  if (overdueTag != null)
                    Container(
                      margin: const EdgeInsets.only(top: 3),
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEECE8),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(overdueTag!,
                          style: GoogleFonts.inter(
                              fontSize: 9, fontWeight: FontWeight.w700, color: C.redNeg)),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: owedToYou
                ? [
                    _ActionBtn(
                        label: 'Request Payment',
                        bg: const Color(0xFFFEECE8),
                        fg: C.red),
                    const SizedBox(width: 8),
                    _ActionBtn(
                        label: 'Mark Settled',
                        bg: const Color(0xFFF0F0F0),
                        fg: C.t2),
                  ]
                : [
                    Expanded(
                      child: _WideBtn(label: 'Pay Now', bg: C.red, fg: Colors.white),
                    ),
                  ],
          ),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String label;
  final Color bg, fg;
  const _ActionBtn({required this.label, required this.bg, required this.fg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Text(label,
          style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
    );
  }
}

class _WideBtn extends StatelessWidget {
  final String label;
  final Color bg, fg;
  const _WideBtn({required this.label, required this.bg, required this.fg});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
      alignment: Alignment.center,
      child: Text(label,
          style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: fg)),
    );
  }
}

// ── Settled Card ──────────────────────────────────────────────────────────────
class _SettledCard extends StatelessWidget {
  final String name, label;
  const _SettledCard({required this.name, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: C.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: C.div),
      ),
      child: Column(
        children: [
          AvatarCircle(label: name[0], color: const Color(0xFF8E6B3C), size: 36),
          const SizedBox(height: 6),
          Text(name,
              style: GoogleFonts.inter(
                  fontSize: 13, fontWeight: FontWeight.w600, color: C.t1)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: C.greenBg,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(label,
                style: GoogleFonts.inter(
                    fontSize: 9, fontWeight: FontWeight.w700, color: C.green)),
          ),
        ],
      ),
    );
  }
}
