import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colors.dart';
import '../widgets/common.dart';

class AIBillScannerScreen extends StatefulWidget {
  const AIBillScannerScreen({super.key});
  @override
  State<AIBillScannerScreen> createState() => _AIBillScannerScreenState();
}

class _AIBillScannerScreenState extends State<AIBillScannerScreen> {
  final _items = [
    _Item(name: 'Pasta Carbonara', cat: 'Food & Dining', price: 18.50, qty: 1, sel: true),
    _Item(name: 'House White Wine', cat: 'Beverages', price: 12.00, qty: 1, sel: true),
  ];

  double get _total =>
      _items.where((i) => i.sel).fold(0.0, (s, i) => s + i.price * i.qty);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bg,
      body: Column(
        children: [
          // ── Top receipt photo area ──────────────────────────────
          Container(
            color: C.surface,
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // App bar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_rounded, color: C.t1),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Spacer(),
                        Text('Settle',
                            style: GoogleFonts.inter(
                                fontSize: 17, fontWeight: FontWeight.w700, color: C.red)),
                        const Spacer(),
                        // Refresh icon - red
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEECE8),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.refresh_rounded, size: 18, color: C.red),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),

                  // Receipt image placeholder - dark
                  Container(
                    height: 170,
                    width: double.infinity,
                    color: const Color(0xFF1A1A2E),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Receipt card
                        Container(
                          width: 130,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.3), blurRadius: 10)
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('LA LANTERNA',
                                  style: GoogleFonts.inter(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w700,
                                      color: C.t1)),
                              const SizedBox(height: 4),
                              const Divider(height: 6, color: C.div),
                              _rLine('Pasta Carbonara', '\$18.50'),
                              _rLine('House White Wine', '\$12.00'),
                              const Divider(height: 6, color: C.div),
                              _rLine('TOTAL', '\$43.00', bold: true),
                            ],
                          ),
                        ),
                        // Scan corner brackets
                        ..._corners(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Scrollable content ──────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Restaurant header card
                  Container(
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
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEECE8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.restaurant_rounded,
                              size: 20, color: C.red),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('La Lanterna',
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: C.t1)),
                              Text('Today, 8:45 PM',
                                  style: GoogleFonts.inter(fontSize: 11, color: C.t3)),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('\$43.00',
                                style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: C.t1)),
                            Text('Total Bill',
                                style: GoogleFonts.inter(fontSize: 10, color: C.t3)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Confidence badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      color: C.greenBg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check_circle_rounded,
                            size: 14, color: C.green),
                        const SizedBox(width: 6),
                        Text('Receipt scanned successfully • 99% confidence',
                            style: GoogleFonts.inter(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: C.green)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Detected Items header
                  Row(
                    children: [
                      Text('Detected Items',
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: C.t1)),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => setState(() {
                          final allSel = _items.every((i) => i.sel);
                          for (final i in _items) {
                            i.sel = !allSel;
                          }
                        }),
                        child: Text('Select All',
                            style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: C.red)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Item rows
                  ..._items.map(
                    (item) => _ItemRow(
                      item: item,
                      onToggle: () => setState(() => item.sel = !item.sel),
                      onInc: () => setState(() => item.qty++),
                      onDec: () => setState(() {
                        if (item.qty > 1) item.qty--;
                      }),
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),

          // ── Bottom CTA ──────────────────────────────────────────
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            decoration: const BoxDecoration(
              color: C.surface,
              border: Border(top: BorderSide(color: C.div)),
            ),
            child: SafeArea(
              top: false,
              child: RedButton(
                label: 'Add Selected Items • \$${_total.toStringAsFixed(2)} →',
                onTap: _total > 0
                    ? () => Navigator.pushNamed(context, '/add-expense')
                    : null,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(
          index: 3,
          onTap: (i) {
            if (i == 0) Navigator.pushReplacementNamed(context, '/dashboard');
            if (i == 1) Navigator.pushNamed(context, '/group-workspace');
            if (i == 2) Navigator.pushNamed(context, '/smart-settle');
          }),
    );
  }

  Widget _rLine(String label, String amount, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5),
      child: Row(
        children: [
          Expanded(
            child: Text(label,
                style: TextStyle(
                    fontSize: 7,
                    fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
                    color: Colors.black87)),
          ),
          Text(amount,
              style: TextStyle(
                  fontSize: 7,
                  fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
                  color: Colors.black87)),
        ],
      ),
    );
  }

  List<Widget> _corners() {
    const size = 16.0;
    const thick = 2.5;
    const col = Color(0xFF2DD4BF);
    final positions = [
      const Offset(-75, -55),
      const Offset(75, -55),
      const Offset(-75, 55),
      const Offset(75, 55),
    ];
    return positions.asMap().entries.map((e) {
      final i = e.key;
      final off = e.value;
      final isLeft = i % 2 == 0;
      final isTop = i < 2;
      return Transform.translate(
        offset: off,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            border: Border(
              top: isTop ? const BorderSide(color: col, width: thick) : BorderSide.none,
              bottom: !isTop ? const BorderSide(color: col, width: thick) : BorderSide.none,
              left: isLeft ? const BorderSide(color: col, width: thick) : BorderSide.none,
              right: !isLeft ? const BorderSide(color: col, width: thick) : BorderSide.none,
            ),
          ),
        ),
      );
    }).toList();
  }
}

class _Item {
  final String name, cat;
  final double price;
  int qty;
  bool sel;
  _Item({required this.name, required this.cat, required this.price, required this.qty, required this.sel});
}

class _ItemRow extends StatelessWidget {
  final _Item item;
  final VoidCallback onToggle, onInc, onDec;
  const _ItemRow({required this.item, required this.onToggle, required this.onInc, required this.onDec});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: item.sel ? const Color(0xFFFEF6F4) : C.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: item.sel ? C.red.withOpacity(0.3) : C.div,
        ),
      ),
      child: Row(
        children: [
          // Checkbox
          GestureDetector(
            onTap: onToggle,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: item.sel ? C.red : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: item.sel ? C.red : C.t3,
                  width: 1.5,
                ),
              ),
              child: item.sel
                  ? const Icon(Icons.check_rounded, size: 12, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name,
                    style: GoogleFonts.inter(
                        fontSize: 13, fontWeight: FontWeight.w600, color: C.t1)),
                Text(item.cat,
                    style: GoogleFonts.inter(fontSize: 11, color: C.t3)),
              ],
            ),
          ),

          // Counter
          Row(
            children: [
              _Btn(Icons.remove_rounded, onDec),
              SizedBox(
                width: 26,
                child: Center(
                  child: Text('${item.qty}',
                      style: GoogleFonts.inter(
                          fontSize: 13, fontWeight: FontWeight.w600, color: C.t1)),
                ),
              ),
              _Btn(Icons.add_rounded, onInc),
            ],
          ),
          const SizedBox(width: 8),

          // Price
          Text('\$${(item.price * item.qty).toStringAsFixed(2)}',
              style: GoogleFonts.inter(
                  fontSize: 13, fontWeight: FontWeight.w700, color: C.t1)),
        ],
      ),
    );
  }
}

class _Btn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _Btn(this.icon, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: C.surfaceGrey,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(icon, size: 13, color: C.t2),
      ),
    );
  }
}
