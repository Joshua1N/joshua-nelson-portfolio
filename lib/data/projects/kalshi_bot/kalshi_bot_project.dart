import '../../../models/portfolio_project.dart';

const kalshiProject = PortfolioProject(
  id: 'kalshi_bot',
  appName: 'Kalshi Trading Bot',
  slogan: 'Trade the Moment. Not the Market.',
  description: 'A fast-moving Kalshi trading bot built for 15-minute markets. It tracks live market probabilities and underlying price movement to identify short-term opportunities, manage entries, evaluate trades--all within each 15-minute window.',
  year: '2026',
  isDesktop: true,
  skills: [
    'Flutter',
    'Dart',
    'HTTP',
    'Supabase',
    'Kalshi REST API',
    'Kalshi WebSocket API',
    'Python',
    'SQLite',
    'CSV / JSON',
    'RSA-PSS authentication',
    'Kalshi Live Data API',
  ],
  previewHeadlines: [
    'See the market at a glance.',
    'Every trade. Every result.',
    'Tune the strategy your way.',
  ],
  screenshots: [
    'lib/data/projects/kalshi_bot/screenshots/ss_kalshi_bot1.png',
    'lib/data/projects/kalshi_bot/screenshots/ss_kalshi_bot2.png',
    'lib/data/projects/kalshi_bot/screenshots/ss_kalshi_bot3.png',
  ],
);
