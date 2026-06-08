import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colors.dart';
import '../widgets/common.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});
  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  String _category = 'Dining';
  String _split = 'Equity';
  final _cats = ['Dining', 'Shopping', 'Transport'];
  final _splits = ['Equity', 'Percentage', 'Custom'];

  final _members = [
    _Person(name: 'Chloe', color: const Color(0xFF9B51E0), count: 1),
    _Person(name: 'Mark', color: const Color(0xFF2F80ED), count: 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bg,
      appBar: AppBar(
        backgroundColor: C.surface,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: C.t1),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Add Expense',
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: C.t1)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: const Color(0xFFF3EDFF),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.document_scanner_outlined, size: 18, color: C.purple),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Amount display ───────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                color: C.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: C.div),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text('\$',
                            style: GoogleFonts.inter(
                                fontSize: 22, fontWeight: FontWeight.w500, color: C.t2)),
                      ),
                      const SizedBox(width: 4),
                      Text('0.00',
                          style: GoogleFonts.inter(
                              fontSize: 44, fontWeight: FontWeight.w700, color: C.t1)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('Enter amount',
                      style: GoogleFonts.inter(fontSize: 12, color: C.t3)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Expense Name ─────────────────────────────────────
            _Lab('Expense Name'),
            const SizedBox(height: 6),
            const SettleInput(hint: 'e.g. Dinner at L\'Artusi'),
            const SizedBox(height: 16),

            // ── Category ─────────────────────────────────────────
            _Lab('Category'),
            const SizedBox(height: 8),
            Row(
              children: _cats.map((c) {
                final sel = c == _category;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _category = c),
                    child: Container(
                      margin: const EdgeInsets.only(right: 6),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: sel ? C.red : C.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: sel ? C.red : C.div),
                      ),
                      alignment: Alignment.center,
                      child: Text(c,
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: sel ? Colors.white : C.t2)),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // ── Paid By ──────────────────────────────────────────
            Row(
              children: [
                _Lab('Paid By'),
                const Spacer(),
                GestureDetector(
                  child: Text('Change',
                      style: GoogleFonts.inter(
                          fontSize: 12, fontWeight: FontWeight.w500, color: C.red)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: C.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: C.div),
              ),
              child: Row(
                children: [
                  AvatarCircle(label: 'Y', color: C.red, size: 34),
                  const SizedBox(width: 10),
                  Text('You',
                      style: GoogleFonts.inter(
                          fontSize: 14, fontWeight: FontWeight.w500, color: C.t1)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Split Type ────────────────────────────────────────
            _Lab('Split Type'),
            const SizedBox(height: 8),
            Row(
              children: _splits.map((s) {
                final sel = s == _split;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _split = s),
                    child: Container(
                      margin: const EdgeInsets.only(right: 6),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: sel ? C.red : C.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: sel ? C.red : C.div),
                      ),
                      alignment: Alignment.center,
                      child: Text(s,
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: sel ? Colors.white : C.t2)),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // ── Splitting With ────────────────────────────────────
            Row(
              children: [
                _Lab('Splitting with'),
                const Spacer(),
                const Icon(Icons.group_add_outlined, size: 18, color: C.red),
              ],
            ),
            const SizedBox(height: 8),
            ..._members.map(
              (m) => _PersonRow(
                person: m,
                onInc: () => setState(() => m.count++),
                onDec: () => setState(() {
                  if (m.count > 0) m.count--;
                }),
              ),
            ),
            const SizedBox(height: 16),

            // ── Attach Receipt ────────────────────────────────────
            GestureDetector(
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  color: C.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: C.div),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.receipt_long_outlined, size: 18, color: C.t3),
                    const SizedBox(width: 8),
                    Text('Attach Receipt',
                        style: GoogleFonts.inter(fontSize: 13, color: C.t3)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ── Add Expense button ────────────────────────────────
            RedButton(
              label: 'Add Expense',
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _Lab extends StatelessWidget {
  final String t;
  const _Lab(this.t);
  @override
  Widget build(BuildContext context) => Text(t,
      style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: C.t1));
}

class _Person {
  final String name;
  final Color color;
  int count;
  _Person({required this.name, required this.color, required this.count});
}

class _PersonRow extends StatelessWidget {
  final _Person person;
  final VoidCallback onInc, onDec;
  const _PersonRow({required this.person, required this.onInc, required this.onDec});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: C.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: C.div),
      ),
      child: Row(
        children: [
          AvatarCircle(label: person.name[0], color: person.color, size: 34),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(person.name,
                    style: GoogleFonts.inter(
                        fontSize: 13, fontWeight: FontWeight.w500, color: C.t1)),
                Text('\$0.00',
                    style: GoogleFonts.inter(fontSize: 11, color: C.t3)),
              ],
            ),
          ),
          // Counter: − N +
          Row(
            children: [
              _CBtn(icon: Icons.remove_rounded, onTap: onDec),
              SizedBox(
                width: 28,
                child: Center(
                  child: Text('${person.count}',
                      style: GoogleFonts.inter(
                          fontSize: 15, fontWeight: FontWeight.w600, color: C.t1)),
                ),
              ),
              _CBtn(icon: Icons.add_rounded, onTap: onInc),
            ],
          ),
        ],
      ),
    );
  }
}

class _CBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 15, color: C.t2),
      ),
    );
  }
}
