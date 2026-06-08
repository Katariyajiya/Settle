import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colors.dart';
import '../widgets/common.dart';

class GroupWorkspaceScreen extends StatefulWidget {
  const GroupWorkspaceScreen({super.key});
  @override
  State<GroupWorkspaceScreen> createState() => _GroupWorkspaceScreenState();
}

class _GroupWorkspaceScreenState extends State<GroupWorkspaceScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bg,
      body: Column(
        children: [
          _buildHeader(context),
          _buildTabs(),
          Expanded(
            child: TabBarView(
              controller: _tab,
              children: [_ExpensesTab(), _BalancesTab(), _ActivityTab()],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add-expense'),
        backgroundColor: C.red,
        child: const Icon(Icons.add, color: Colors.white, size: 26),
      ),
      bottomNavigationBar: BottomNav(
        index: 1,
        onTap: (i) {
          if (i == 0) Navigator.pushReplacementNamed(context, '/dashboard');
          if (i == 2) Navigator.pushReplacementNamed(context, '/smart-settle');
          if (i == 3) Navigator.pushNamed(context, '/ai-scanner');
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: C.surface,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ── App bar row ──────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [Color(0xFFE57373), C.red]),
                    ),
                    child: Center(
                      child: Text('S',
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('Settle',
                      style: GoogleFonts.inter(
                          fontSize: 17, fontWeight: FontWeight.w700, color: C.red)),

                  const Spacer(),

                  // ── New Group chip ───────────────────────────
                  _NewGroupChip(
                    onTap: () => Navigator.pushNamed(context, '/create-group'),
                  ),

                  const SizedBox(width: 10),

                  // Bell
                  const Icon(Icons.notifications_none_rounded, color: C.t2, size: 22),
                ],
              ),
            ),

            // ── Hero image card ──────────────────────────────────
            Container(
              height: 148,
              margin: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF2D6A8F), Color(0xFFE07B4A)],
                ),
              ),
              child: Stack(
                children: [
                  // Sun circle
                  Positioned(
                    top: 20,
                    right: 30,
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5C518).withOpacity(0.85),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  // Wave silhouette
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CustomPaint(painter: _WavePainter()),
                    ),
                  ),
                  // Bottom info
                  Positioned(
                    bottom: 12,
                    left: 14,
                    right: 14,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Goa Trip 2024',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white)),
                              const SizedBox(height: 4),
                              // Avatar stack
                              SizedBox(
                                height: 22,
                                child: Stack(
                                  children: [
                                    for (int i = 0; i < 4; i++)
                                      Positioned(
                                        left: i * 16.0,
                                        child: Container(
                                          width: 22,
                                          height: 22,
                                          decoration: BoxDecoration(
                                            color: [
                                              const Color(0xFF4CAF50),
                                              const Color(0xFF2196F3),
                                              const Color(0xFFFF5722),
                                              const Color(0xFF9C27B0),
                                            ][i],
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.white, width: 1.5),
                                          ),
                                        ),
                                      ),
                                    Positioned(
                                      left: 4 * 16.0,
                                      child: Container(
                                        width: 22,
                                        height: 22,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.3),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.white, width: 1.5),
                                        ),
                                        child: Center(
                                          child: Text('+3',
                                              style: GoogleFonts.inter(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text('8 members participating',
                                  style: GoogleFonts.inter(
                                      fontSize: 10,
                                      color: Colors.white.withOpacity(0.85))),
                            ],
                          ),
                        ),
                        // Active badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: C.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text('Active',
                              style: GoogleFonts.inter(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      color: C.surface,
      child: TabBar(
        controller: _tab,
        labelColor: C.red,
        unselectedLabelColor: C.t3,
        indicatorColor: C.red,
        indicatorWeight: 2,
        labelStyle:
        GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 13),
        tabs: const [
          Tab(text: 'Expenses'),
          Tab(text: 'Balances'),
          Tab(text: 'Activity'),
        ],
      ),
    );
  }
}

// ─── New Group Chip ───────────────────────────────────────────────────────────
class _NewGroupChip extends StatefulWidget {
  final VoidCallback onTap;
  const _NewGroupChip({required this.onTap});

  @override
  State<_NewGroupChip> createState() => _NewGroupChipState();
}

class _NewGroupChipState extends State<_NewGroupChip> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: _pressed ? C.red : const Color(0xFFF3E8E5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _pressed ? C.redDark : C.red,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Plus icon bubble
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: _pressed ? Colors.white.withOpacity(0.25) : C.red,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                size: 12,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              'New Group',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: _pressed ? Colors.white : C.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Wave painter ─────────────────────────────────────────────────────────────
class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = const Color(0xFF1A3A52).withOpacity(0.6);
    final path = Path()
      ..moveTo(0, size.height * 0.6)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.45,
          size.width * 0.5, size.height * 0.58)
      ..quadraticBezierTo(
          size.width * 0.75, size.height * 0.7, size.width, size.height * 0.55)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(_) => false;
}

// ─── Expenses Tab ─────────────────────────────────────────────────────────────
class _ExpensesTab extends StatelessWidget {
  final _items = const [
    _Exp(
      date: 'TODAY, MAY 24',
      icon: Icons.restaurant_rounded,
      iconBg: Color(0xFFFFF0E8),
      iconColor: Color(0xFFE07B4A),
      title: 'Calamari Beach Shack',
      paidBy: 'Paddy You',
      total: '₹4,250',
      share: 'You owe ₹895',
      shareColor: Color(0xFFBF3B21),
      tag: 'LUNCH',
      tagBg: Color(0xFFFFF0E8),
      tagFg: Color(0xFFBF6B00),
      isFirst: true,
    ),
    _Exp(
      date: '',
      icon: Icons.local_taxi_rounded,
      iconBg: Color(0xFFE8F4FF),
      iconColor: Color(0xFF1565C0),
      title: 'Taxi to Panjim',
      paidBy: 'Paddy You',
      total: '₹1,200',
      share: 'You owe ₹300',
      shareColor: Color(0xFFBF3B21),
      tag: 'TRANSPORT',
      tagBg: Color(0xFFE8F4FF),
      tagFg: Color(0xFF1565C0),
      isFirst: false,
    ),
    _Exp(
      date: 'YESTERDAY, MAY 23',
      icon: Icons.hotel_rounded,
      iconBg: Color(0xFFE8F4FF),
      iconColor: Color(0xFF1565C0),
      title: 'Villa Stay (3 Nights)',
      paidBy: 'Paid by John D',
      total: '₹28,500',
      share: '+₹19,000',
      shareColor: Color(0xFF219653),
      tag: 'LODGING',
      tagBg: Color(0xFFE8F4FF),
      tagFg: Color(0xFF1565C0),
      isFirst: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
      itemCount: _items.length,
      itemBuilder: (_, i) {
        final e = _items[i];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (e.date.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8, top: 4),
                child: Text(e.date,
                    style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                        color: C.t3)),
              ),
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: C.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: C.div),
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration:
                    BoxDecoration(color: e.iconBg, shape: BoxShape.circle),
                    child: Icon(e.icon, size: 20, color: e.iconColor),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e.title,
                            style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: C.t1)),
                        const SizedBox(height: 2),
                        Text(e.paidBy,
                            style: GoogleFonts.inter(
                                fontSize: 11, color: C.t3)),
                        const SizedBox(height: 5),
                        TagPill(e.tag, bg: e.tagBg, fg: e.tagFg),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(e.total,
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: C.t1)),
                      const SizedBox(height: 4),
                      Text(e.share,
                          style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: e.shareColor)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Exp {
  final String date, title, paidBy, total, share, tag;
  final IconData icon;
  final Color iconBg, iconColor, shareColor, tagBg, tagFg;
  final bool isFirst;
  const _Exp({
    required this.date,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.paidBy,
    required this.total,
    required this.share,
    required this.shareColor,
    required this.tag,
    required this.tagBg,
    required this.tagFg,
    required this.isFirst,
  });
}

class _BalancesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text('Balances', style: TextStyle(color: C.t3)));
}

class _ActivityTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text('Activity', style: TextStyle(color: C.t3)));
}
