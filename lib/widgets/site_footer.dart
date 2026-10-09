import 'package:flutter/material.dart';

class SiteFooter extends StatelessWidget {
  const SiteFooter({
    super.key,
    required this.onViewProjects,
    required this.onBackToTop,
  });

  final VoidCallback onViewProjects;
  final VoidCallback onBackToTop;

  static const _accent = Color(0xFF2FD0DE);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0B0E12),
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: .08)),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 760;
          final horizontalPadding = compact ? 24.0 : 48.0;

          final introduction = ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 610),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '< JN />',
                  style: TextStyle(
                    color: _accent,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: .4,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Let\'s build something useful.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: compact ? 32 : 42,
                    height: 1.05,
                    letterSpacing: -1.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Flutter developer creating focused mobile and desktop products with clean architecture and thoughtful interactions.',
                  style: TextStyle(
                    color: Color(0xFF919AA2),
                    fontSize: 16,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 22),
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _AvailabilityDot(),
                    SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        'Available for new opportunities',
                        style: TextStyle(
                          color: Color(0xFFB8C0C5),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                const Wrap(
                  spacing: 16,
                  runSpacing: 10,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.email,
                          color: Color(0xFF69737A),
                          size: 15,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Joshua.Nelson2005@gmail.com',
                          style: TextStyle(
                            color: Color(0xFF69737A),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.phone,
                          color: Color(0xFF69737A),
                          size: 15,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '502-235-1803',
                          style: TextStyle(
                            color: Color(0xFF69737A),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          );

          final actions = Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ElevatedButton.icon(
                onPressed: onViewProjects,
                icon: const Icon(Icons.arrow_forward, size: 18),
                label: const Text('View projects'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(154, 48),
                  backgroundColor: _accent,
                  foregroundColor: const Color(0xFF071013),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  textStyle: const TextStyle(fontWeight: FontWeight.w800),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              OutlinedButton.icon(
                onPressed: onBackToTop,
                icon: const Icon(Icons.arrow_upward, size: 18),
                label: const Text('Back to top'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(146, 48),
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFF354047)),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  textStyle: const TextStyle(fontWeight: FontWeight.w700),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          );

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1160),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  compact ? 56 : 76,
                  horizontalPadding,
                  28,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (compact) ...[
                      introduction,
                      const SizedBox(height: 36),
                      actions,
                    ] else
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(child: introduction),
                          const SizedBox(width: 64),
                          actions,
                        ],
                      ),
                    const SizedBox(height: 20),
                    Divider(color: Colors.white.withValues(alpha: .08)),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 24,
                      runSpacing: 10,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        Text(
                          '© ${DateTime.now().year} Joshua Nelson',
                          style: const TextStyle(
                            color: Color(0xFF69737A),
                            fontSize: 13,
                          ),
                        ),
                        const Text(
                          'Built with Flutter · Designed with intention',
                          style: TextStyle(
                            color: Color(0xFF69737A),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AvailabilityDot extends StatelessWidget {
  const _AvailabilityDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: const BoxDecoration(
        color: Color(0xFF45D483),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Color(0x6645D483), blurRadius: 10),
        ],
      ),
    );
  }
}
