import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/portfolio_projects.dart';
import '../pages/project_detail.dart';
import '../widgets/project_list_card.dart';
import '../widgets/site_footer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final PageController _projectsPageController = PageController();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _techKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _footerKey = GlobalKey();
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final isScrolled =
        _scrollController.hasClients && _scrollController.offset > 0;
    if (isScrolled != _scrolled) {
      setState(() {
        _scrolled = isScrolled;
      });
    }
  }

  void _scrollToProjects() {
    _scrollToSection(_projectsKey);
  }

  void _scrollToSection(GlobalKey sectionKey) {
    final sectionContext = sectionKey.currentContext;
    if (sectionContext == null) return;

    Scrollable.ensureVisible(
      sectionContext,
      alignment: 0.12,
      duration: const Duration(milliseconds: 550),
      curve: Curves.easeInOutCubic,
    );
  }

  void _scrollToFooter() {
    final footerContext = _footerKey.currentContext;
    if (footerContext == null) return;

    Scrollable.ensureVisible(
      footerContext,
      alignment: 0.12,
      duration: const Duration(milliseconds: 550),
      curve: Curves.easeInOutCubic,
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _projectsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewportSize = MediaQuery.sizeOf(context);
    final isMobile = viewportSize.width < 700;
    final sectionPadding = isMobile ? 20.0 : 48.0;
    final sectionGap = isMobile ? 96.0 : 200.0;
    final navPadding = viewportSize.width >= 1500
        ? 500.0
        : (isMobile ? 16.0 : 48.0);
    final projectsPerPage = isMobile ? 1 : 3;
    final projectPageCount =
        (portfolioProjects.length + projectsPerPage - 1) ~/ projectsPerPage;

    return Scaffold(
      backgroundColor: const Color(0xFF0e1115), // Dark blue
      body: Stack(
        children: [
          // Scrollable content overlay
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Landing section with grid background
                SizedBox(
                  height: isMobile && viewportSize.height < 940
                      ? 940
                      : viewportSize.height,
                  child: Stack(
                    children: [
                      // Grid background
                      Positioned.fill(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            const minSquareSize = 70.0;
                            int crossAxisCount =
                                (constraints.maxWidth / minSquareSize).floor();
                            if (crossAxisCount < 1) crossAxisCount = 1;
                            int rowCount =
                                (constraints.maxHeight / minSquareSize).ceil();
                            return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0,
                                  ),
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: Colors.grey.shade900.withValues(
                                        alpha: 0.2,
                                      ),
                                      width: 1,
                                    ),
                                  ),
                                );
                              },
                              itemCount: rowCount * crossAxisCount,
                            );
                          },
                        ),
                      ),
                      // Landing content
                      Padding(
                        padding: EdgeInsets.only(top: isMobile ? 120 : 200),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '// Joshua Nelson',
                              style: TextStyle(
                                color: Color(0xFF2FD0DE),
                                fontSize: 16,
                                letterSpacing: 2,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 24),
                            // I'm a Flutter Developer
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: isMobile ? 44 : 72,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  height: 1.05,
                                ),
                                children: [
                                  const TextSpan(text: "I'm a "),
                                  TextSpan(
                                    text: 'Flutter',
                                    style: TextStyle(
                                      color: const Color(0xFF2FD0DE),
                                      shadows: [
                                        Shadow(
                                          color: const Color(0xFF2FD0DE)
                                              .withValues(alpha: 0.6),
                                          blurRadius: 18,
                                          offset: const Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const TextSpan(text: '\nDeveloper'),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),
                            // Description
                            SizedBox(
                              width: isMobile ? viewportSize.width - 40 : 600,
                              child: Text(
                                'Building beautiful, natively compiled mobile and desktop applications from a single codebase. Passionate about pixel-perfect UIs, smooth animations, and great user experiences.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: isMobile ? 16 : 20,
                                  height: 1.4,
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                            // Buttons
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: isMobile ? 12 : 24,
                              runSpacing: 12,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2FD0DE),
                                    foregroundColor: Colors.black,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: isMobile ? 24 : 32,
                                      vertical: isMobile ? 18 : 24,
                                    ),
                                    textStyle: TextStyle(
                                      fontSize: isMobile ? 16 : 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: _scrollToProjects,
                                  child: const Text('View Apps'),
                                ),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    side: BorderSide(
                                      color: Colors.grey.shade600,
                                      width: 1.5,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: isMobile ? 24 : 32,
                                      vertical: isMobile ? 18 : 24,
                                    ),
                                    textStyle: TextStyle(
                                      fontSize: isMobile ? 16 : 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: _scrollToFooter,
                                  child: const Text('Get in Touch'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'lib/images/github.svg',
                                  width: 28,
                                  height: 28,
                                  color: Colors.grey.shade500,
                                ),
                                const SizedBox(width: 24),
                                SvgPicture.asset(
                                  'lib/images/linkedin.svg',
                                  width: 28,
                                  height: 28,
                                  color: Colors.grey.shade500,
                                ),
                                const SizedBox(width: 24),
                                Icon(
                                  Icons.mail_outline,
                                  color: Colors.grey.shade500,
                                  size: 28,
                                ),
                              ],
                            ),
                            SizedBox(height: isMobile ? 80 : 200),
                            const _BouncingArrow(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                // Rest of the page (no grid background)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sectionPadding),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 920),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "// ABOUT",
                            key: _aboutKey,
                            style: TextStyle(
                              color: Color.fromARGB(255, 47, 208, 222),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "A bit about me",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isMobile ? 32 : 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: isMobile ? 28 : 40),
                          _AboutContent(isMobile: isMobile),
                          SizedBox(height: sectionGap),
                          // TECH STACK SECTION
                          Text(
                            "// TECH STACK",
                            key: _techKey,
                            style: TextStyle(
                              color: Color(0xFF2FD0DE),
                              fontSize: 16,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Technologies I work with",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isMobile ? 32 : 42,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 40),
                          // Tech cards grid
                          LayoutBuilder(
                            builder: (context, constraints) {
                              const spacing = 20.0;
                              final gridWidth = constraints.maxWidth > 920
                                  ? 920.0
                                  : constraints.maxWidth;
                              final useTwoColumns = gridWidth >= 760;
                              final cardWidth = useTwoColumns
                                  ? (gridWidth - spacing) / 2
                                  : gridWidth;

                              const cards = [
                                _TechCard(
                                  title: 'Mobile / Flutter',
                                  titleColor: Color(0xFF2FD0DE),
                                  skills: [
                                    'Flutter',
                                    'Dart',
                                    'Material Design',
                                    'Cupertino Widgets',
                                    'Custom Animations',
                                  ],
                                ),
                                _TechCard(
                                  title: 'State & Architecture',
                                  titleColor: Color(0xFF2FD0DE),
                                  skills: ['Riverpod', 'Clean Architecture'],
                                ),
                                _TechCard(
                                  title: 'Backend & APIs',
                                  titleColor: Color(0xFF2FD0DE),
                                  skills: [
                                    'Firebase',
                                    'REST/HTTP APIs',
                                    'Supabase',
                                    'Python',
                                    'Cloud Firestore',
                                    'Real-time/WebSocket APIs',
                                    'Third Party APIs',
                                    'Local Storage',
                                    'Stripe',
                                  ],
                                ),
                                _TechCard(
                                  title: 'Tools & Deployment',
                                  titleColor: Color(0xFF2FD0DE),
                                  skills: [
                                    'Git & GitHub',
                                    'App Store / Play Store',
                                    'VS Code',
                                    'Android Studio',
                                  ],
                                ),
                              ];

                              return Center(
                                child: SizedBox(
                                  width: gridWidth,
                                  child: Wrap(
                                    spacing: spacing,
                                    runSpacing: spacing,
                                    children: [
                                      for (final card in cards)
                                        SizedBox(
                                          width: cardWidth,
                                          height: 225,
                                          child: card,
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: sectionGap),
                          Text(
                            "// PROJECTS",
                            key: _projectsKey,
                            style: TextStyle(
                              color: Color(0xFF2FD0DE),
                              fontSize: 16,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 16,
                            runSpacing: 10,
                            children: [
                              Text(
                                "Projects I've worked on",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isMobile ? 32 : 42,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (projectPageCount > 1)
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.swipe,
                                      color: Color(0xFF2FD0DE),
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'DRAG OR SCROLL FOR MORE',
                                      style: TextStyle(
                                        color: Color(0xFF2FD0DE),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Color(0xFF2FD0DE),
                                      size: 18,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            height: isMobile ? 430 : 600,
                            child: Scrollbar(
                              controller: _projectsPageController,
                              thumbVisibility: projectPageCount > 1,
                              trackVisibility: projectPageCount > 1,
                              interactive: true,
                              thickness: 9,
                              radius: const Radius.circular(8),
                              scrollbarOrientation: ScrollbarOrientation.bottom,
                              child: ScrollConfiguration(
                                behavior: const MaterialScrollBehavior()
                                    .copyWith(
                                      dragDevices: {
                                        PointerDeviceKind.touch,
                                        PointerDeviceKind.mouse,
                                        PointerDeviceKind.stylus,
                                        PointerDeviceKind.trackpad,
                                      },
                                    ),
                                child: PageView.builder(
                                  controller: _projectsPageController,
                                  itemCount: projectPageCount,
                                  pageSnapping: true,
                                  physics: const PageScrollPhysics(
                                    parent: ClampingScrollPhysics(),
                                  ),
                                  itemBuilder: (context, pageIndex) {
                                    final projects = portfolioProjects
                                        .skip(pageIndex * projectsPerPage)
                                        .take(projectsPerPage);

                                    return Padding(
                                      padding: const EdgeInsets.only(right: 18),
                                      child: LayoutBuilder(
                                        builder: (context, constraints) => FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.topCenter,
                                          child: SizedBox(
                                            width: constraints.maxWidth,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: projects
                                                  .map(
                                                    (project) => Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                            bottom: 16,
                                                          ),
                                                      child: ProjectListCard(
                                                        project: project,
                                                        onPressed: () {
                                                          Navigator.of(
                                                            context,
                                                          ).push(
                                                            MaterialPageRoute<
                                                              void
                                                            >(
                                                              builder: (_) =>
                                                                  ProjectDetailPage(
                                                                    project:
                                                                        project,
                                                                  ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: isMobile ? 80 : 120),
                        ],
                      ),
                    ),
                  ),
                ),
                SiteFooter(
                  key: _footerKey,
                  onViewProjects: _scrollToProjects,
                  onBackToTop: _scrollToTop,
                ),
              ],
            ),
          ),
          // Navbar overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: _scrolled ? const Color(0xFF0e1015) : Colors.transparent,
                boxShadow: _scrolled
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
                border: _scrolled
                    ? Border(
                        bottom: BorderSide(
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      )
                    : null,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: navPadding,
                  vertical: isMobile ? 16 : 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '< JN />',
                      style: TextStyle(
                        color: Color.fromARGB(255, 47, 208, 222),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerRight,
                        child: Row(
                          children: [
                            _NavItem(
                              'About',
                              compact: isMobile,
                              onPressed: () => _scrollToSection(_aboutKey),
                            ),
                            _NavItem(
                              'Tech',
                              compact: isMobile,
                              onPressed: () => _scrollToSection(_techKey),
                            ),
                            _NavItem(
                              'Projects',
                              compact: isMobile,
                              onPressed: _scrollToProjects,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutContent extends StatelessWidget {
  const _AboutContent({required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final profile = Container(
      width: isMobile ? 160 : 250,
      height: isMobile ? 160 : 250,
      decoration: BoxDecoration(
        color: const Color(0xFF181B20),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(Icons.person, color: Colors.grey, size: isMobile ? 56 : 72),
    );

    final description = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "I'm a dedicated Flutter developer with a passion for crafting high-performance, cross-platform mobile and desktop applications. With expertise in Dart and the Flutter ecosystem, I build apps that feel truly native on iOS, Android, and desktop from a single codebase.",
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: isMobile ? 16 : 18,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "I focus on clean architecture, state management best practices, and delivering pixel-perfect UIs with buttery-smooth animations. From concept to App Store & Play Store deployment, I handle the full mobile development lifecycle.",
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: isMobile ? 15 : 16,
            height: 1.5,
          ),
        ),
      ],
    );

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: profile),
          const SizedBox(height: 28),
          description,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        profile,
        const SizedBox(width: 40),
        Expanded(child: description),
      ],
    );
  }
}

// Navbar item widget
class _NavItem extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool compact;

  const _NavItem(this.label, {this.onPressed, this.compact = false});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.compact ? 1 : 16),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: TextButton(
          style: TextButton.styleFrom(
            overlayColor: Colors.transparent,
            padding: widget.compact
                ? const EdgeInsets.symmetric(horizontal: 6, vertical: 8)
                : null,
            minimumSize: widget.compact ? Size.zero : null,
            tapTargetSize: widget.compact
                ? MaterialTapTargetSize.shrinkWrap
                : null,
            visualDensity: widget.compact ? VisualDensity.compact : null,
          ),
          onPressed: widget.onPressed ?? () {},
          child: Text(
            widget.label,
            style: TextStyle(
              color: _isHovered
                  ? const Color(0xFF2FD0DE)
                  : Colors.grey.shade500,
              fontSize: widget.compact ? 13 : 18,
              fontWeight: FontWeight.w500,
              shadows: _isHovered
                  ? [
                      Shadow(
                        color: const Color(0xFF2FD0DE).withValues(alpha: 0.6),
                        blurRadius: 18,
                        offset: const Offset(0, 0),
                      ),
                    ]
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}

// Tech card widget
class _TechCard extends StatelessWidget {
  final String title;
  final Color titleColor;
  final List<String> skills;

  const _TechCard({
    required this.title,
    required this.titleColor,
    required this.skills,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF181B20),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade800, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) => FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: constraints.maxWidth,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: skills
                        .map(
                          (skill) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              skill,
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        )
                        .toList(),
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

// Animated bouncing arrow widget
class _BouncingArrow extends StatefulWidget {
  const _BouncingArrow();

  @override
  State<_BouncingArrow> createState() => _BouncingArrowState();
}

class _BouncingArrowState extends State<_BouncingArrow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 0,
      end: 5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: Icon(Icons.arrow_downward, color: Colors.grey.shade500, size: 24),
    );
  }
}
