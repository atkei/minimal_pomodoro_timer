import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_pomodoro_timer/provider/shared_utility_provider.dart';
import 'package:minimal_pomodoro_timer/provider/theme_provider.dart';
import 'package:minimal_pomodoro_timer/provider/wakelock_provider.dart';
import 'package:minimal_pomodoro_timer/ui/page/timer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:wakelock/wakelock.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorSchemeSeed: Colors.blueAccent,
  brightness: Brightness.light,
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorSchemeSeed: Colors.blueAccent,
  brightness: Brightness.dark,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  tz.initializeTimeZones();

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const PomodoroApp(),
    ),
  );
}

class PomodoroApp extends ConsumerWidget {
  const PomodoroApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkProvider);
    final isWakeLock = ref.watch(isWakeLockProvider);

    if (isWakeLock) {
      Wakelock.enable();
    } else {
      Wakelock.disable();
    }

    return MaterialApp(
      title: 'Minimal Pomodoro Timer',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ja'),
      ],
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: const Scaffold(body: TimerPage()),
    );
  }
}
