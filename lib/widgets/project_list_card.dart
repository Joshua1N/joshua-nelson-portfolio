import 'package:flutter/material.dart';

import '../models/portfolio_project.dart';

class ProjectListCard extends StatefulWidget {
  const ProjectListCard({
    super.key,
    required this.project,
    required this.onPressed,
  });

  final PortfolioProject project;
  final VoidCallback onPressed;

  @override
  State<ProjectListCard> createState() => _ProjectListCardState();
}

class _ProjectListCardState extends State<ProjectListCard> {
  bool _hovered = false;

  void _setHovered(bool value) {
    if (_hovered == value) return;
    setState(() => _hovered = value);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      opaque: true,
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _setHovered(true),
      onExit: (_) => _setHovered(false),
      child: Semantics(
        button: true,
        label: 'Open ${widget.project.appName} project',
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            constraints: const BoxConstraints(minHeight: 148),
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: _hovered
                  ? const Color(0xFF1B2228)
                  : const Color(0xFF181D22),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _hovered
                    ? const Color(0xFF36535A)
                    : const Color(0xFF343B41),
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxWidth < 680;
                final screenshotPath = widget.project.screenshots.isEmpty
                    ? null
                    : widget.project.screenshots.first;
                final details = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFF112C31),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFF28545B)),
                          ),
                          child: Text(
                            widget.project.appName
                                .split(' ')
                                .map((word) => word[0])
                                .take(2)
                                .join(),
                            style: const TextStyle(
                              color: Color(0xFF2FD0DE),
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.project.appName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                widget.project.slogan,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xFFA2AAB0),
                                  fontSize: 14,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Icon(
                          Icons.arrow_forward,
                          color: Color(0xFF2FD0DE),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.project.skills
                          .map((technology) => _ProjectChip(technology))
                          .toList(),
                    ),
                  ],
                );

                final preview = Container(
                  width: compact ? double.infinity : 132,
                  height: compact ? 140 : 100,
                  margin: EdgeInsets.only(
                    left: compact ? 0 : 28,
                    top: compact ? 16 : 0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: const Color(0xFF10171B),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFF28353B)),
                  ),
                  child: RepaintBoundary(
                    child: _MiniPreview(assetPath: screenshotPath),
                  ),
                );

                if (compact) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [details, preview],
                  );
                }
                return Row(
                  children: [
                    Expanded(child: details),
                    preview,
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectChip extends StatelessWidget {
  const _ProjectChip(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF23292F),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Color(0xFFD0D5D8), fontSize: 12),
      ),
    );
  }
}

class _MiniPreview extends StatelessWidget {
  const _MiniPreview({required this.assetPath});
  final String? assetPath;

  @override
  Widget build(BuildContext context) {
    if (assetPath != null) {
      return Image.asset(
        assetPath!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const _MiniPlaceholder(),
      );
    }
    return const _MiniPlaceholder();
  }
}

class _MiniPlaceholder extends StatelessWidget {
  const _MiniPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 58,
          height: 8,
          decoration: BoxDecoration(
            color: const Color(0xFF2FD0DE),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        const SizedBox(height: 11),
        Container(height: 7, color: const Color(0xFF344047)),
        const SizedBox(height: 8),
        Container(height: 7, width: 92, color: const Color(0xFF29343A)),
        const Spacer(),
        Row(
          children: List.generate(
            3,
            (index) => Container(
              width: 22,
              height: 18,
              margin: const EdgeInsets.only(right: 7),
              decoration: BoxDecoration(
                color: index == 0
                    ? const Color(0xFF17343A)
                    : const Color(0xFF202A30),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
