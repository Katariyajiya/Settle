import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colors.dart';
import '../widgets/common.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});
  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  String _type = 'Trip';
  final _types = ['Trip', 'Roommates', 'Event', 'Travel'];

  final _templateIcons = [
    (Icons.flight_rounded, 'Trip'),
    (Icons.home_rounded, 'Home'),
    (Icons.restaurant_rounded, 'Food'),
    (Icons.celebration_rounded, 'Party'),
  ];

  // Members state
  final _members = [
    _M(name: 'Alex Thompson', handle: '@alex_t', status: 0), // 0=none,1=added,2=removed
    _M(name: 'Sarah Miller', handle: '@sarah_m', status: 1),
  ];
  final _moderators = [
    _M(name: 'David Chen', handle: 'Frequently added', status: 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bg,
      appBar: AppBar(
        backgroundColor: C.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: C.t1),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Create Group',
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: C.t1)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Template picker box ──────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFF3EDFF),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  // Camera icon with + overlay
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: C.purple.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt_rounded, color: C.purple, size: 28),
                      ),
                      Positioned(
                        right: -2,
                        bottom: -2,
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: const BoxDecoration(color: C.purple, shape: BoxShape.circle),
                          child: const Icon(Icons.add, color: Colors.white, size: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('START WITH A TEMPLATE',
                      style: GoogleFonts.inter(
                          fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 1.0, color: C.t3)),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _templateIcons.map((t) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.06),
                                      blurRadius: 8)
                                ],
                              ),
                              child: Icon(t.$1, size: 22, color: C.purple),
                            ),
                            const SizedBox(height: 5),
                            Text(t.$2,
                                style: GoogleFonts.inter(fontSize: 11, color: C.t2)),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // ── Group Name ───────────────────────────────────────
            _Label('Group Name'),
            const SizedBox(height: 6),
            const SettleInput(hint: 'Group Name'),
            const SizedBox(height: 16),

            // ── Group Type chips ─────────────────────────────────
            _Label('Group Type'),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _types.map((t) {
                  final sel = t == _type;
                  return GestureDetector(
                    onTap: () => setState(() => _type = t),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: sel ? C.red : C.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: sel ? C.red : C.div),
                      ),
                      child: Text(t,
                          style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: sel ? Colors.white : C.t2)),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // ── Description / Budget optional rows ───────────────
            _OptionalRow(Icons.edit_note_rounded, 'Add Description (Optional)'),
            const SizedBox(height: 10),
            _OptionalRow(Icons.account_balance_wallet_outlined, 'Set Group Budget (Optional)'),
            const SizedBox(height: 22),

            // ── Invite Members ───────────────────────────────────
            Row(
              children: [
                _Label('Invite Members'),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: C.green.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('3 added',
                      style: GoogleFonts.inter(
                          fontSize: 11, fontWeight: FontWeight.w600, color: C.green)),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Search box
            Container(
              height: 42,
              decoration: BoxDecoration(
                color: C.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: C.div),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  const Icon(Icons.search_rounded, size: 18, color: C.t3),
                  const SizedBox(width: 8),
                  Text('Search friends by name or username...',
                      style: GoogleFonts.inter(fontSize: 13, color: C.t3)),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Member rows
            ..._members.map((m) => _MemberRow(
                  m: m,
                  onToggle: () => setState(() {
                    m.status = m.status == 1 ? 2 : 1;
                  }),
                )),
            const Divider(height: 24, color: C.div),

            // Moderator label
            Text('MODERATOR',
                style: GoogleFonts.inter(
                    fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 1.0, color: C.t3)),
            const SizedBox(height: 10),
            ..._moderators.map((m) => _MemberRow(
                  m: m,
                  onToggle: () => setState(() => m.status = m.status == 1 ? 0 : 1),
                )),
            const SizedBox(height: 28),

            // Create Group button
            RedButton(
              label: 'Create Group →',
              onTap: () => Navigator.pushNamed(context, '/group-workspace'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(index: 1, onTap: (_) {}),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);
  @override
  Widget build(BuildContext context) => Text(text,
      style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: C.t1));
}

class _OptionalRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _OptionalRow(this.icon, this.text);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: C.t3),
        const SizedBox(width: 8),
        Text(text, style: GoogleFonts.inter(fontSize: 13, color: C.t3)),
      ],
    );
  }
}

class _M {
  final String name, handle;
  int status; // 0=none, 1=added, 2=removed
  _M({required this.name, required this.handle, required this.status});
}

class _MemberRow extends StatelessWidget {
  final _M m;
  final VoidCallback onToggle;
  const _MemberRow({required this.m, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          AvatarCircle(
            label: m.name[0],
            color: C.red.withOpacity(0.7),
            size: 38,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(m.name,
                    style: GoogleFonts.inter(
                        fontSize: 13, fontWeight: FontWeight.w600, color: C.t1)),
                Text(m.handle,
                    style: GoogleFonts.inter(fontSize: 11, color: C.t3)),
              ],
            ),
          ),
          // Added / X / Add button
          if (m.status == 1)
            GestureDetector(
              onTap: onToggle,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                    color: const Color(0xFFFEECE8), borderRadius: BorderRadius.circular(6)),
                child: const Icon(Icons.close_rounded, size: 16, color: C.red),
              ),
            )
          else
            GestureDetector(
              onTap: onToggle,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3EDFF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.add, size: 14, color: C.purple),
                    const SizedBox(width: 4),
                    Text('Add',
                        style: GoogleFonts.inter(
                            fontSize: 12, fontWeight: FontWeight.w600, color: C.purple)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
