import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool glowMode = true;
  double energy = 64;
  int launchCount = 0;
  int selectedPanel = 0;
  bool scanMode = true;

  final List<Color> accentColors = const [
    Color(0xFF78F0FF),
    Color(0xFFFFD166),
    Color(0xFFFF6B9A),
  ];

  @override
  Widget build(BuildContext context) {
    final accent = accentColors[selectedPanel];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Demo Lab',
          style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: -0.2),
        ),
        actions: [
          IconButton(
            tooltip: 'Reset',
            onPressed: () {
              setState(() {
                glowMode = true;
                energy = 64;
                launchCount = 0;
                selectedPanel = 0;
                scanMode = true;
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: accent,
        foregroundColor: const Color(0xFF07111F),
        onPressed: () {
          setState(() => launchCount++);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Launch sequence $launchCount activated'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        icon: const Icon(Icons.rocket_launch),
        label: Text('$launchCount'),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.lerp(const Color(0xFF050B14), accent, 0.16)!,
              const Color(0xFF050B14),
              const Color(0xFF0A1322),
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 110),
            children: [
              _HeroPanel(
                accent: accent,
                glowMode: glowMode,
                energy: energy,
                scanMode: scanMode,
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: _ActionButton(
                      accent: accent,
                      icon: Icons.waving_hand,
                      label: 'Greet',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Hello, welcome to the future UI'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ActionButton(
                      accent: accent,
                      icon: Icons.mark_email_read,
                      label: 'Send',
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Success'),
                              content: const Text(
                                'Your futuristic email was sent.',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _ControlPanel(
                accent: accent,
                glowMode: glowMode,
                energy: energy,
                scanMode: scanMode,
                selectedPanel: selectedPanel,
                colors: accentColors,
                onGlowChanged: (value) => setState(() => glowMode = value),
                onEnergyChanged: (value) => setState(() => energy = value),
                onScanChanged: (value) => setState(() => scanMode = value),
                onPanelChanged: (index) =>
                    setState(() => selectedPanel = index),
              ),
              const SizedBox(height: 18),
              _ImageShowcase(accent: accent),
              const SizedBox(height: 18),
              _FeatureGrid(accent: accent),
              const SizedBox(height: 18),
              _HoloScanCard(
                accent: accent,
                scanMode: scanMode,
                onTap: () => setState(() => scanMode = !scanMode),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroPanel extends StatelessWidget {
  const _HeroPanel({
    required this.accent,
    required this.glowMode,
    required this.energy,
    required this.scanMode,
  });

  final Color accent;
  final bool glowMode;
  final double energy;
  final bool scanMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: accent.withValues(alpha: 0.34)),
        boxShadow: glowMode
            ? [
                BoxShadow(color: accent.withValues(alpha: 0.18), blurRadius: 34, offset: const Offset(0, 16)),
              ]
            : null,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF111C30), Color(0xFF08101B)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.flutter_dash, color: accent, size: 58),
              const Spacer(),
              _StatusPill(
                accent: accent,
                label: scanMode ? 'SCAN ACTIVE' : 'SCAN IDLE',
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'Command the interface with precision.',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              height: 1.05,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'This version introduces a holographic scan mode, refined glass panels, and calmer motion so the UI reads premium instead of generated.',
            style: TextStyle(
              color: Color(0xFFB7C6D8),
              fontSize: 15.5,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _MiniStat(
                  accent: accent,
                  label: 'Energy',
                  value: '${energy.round()}%',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MiniStat(
                  accent: accent,
                  label: 'Mode',
                  value: glowMode ? 'Glow' : 'Stealth',
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: energy / 100,
              minHeight: 12,
              backgroundColor: Colors.white.withValues(alpha: 0.08),
              color: accent,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.accent,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final Color accent;
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      style: FilledButton.styleFrom(
        backgroundColor: accent,
        foregroundColor: const Color(0xFF050B14),
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(fontWeight: FontWeight.w800),
      ),
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}

class _ControlPanel extends StatelessWidget {
  const _ControlPanel({
    required this.accent,
    required this.glowMode,
    required this.energy,
    required this.scanMode,
    required this.selectedPanel,
    required this.colors,
    required this.onGlowChanged,
    required this.onEnergyChanged,
    required this.onScanChanged,
    required this.onPanelChanged,
  });

  final Color accent;
  final bool glowMode;
  final double energy;
  final bool scanMode;
  final int selectedPanel;
  final List<Color> colors;
  final ValueChanged<bool> onGlowChanged;
  final ValueChanged<double> onEnergyChanged;
  final ValueChanged<bool> onScanChanged;
  final ValueChanged<int> onPanelChanged;

  @override
  Widget build(BuildContext context) {
    return _GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Control Center',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 14),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: glowMode,
            activeThumbColor: accent,
            title: const Text('Glow mode'),
            subtitle: const Text('Adds a controlled neon bloom'),
            onChanged: onGlowChanged,
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: scanMode,
            activeThumbColor: accent,
            title: const Text('Holo scan'),
            subtitle: const Text('Activates the premium scan overlay'),
            onChanged: onScanChanged,
          ),
          const SizedBox(height: 8),
          Text('Energy ${energy.round()}%'),
          Slider(
            value: energy,
            min: 0,
            max: 100,
            activeColor: accent,
            onChanged: onEnergyChanged,
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(colors.length, (index) {
              final selected = selectedPanel == index;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () => onPanelChanged(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: selected ? 54 : 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: colors[index],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: selected ? Colors.white : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _ImageShowcase extends StatelessWidget {
  const _ImageShowcase({required this.accent});

  final Color accent;

  @override
  Widget build(BuildContext context) {
    return _GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Gallery',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _AssetCard(
                  accent: accent,
                  asset: 'assets/project 8.png',
                  label: 'Project 8',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _AssetCard(
                  accent: accent,
                  asset: 'assets/project 9.png',
                  label: 'Project 9',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HoloScanCard extends StatelessWidget {
  const _HoloScanCard({
    required this.accent,
    required this.scanMode,
    required this.onTap,
  });

  final Color accent;
  final bool scanMode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: accent.withValues(alpha: 0.24)),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF101A2E), Color(0xFF08101B)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.radar, color: Color(0xFFB4FBFF)),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Holographic Scan',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                ),
                _StatusPill(
                  accent: accent,
                  label: scanMode ? 'ACTIVE' : 'PAUSED',
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Text(
              'Tap to switch the scan field and reveal a cleaner, more cinematic visual state.',
              style: TextStyle(color: Color(0xFFB7C6D8), height: 1.45),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 108,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _RadarPainter(accent: accent, scanMode: scanMode),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: accent.withValues(alpha: 0.1),
                        border: Border.all(color: accent.withValues(alpha: 0.5)),
                      ),
                      child: Icon(
                        scanMode ? Icons.wifi_tethering : Icons.pause_circle,
                        color: accent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.accent, required this.label});

  final Color accent;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: accent.withValues(alpha: 0.18)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: accent,
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.9,
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({
    required this.accent,
    required this.label,
    required this.value,
  });

  final Color accent;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF9FB1C8), fontSize: 12)),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: accent,
              fontSize: 18,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _RadarPainter extends CustomPainter {
  _RadarPainter({required this.accent, required this.scanMode});

  final Color accent;
  final bool scanMode;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final linePaint = Paint()
      ..color = accent.withValues(alpha: scanMode ? 0.18 : 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (final radius in [18.0, 34.0, 50.0]) {
      canvas.drawCircle(center, radius, linePaint);
    }

    canvas.drawLine(
      Offset(center.dx - 54, center.dy),
      Offset(center.dx + 54, center.dy),
      linePaint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - 34),
      Offset(center.dx, center.dy + 34),
      linePaint,
    );

    final sweepPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          accent.withValues(alpha: 0.45),
          accent.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: 56));
    canvas.drawCircle(center, scanMode ? 56 : 40, sweepPaint);
  }

  @override
  bool shouldRepaint(covariant _RadarPainter oldDelegate) {
    return oldDelegate.scanMode != scanMode || oldDelegate.accent != accent;
  }
}

class _AssetCard extends StatelessWidget {
  const _AssetCard({
    required this.accent,
    required this.asset,
    required this.label,
  });

  final Color accent;
  final String asset;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Image.asset(asset, fit: BoxFit.cover),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            color: const Color(0xFF050B14).withValues(alpha: 0.72),
            child: Text(
              label,
              style: TextStyle(color: accent, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureGrid extends StatelessWidget {
  const _FeatureGrid({required this.accent});

  final Color accent;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.35,
      children: [
        _FeatureTile(accent: accent, icon: Icons.security, title: 'Secure'),
        _FeatureTile(accent: accent, icon: Icons.speed, title: 'Fast'),
        _FeatureTile(accent: accent, icon: Icons.devices, title: 'Responsive'),
        _FeatureTile(
          accent: accent,
          icon: Icons.auto_awesome,
          title: 'Premium',
        ),
      ],
    );
  }
}

class _FeatureTile extends StatelessWidget {
  const _FeatureTile({
    required this.accent,
    required this.icon,
    required this.title,
  });

  final Color accent;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return _GlassPanel(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: accent, size: 32),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _GlassPanel extends StatelessWidget {
  const _GlassPanel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: child,
    );
  }
}
