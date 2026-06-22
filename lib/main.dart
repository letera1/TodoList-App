import 'package:flutter/material.dart';

import 'demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Future Lab',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF73F3FF),
          brightness: Brightness.dark,
          surface: const Color(0xFF0B1426),
        ),
        scaffoldBackgroundColor: const Color(0xFF050B14),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.45,
            colors: [Color(0xFF0B1A31), Color(0xFF07111F), Color(0xFF050B14)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withValues(alpha: 0.18),
                            Colors.white.withValues(alpha: 0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: const Color(0xFF73F3FF).withValues(alpha: 0.18),
                        ),
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: Color(0xFFB4FBFF),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Future Lab',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.4,
                          ),
                        ),
                        Text(
                          'Premium futuristic interface',
                          style: TextStyle(color: Color(0xFF9FB1C8)),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.07),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.09),
                        ),
                      ),
                      child: const Text(
                        'LIVE SYSTEM',
                        style: TextStyle(
                          color: Color(0xFFB4FBFF),
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(32),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DemoPage(),
                        ),
                      );
                    },
                    child: Ink(
                      width: double.infinity,
                      padding: const EdgeInsets.all(26),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: const Color(0xFF73F3FF).withValues(alpha: 0.24),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4DD8FF).withValues(alpha: 0.12),
                            blurRadius: 46,
                            offset: const Offset(0, 22),
                          ),
                        ],
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF111D33), Color(0xFF08101C)],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 13,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF73F3FF).withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: const Text(
                              'LIVE DEMO',
                              style: TextStyle(
                                color: Color(0xFFB4FBFF),
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                                fontSize: 11,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Body Content',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w900,
                              height: 0.98,
                              letterSpacing: -1,
                            ),
                          ),
                          const SizedBox(height: 14),
                          const Text(
                            'Open a premium control surface with tactile cards, glow effects, and a new holographic scan panel.',
                            style: TextStyle(
                              color: Color(0xFFB7C6D8),
                              fontSize: 15.5,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 22),
                          Row(
                            children: [
                              FilledButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const DemoPage(),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.rocket_launch),
                                label: const Text('Open Demo'),
                              ),
                              const SizedBox(width: 12),
                              const Icon(
                                Icons.touch_app,
                                color: Color(0xFFB4FBFF),
                              ),
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Row(
                  children: [
                    _StatTile(icon: Icons.speed, label: 'Latency', value: '12ms'),
                    SizedBox(width: 12),
                    _StatTile(icon: Icons.shield, label: 'Mode', value: 'Safe'),
                    SizedBox(width: 12),
                    _StatTile(icon: Icons.bolt, label: 'Power', value: 'Ultra'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFFB4FBFF)),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16,
                letterSpacing: -0.2,
              ),
            ),
            Text(
              label,
              style: const TextStyle(color: Color(0xFF9FB1C8), fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
