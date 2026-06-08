import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colors.dart';
import '../widgets/add_group_button.dart';
import '../widgets/common.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bg,
      body: Column(
        children: [
          SettleAppBarLogo(actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none_rounded, color: C.t2, size: 22),
              onPressed: () {},
            )
          ]),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Balance Card ───────────────────────────────────
                  _BalanceCard(),
                  const SizedBox(height: 22),
                  NewGroupButton(),
                  const SizedBox(height: 22),
                  // ── Active Groups ──────────────────────────────────
                  SectionRow(
                    title: 'Active Groups',
                    action: 'See all →',
                    onAction: () => Navigator.pushNamed(context, '/group-workspace'),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _GroupCard(
                          name: "Maldives '24",
                          sub: '6 members',
                          tag: '18% above',
                          tagColor: const Color(0xFF219653),
                          colors: const [Color(0xFF1C7ED6), Color(0xFF1098AD)],
                        ),
                        const SizedBox(width: 10),
                        _GroupCard(
                          name: 'The Di...',
                          sub: '12 memb...',
                          tag: 'ACTIVE',
                          tagColor: const Color(0xFFE67E22),
                          colors: const [Color(0xFF6741D9), Color(0xFF9C36B5)],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),

                  // ── Recent Activity ────────────────────────────────
                  const SectionRow(title: 'Recent Activity'),
                  const SizedBox(height: 12),
                  _ActivityTile(
                    iconBg: const Color(0xFFFFF0E8),
                    icon: Icons.shopping_bag_outlined,
                    iconColor: C.red,
                    title: 'Whole Foods Market',
                    sub: "You paid • Maldives '24",
                    time: 'Yesterday, 6:30 PM',
                    amount: '-\$84.20',
                    amountColor: C.redNeg,
                  ),
                  const SizedBox(height: 8),
                  _ActivityTile(
                    iconBg: const Color(0xFFE9F7EF),
                    icon: Icons.person_outline_rounded,
                    iconColor: C.green,
                    title: 'Marcus Settle Up',
                    sub: 'Marcus paid you • Goa Trip',
                    time: 'Yesterday, 11:10 AM',
                    amount: '+\$100.00',
                    amountColor: C.green,
                  ),
                  const SizedBox(height: 8),
                  _ActivityTile(
                    iconBg: const Color(0xFFE8F4FF),
                    icon: Icons.flight_outlined,
                    iconColor: C.blue,
                    title: 'Flight Tickets',
                    sub: 'Split between 4 people',
                    time: 'Oct 13',
                    amount: '\$460.00',
                    amountColor: C.t1,
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add-expense'),
        backgroundColor: C.red,
        elevation: 3,
        child: const Icon(Icons.add, color: Colors.white, size: 26),
      ),
      bottomNavigationBar: BottomNav(
        index: 0,
        onTap: (i) {
          if (i == 1) Navigator.pushNamed(context, '/group-workspace');
          if (i == 2) Navigator.pushNamed(context, '/smart-settle');
          if (i == 3) Navigator.pushNamed(context,  '/ai-scanner');
        },
      ),
    );
  }
}

// ── Balance Card ──────────────────────────────────────────────────────────────
class _BalanceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: C.red,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Total Net Balance',
              style: GoogleFonts.inter(fontSize: 12, color: Colors.white.withOpacity(0.85))),
          const SizedBox(height: 6),
          Text('\$1,240.50',
              style: GoogleFonts.inter(
                  fontSize: 34, fontWeight: FontWeight.w700, color: Colors.white)),
          const SizedBox(height: 16),
          // Lent / Owe row - white background pills
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('You lent',
                          style: GoogleFonts.inter(
                              fontSize: 11, color: Colors.white.withOpacity(0.8))),
                      const SizedBox(height: 2),
                      Text('\$1,850.00',
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('You owe',
                          style: GoogleFonts.inter(
                              fontSize: 11, color: Colors.white.withOpacity(0.8))),
                      const SizedBox(height: 2),
                      Text('\$609.50',
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Group Card ────────────────────────────────────────────────────────────────
class _GroupCard extends StatelessWidget {
  final String name, sub, tag;
  final Color tagColor;
  final List<Color> colors;
  const _GroupCard({
    required this.name,
    required this.sub,
    required this.tag,
    required this.tagColor,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 148,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft, end: Alignment.bottomRight, colors: colors),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(tag,
                style: GoogleFonts.inter(
                    fontSize: 9, fontWeight: FontWeight.w600, color: Colors.white)),
          ),
          const Spacer(),
          Text(name,
              style: GoogleFonts.inter(
                  fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
          const SizedBox(height: 2),
          Text(sub,
              style: GoogleFonts.inter(fontSize: 11, color: Colors.white.withOpacity(0.8))),
        ],
      ),
    );
  }
}

// ── Activity Tile ─────────────────────────────────────────────────────────────
class _ActivityTile extends StatelessWidget {
  final Color iconBg, iconColor, amountColor;
  final IconData icon;
  final String title, sub, time, amount;
  const _ActivityTile({
    required this.iconBg,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.sub,
    required this.time,
    required this.amount,
    required this.amountColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: C.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: C.div),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.inter(
                        fontSize: 13, fontWeight: FontWeight.w600, color: C.t1)),
                Text(sub,
                    style: GoogleFonts.inter(fontSize: 11, color: C.t3)),
                Text(time,
                    style: GoogleFonts.inter(fontSize: 10, color: C.t3)),
              ],
            ),
          ),
          Text(amount,
              style: GoogleFonts.inter(
                  fontSize: 14, fontWeight: FontWeight.w600, color: amountColor)),
        ],
      ),
    );
  }
}
