import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colors.dart';

// ─── Bottom Nav ───────────────────────────────────────────────────────────────
class BottomNav extends StatelessWidget {
  final int index;
  final void Function(int) onTap;
  const BottomNav({super.key, required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: C.surface,
        border: Border(top: BorderSide(color: C.div, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              _navItem(0, Icons.home_rounded, 'Home'),
              _navItem(1, Icons.group_rounded, 'Groups'),
              _navItem(2, Icons.wallet_rounded, 'Wallet'),
              _navItem(3, Icons.document_scanner_outlined, 'Scan'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(int i, IconData icon, String label) {
    final sel = i == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(i),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: sel ? C.red : C.t3),
            const SizedBox(height: 3),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: sel ? FontWeight.w600 : FontWeight.w400,
                color: sel ? C.red : C.t3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Settle App Bar Logo ──────────────────────────────────────────────────────
class SettleAppBarLogo extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;
  const SettleAppBarLogo({super.key, this.actions = const []});

  @override
  Size get preferredSize => const Size.fromHeight(52);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: C.surface,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 16,
        right: 8,
      ),
      height: preferredSize.height + MediaQuery.of(context).padding.top,
      child: Row(
        children: [
          // Avatar placeholder
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFFE57373), Color(0xFFBF3B21)],
              ),
            ),
            child: Center(
              child: Text('S',
                  style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Settle',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: C.red,
            ),
          ),
          const Spacer(),
          ...actions,
        ],
      ),
    );
  }
}

// ─── Red Gradient Button ──────────────────────────────────────────────────────
class RedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final Widget? icon;
  final double height;
  const RedButton({super.key, required this.label, this.onTap, this.icon, this.height = 50});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: C.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            if (icon != null) ...[const SizedBox(width: 6), icon!],
          ],
        ),
      ),
    );
  }
}

// ─── Tag Pill ─────────────────────────────────────────────────────────────────
class TagPill extends StatelessWidget {
  final String text;
  final Color bg;
  final Color fg;
  const TagPill(this.text, {super.key, required this.bg, required this.fg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
      child: Text(text,
          style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: fg)),
    );
  }
}

// ─── Section Title Row ────────────────────────────────────────────────────────
class SectionRow extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onAction;
  const SectionRow({super.key, required this.title, this.action, this.onAction});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title,
            style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600, color: C.t1)),
        const Spacer(),
        if (action != null)
          GestureDetector(
            onTap: onAction,
            child: Text(action!,
                style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500, color: C.red)),
          ),
      ],
    );
  }
}

// ─── Outline Input ────────────────────────────────────────────────────────────
class SettleInput extends StatelessWidget {
  final String hint;
  final bool obscure;
  final Widget? suffix;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  const SettleInput({
    super.key,
    required this.hint,
    this.obscure = false,
    this.suffix,
    this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      style: GoogleFonts.inter(fontSize: 14, color: C.t1),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(fontSize: 14, color: C.t3),
        suffixIcon: suffix,
        filled: true,
        fillColor: C.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: C.div),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: C.div),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: C.red, width: 1.5),
        ),
      ),
    );
  }
}

// ─── Avatar Circle ────────────────────────────────────────────────────────────
class AvatarCircle extends StatelessWidget {
  final String label;
  final Color color;
  final double size;
  const AvatarCircle({super.key, required this.label, required this.color, this.size = 32});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: size * 0.38,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
