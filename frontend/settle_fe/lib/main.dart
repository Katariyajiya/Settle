import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/colors.dart';
import 'screens/onboarding_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/create_group_screen.dart';
import 'screens/group_workspace_screen.dart';
import 'screens/add_expense_screen.dart';
import 'screens/ai_scanner_screen.dart';
import 'screens/smart_settle_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const SettleApp());
}

class SettleApp extends StatelessWidget {
  const SettleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: C.bg,
        colorScheme: ColorScheme.fromSeed(seedColor: C.red),
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          backgroundColor: C.surface,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const OnboardingScreen(),
        '/welcome': (_) => const WelcomeScreen(),
        '/dashboard': (_) => const DashboardScreen(),
        '/create-group': (_) => const CreateGroupScreen(),
        '/group-workspace': (_) => const GroupWorkspaceScreen(),
        '/add-expense': (_) => const AddExpenseScreen(),
        '/ai-scanner': (_) => const AIBillScannerScreen(),
        '/smart-settle': (_) => const SmartSettleScreen(),
      },

    );
  }
}
