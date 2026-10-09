import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart';

import '../models/portfolio_project.dart';
import '../widgets/site_footer.dart';

class ProjectDetailPage extends StatefulWidget {
  const ProjectDetailPage({super.key, required this.project});

  final PortfolioProject project;

  static const _background = Color(0xFF0E1115);
  static const _surface = Color(0xFF181D22);
  static const _accent = Color(0xFF2FD0DE);

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectDetailPage._background,
      body: Stack(
        children: [
          const Positioned.fill(child: _GridBackground()),
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: ProjectDetailPage._background.withValues(alpha: .94),
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                toolbarHeight: 76,
                leadingWidth: 92,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: IconButton(
                    tooltip: 'Back to projects',
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back, color: Colors.white70),
                  ),
                ),
                title: const Text(
                  '< JN />',
                  style: TextStyle(
                    color: ProjectDetailPage._accent,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(1),
                  child: Container(
                    height: 1,
                    color: Colors.white.withValues(alpha: .08),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1160),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 64, 24, 52),
                      child: _ProjectHero(project: widget.project),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1160),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 84),
                      child: _ScreenshotGallery(project: widget.project),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: ProjectDetailPage._background.withValues(alpha: .96),
                    border: Border(
                      top: BorderSide(
                        color: Colors.white.withValues(alpha: .08),
                      ),
                    ),
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1160),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 72, 24, 96),
                        child: _ProjectSummary(project: widget.project),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SiteFooter(
                  onViewProjects: () => Navigator.of(context).pop(),
                  onBackToTop: _scrollToTop,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProjectHero extends StatelessWidget {
  const _ProjectHero({required this.project});
  final PortfolioProject project;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 700;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 780),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: compact ? 68 : 82,
                  height: compact ? 68 : 82,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF20464E), Color(0xFF101E22)],
                    ),
                    borderRadius: BorderRadius.circular(compact ? 19 : 22),
                    border: Border.all(color: const Color(0xFF2B5962)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x55000000),
                        blurRadius: 36,
                        offset: Offset(0, 16),
                      ),
                    ],
                  ),
                  child: Text(
                    project.appName
                        .split(' ')
                        .map((word) => word[0])
                        .take(2)
                        .join(),
                    style: TextStyle(
                      color: ProjectDetailPage._accent,
                      fontSize: compact ? 21 : 26,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(width: 22),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${project.isDesktop ? 'DESKTOP APP' : 'MOBILE APP'} · ${project.year}',
                        style: const TextStyle(
                          color: ProjectDetailPage._accent,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.7,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        project.appName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: compact ? 45 : 68,
                          height: .95,
                          letterSpacing: -3,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            Text(
              project.slogan,
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: compact ? 18 : 21,
                height: 1.55,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScreenshotGallery extends StatefulWidget {
  const _ScreenshotGallery({required this.project});
  final PortfolioProject project;

  @override
  State<_ScreenshotGallery> createState() => _ScreenshotGalleryState();
}

class _ScreenshotGalleryState extends State<_ScreenshotGallery> {
  final ScrollController _mobileScrollController = ScrollController();
  final PageController _desktopPageController = PageController();

  @override
  void dispose() {
    _mobileScrollController.dispose();
    _desktopPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = widget.project.previewHeadlines.length;

    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 700;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '// APP PREVIEW',
              style: TextStyle(
                color: ProjectDetailPage._accent,
                fontSize: 13,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.8,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.project.isDesktop
                        ? 'Explore the desktop experience'
                        : 'Swipe through the experience',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 29,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -1,
                    ),
                  ),
                ),
                if (!compact)
                  Text(
                    widget.project.isDesktop
                        ? 'One screen at a time →'
                        : 'Drag or scroll to explore →',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            if (widget.project.isDesktop)
              _buildDesktopGallery(
                itemCount: itemCount,
                height: compact ? 360 : 700,
              )
            else
              _buildMobileGallery(
                itemCount: itemCount,
                cardWidth: compact ? constraints.maxWidth * .82 : 300,
              ),
          ],
        );
      },
    );
  }

  Widget _buildDesktopGallery({
    required int itemCount,
    required double height,
  }) {
    return SizedBox(
      height: height,
      child: ScrollConfiguration(
        behavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.stylus,
            PointerDeviceKind.trackpad,
          },
        ),
        child: Scrollbar(
          controller: _desktopPageController,
          thumbVisibility: true,
          trackVisibility: true,
          scrollbarOrientation: ScrollbarOrientation.bottom,
          thickness: 8,
          radius: const Radius.circular(10),
          interactive: true,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: PageView.builder(
              controller: _desktopPageController,
              physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
              padEnds: false,
              itemCount: itemCount,
              itemBuilder: (context, index) {
                final assetPath = index < widget.project.screenshots.length
                    ? widget.project.screenshots[index]
                    : null;
                return _DesktopPreviewSlide(
                  headline: widget.project.previewHeadlines[index],
                  assetPath: assetPath,
                  index: index,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileGallery({
    required int itemCount,
    required double cardWidth,
  }) {
    return SizedBox(
      height: 648,
      child: ScrollConfiguration(
        behavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.stylus,
            PointerDeviceKind.trackpad,
          },
        ),
        child: Scrollbar(
          controller: _mobileScrollController,
          thumbVisibility: true,
          trackVisibility: true,
          scrollbarOrientation: ScrollbarOrientation.bottom,
          thickness: 8,
          radius: const Radius.circular(10),
          interactive: true,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ListView.separated(
              controller: _mobileScrollController,
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              itemCount: itemCount,
              separatorBuilder: (_, __) => const SizedBox(width: 18),
              itemBuilder: (context, index) {
                final assetPath = index < widget.project.screenshots.length
                    ? widget.project.screenshots[index]
                    : null;
                return SizedBox(
                  width: cardWidth,
                  child: _MobilePreviewCard(
                    headline: widget.project.previewHeadlines[index],
                    assetPath: assetPath,
                    index: index,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _DesktopPreviewSlide extends StatelessWidget {
  const _DesktopPreviewSlide({
    required this.headline,
    required this.assetPath,
    required this.index,
  });

  final String headline;
  final String? assetPath;
  final int index;

  @override
  Widget build(BuildContext context) {
    final alternate = index.isOdd;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Center(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: alternate
                        ? const [Color(0xFF222A30), Color(0xFF11191E)]
                        : const [Color(0xFF173139), Color(0xFF10181D)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFF30434A)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x66000000),
                      blurRadius: 34,
                      offset: Offset(0, 16),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 18, 22, 10),
                      child: Text(
                        headline,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          height: 1.08,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: assetPath == null
                              ? _DesktopPlaceholder(index: index)
                              : Image.asset(
                                  assetPath!,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, __, ___) =>
                                      _DesktopPlaceholder(index: index),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DesktopPlaceholder extends StatelessWidget {
  const _DesktopPlaceholder({required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0C1216),
      padding: const EdgeInsets.all(26),
      child: Row(
        children: [
          Container(
            width: 92,
            decoration: BoxDecoration(
              color: const Color(0xFF121A1F),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xFF14262B),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF24474E)),
                  ),
                ),
                const SizedBox(height: 14),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: index.isEven ? 3 : 2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF121A1F),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        flex: index.isEven ? 2 : 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF121A1F),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MobilePreviewCard extends StatelessWidget {
  const _MobilePreviewCard({
    required this.headline,
    required this.assetPath,
    required this.index,
  });

  final String headline;
  final String? assetPath;
  final int index;

  @override
  Widget build(BuildContext context) {
    final alternate = index.isOdd;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: alternate
              ? const [Color(0xFF222A30), Color(0xFF11191E)]
              : const [Color(0xFF173139), Color(0xFF10181D)],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF30434A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(26, 30, 26, 22),
            child: Text(
              headline,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                height: 1.08,
                fontWeight: FontWeight.w800,
                letterSpacing: -1,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: 232,
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF657179), Color(0xFF252D32)],
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(38),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x77000000),
                      blurRadius: 44,
                      offset: Offset(0, 22),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                  child: assetPath == null
                      ? _PlaceholderScreen(index: index)
                      : Image.asset(
                          assetPath!,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          errorBuilder: (_, __, ___) =>
                              _PlaceholderScreen(index: index),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D1418),
      padding: const EdgeInsets.fromLTRB(18, 22, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 72,
              height: 18,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 36),
          Container(
            width: 76,
            height: 7,
            decoration: BoxDecoration(
              color: const Color(0xFF65737B),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 150,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 148,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF12272C),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFF28515A)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 68, height: 7, color: const Color(0xFF6F7C82)),
                const Spacer(),
                Text(
                  index == 1 ? '74%' : '24:18',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const LinearProgressIndicator(
                    value: .68,
                    minHeight: 5,
                    color: ProjectDetailPage._accent,
                    backgroundColor: Color(0xFF2A393E),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: Column(
              children: List.generate(
                3,
                (itemIndex) => Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: itemIndex == 2 ? 0 : 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF131C21),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF263238)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectSummary extends StatelessWidget {
  const _ProjectSummary({required this.project});
  final PortfolioProject project;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 760;
    final about = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '// ABOUT THE PROJECT',
          style: TextStyle(
            color: ProjectDetailPage._accent,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.7,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          project.slogan,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 34,
            height: 1.08,
            fontWeight: FontWeight.w700,
            letterSpacing: -1.3,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          project.description,
          style: const TextStyle(
            color: Color(0xFFA5AEB5),
            fontSize: 16,
            height: 1.75,
          ),
        ),
      ],
    );
    final stack = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '// BUILT WITH',
          style: TextStyle(
            color: ProjectDetailPage._accent,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.7,
          ),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 9,
          runSpacing: 9,
          children: project.skills
              .map(
                (technology) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: ProjectDetailPage._surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF2D383F)),
                  ),
                  child: Text(
                    technology,
                    style: const TextStyle(
                      color: Color(0xFFD3D8DB),
                      fontSize: 13,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );

    if (compact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [about, const SizedBox(height: 52), stack],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 6, child: about),
        const SizedBox(width: 90),
        Expanded(flex: 4, child: stack),
      ],
    );
  }
}

class _GridBackground extends StatelessWidget {
  const _GridBackground();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _GridPainter());
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const spacing = 72.0;
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: .025)
      ..strokeWidth = 1;
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
