import '../models/portfolio_project.dart';
import 'projects/kalshi_bot/kalshi_bot_project.dart';
import 'projects/seko_flow/seko_flow_project.dart';
import 'projects/claim_ready/claim_ready_project.dart';
import 'projects/dart_port/dart_port_project.dart';
import 'projects/flutter_battles/flutter_battles_project.dart';

/// The project overview and dynamic detail page both read from this list.
const portfolioProjects = <PortfolioProject>[
  kalshiProject,
  claimReadyProject,
  dartPortProject,
  flutterBattlesProject,
  sekoFlowProject,
];
