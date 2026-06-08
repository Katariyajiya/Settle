import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:settle_fe/screens/dashboard_screen.dart';
import '../theme/colors.dart';
import '../widgets/common.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  bool _isSignIn = true;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  late final AnimationController _animCtrl;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 220));
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeInOut);
    _animCtrl.forward();
  }

  void _switchTab(bool signIn) {
    if (_isSignIn == signIn) return;
    _animCtrl.reverse().then((_) {
      setState(() => _isSignIn = signIn);
      _animCtrl.forward();
    });
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 36),

              // ── Logo ──────────────────────────────────────────────────────
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: C.red,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: const Icon(Icons.account_balance_rounded, color: Colors.white, size: 32),
              ),
              const SizedBox(height: 12),
              Text(
                'Settle',
                style: GoogleFonts.inter(fontSize: 27, fontWeight: FontWeight.w700, color: C.red),
              ),
              const SizedBox(height: 4),
              Text(
                'Modern finance, human approach.',
                style: GoogleFonts.inter(fontSize: 13, color: C.t3),
              ),
              const SizedBox(height: 28),

              // ── Toggle tabs ───────────────────────────────────────────────
              Container(
                height: 44,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: C.surfaceGrey,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: C.div),
                ),
                child: Row(
                  children: [
                    _Tab(
                      label: 'Sign In',
                      active: _isSignIn,
                      onTap: () => _switchTab(true),
                    ),
                    _Tab(
                      label: 'Create Account',
                      active: !_isSignIn,
                      onTap: () => _switchTab(false),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ── Animated form card ────────────────────────────────────────
              FadeTransition(
                opacity: _fadeAnim,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: C.surface,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: _isSignIn ? _SignInForm(
                    obscurePassword: _obscurePassword,
                    onToggleObscure: () => setState(() => _obscurePassword = !_obscurePassword),
                  ) : _CreateAccountForm(
                    obscurePassword: _obscurePassword,
                    obscureConfirm: _obscureConfirm,
                    onTogglePassword: () => setState(() => _obscurePassword = !_obscurePassword),
                    onToggleConfirm: () => setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ── OR divider ────────────────────────────────────────────────
              Row(
                children: [
                  const Expanded(child: Divider(color: C.div)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text('OR', style: GoogleFonts.inter(fontSize: 12, color: C.t3)),
                  ),
                  const Expanded(child: Divider(color: C.div)),
                ],
              ),
              const SizedBox(height: 16),

              // ── Social buttons ────────────────────────────────────────────
              Row(
                children: [
                  Expanded(child: _SocialBtn(label: 'Google', icon: Icons.g_mobiledata, onTap: () {})),
                  const SizedBox(width: 10),
                  Expanded(child: _SocialBtn(label: 'Apple', icon: Icons.apple, onTap: () {})),
                ],
              ),
              const SizedBox(height: 24),

              // ── Terms ─────────────────────────────────────────────────────
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.inter(fontSize: 11, color: C.t3, height: 1.65),
                  children: [
                    const TextSpan(text: 'By continuing, you agree to our '),
                    TextSpan(
                      text: 'Terms of Service',
                      style: const TextStyle(
                        color: C.red,
                        decoration: TextDecoration.underline,
                        decorationColor: C.red,
                      ),
                    ),
                    const TextSpan(text: ' and\n'),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: const TextStyle(
                        color: C.red,
                        decoration: TextDecoration.underline,
                        decorationColor: C.red,
                      ),
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
              ),
              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Sign In Form ─────────────────────────────────────────────────────────────
class _SignInForm extends StatelessWidget {
  final bool obscurePassword;
  final VoidCallback onToggleObscure;

  const _SignInForm({
    required this.obscurePassword,
    required this.onToggleObscure,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome Back',
          style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700, color: C.t1),
        ),
        const SizedBox(height: 4),
        Text(
          'Enter your credentials to access\nyour vault.',
          style: GoogleFonts.inter(fontSize: 13, color: C.t2, height: 1.5),
        ),
        const SizedBox(height: 22),
        SettleInput(
          hint: 'Email Address',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 12),
        SettleInput(
          hint: 'Password',
          obscure: obscurePassword,
          suffix: IconButton(
            icon: Icon(
              obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              size: 18,
              color: C.t3,
            ),
            onPressed: onToggleObscure,
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {},
            child: Text(
              'Forgot Password?',
              style: GoogleFonts.inter(fontSize: 12, color: C.red, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(height: 22),
        RedButton(
          label: 'Continue',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          )
        ),
      ],
    );
  }
}

// ─── Create Account Form ──────────────────────────────────────────────────────
class _CreateAccountForm extends StatelessWidget {
  final bool obscurePassword;
  final bool obscureConfirm;
  final VoidCallback onTogglePassword;
  final VoidCallback onToggleConfirm;

  const _CreateAccountForm({
    required this.obscurePassword,
    required this.obscureConfirm,
    required this.onTogglePassword,
    required this.onToggleConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create Account',
          style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700, color: C.t1),
        ),
        const SizedBox(height: 4),
        Text(
          'Join Settle and manage your finances\nthe smart way.',
          style: GoogleFonts.inter(fontSize: 13, color: C.t2, height: 1.5),
        ),
        const SizedBox(height: 22),

        // Full Name
        SettleInput(
          hint: 'Full Name',
          keyboardType: TextInputType.name,
        ),
        const SizedBox(height: 12),

        // Email
        SettleInput(
          hint: 'Email Address',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 12),

        // Phone (optional)
        SettleInput(
          hint: 'Phone Number (optional)',
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 12),

        // Password
        SettleInput(
          hint: 'Password',
          obscure: obscurePassword,
          suffix: IconButton(
            icon: Icon(
              obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              size: 18,
              color: C.t3,
            ),
            onPressed: onTogglePassword,
          ),
        ),
        const SizedBox(height: 12),

        // Confirm Password
        SettleInput(
          hint: 'Confirm Password',
          obscure: obscureConfirm,
          suffix: IconButton(
            icon: Icon(
              obscureConfirm ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              size: 18,
              color: C.t3,
            ),
            onPressed: onToggleConfirm,
          ),
        ),
        const SizedBox(height: 22),

        RedButton(
          label: 'Create Account',
          onTap: () => Navigator.pushReplacementNamed(context, '/dashboard'),
        ),
      ],
    );
  }
}

// ─── Tab Button ───────────────────────────────────────────────────────────────
class _Tab extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _Tab({required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? C.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
            boxShadow: active
                ? [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6, offset: const Offset(0, 2))]
                : null,
          ),
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: active ? C.red : C.t3,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Social Button ────────────────────────────────────────────────────────────
class _SocialBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _SocialBtn({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
            Icon(icon, size: 20, color: C.t1),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500, color: C.t1),
            ),
          ],
        ),
      ),
    );
  }
}