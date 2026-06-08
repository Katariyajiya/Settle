import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colors.dart';

/// A reusable "New Group" button with two visual variants.
///
/// Usage — FAB style (Dashboard):
/// ```dart
/// NewGroupButton(variant: NewGroupVariant.fab)
/// ```
///
/// Usage — Inline card (Group Workspace / Group Details):
/// ```dart
/// NewGroupButton(variant: NewGroupVariant.inline)
/// ```
///
/// Both navigate to '/create-group' on tap.
/// Pass [onTap] to override the default navigation behaviour.

enum NewGroupVariant { fab, inline }

class NewGroupButton extends StatelessWidget {
  final NewGroupVariant variant;
  final VoidCallback? onTap;

  const NewGroupButton({
    super.key,
    this.variant = NewGroupVariant.fab,
    this.onTap,
  });

  void _handleTap(BuildContext context) {
    if (onTap != null) {
      onTap!();
    } else {
      Navigator.pushNamed(context, '/create-group');
    }
  }

  @override
  Widget build(BuildContext context) {
    return switch (variant) {
      NewGroupVariant.fab    => _FabButton(onTap: () => _handleTap(context)),
      NewGroupVariant.inline => _InlineCard(onTap: () => _handleTap(context)),
    };
  }
}

// ─── FAB variant ─────────────────────────────────────────────────────────────
// Pill-shaped extended FAB with icon + label. Replaces or sits next to the
// existing add-expense FAB on the DashboardScreen.
//
// Drop-in for Dashboard:
//   floatingActionButton: NewGroupButton(variant: NewGroupVariant.fab)
//
// Or stack with the existing FAB using FloatingActionButtonLocation and a
// Column trick (see code comment below).
class _FabButton extends StatefulWidget {
  final VoidCallback onTap;
  const _FabButton({required this.onTap});
  @override
  State<_FabButton> createState() => _FabButtonState();
}

class _FabButtonState extends State<_FabButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.94,
      upperBound: 1.0,
      value: 1.0,
    );
    _scale = _ctrl;
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onTapDown(_) => _ctrl.reverse();
  void _onTapUp(_) => _ctrl.forward();
  void _onTapCancel() => _ctrl.forward();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: C.red,
            borderRadius: BorderRadius.circular(26),
            boxShadow: [
              BoxShadow(
                color: C.red.withOpacity(0.35),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.22),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.group_add_rounded,
                    size: 16, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Text(
                'New Group',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Inline card variant ──────────────────────────────────────────────────────
// A full-width card row that slots naturally into any scrollable list of groups
// on GroupWorkspaceScreen or a group details screen.
//
// Example use inside a Column/ListView:
//   NewGroupButton(variant: NewGroupVariant.inline)
class _InlineCard extends StatefulWidget {
  final VoidCallback onTap;
  const _InlineCard({required this.onTap});
  @override
  State<_InlineCard> createState() => _InlineCardState();
}

class _InlineCardState extends State<_InlineCard> {
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
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          color: _pressed ? const Color(0xFFFAEDE9) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _pressed ? C.red.withOpacity(0.5) : C.div,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon bubble
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: C.red.withOpacity(0.09),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.group_add_rounded,
                size: 22,
                color: C.red,
              ),
            ),
            const SizedBox(width: 12),

            // Labels
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create New Group',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: C.t1,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Split expenses with friends or family',
                    style: GoogleFonts.inter(fontSize: 12, color: C.t3),
                  ),
                ],
              ),
            ),

            // Arrow
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: C.red.withOpacity(0.09),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward_rounded,
                size: 16,
                color: C.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
