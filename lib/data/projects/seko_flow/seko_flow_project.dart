import '../../../models/portfolio_project.dart';

const sekoFlowProject = PortfolioProject(
  id: 'seko_flow',
  appName: 'Seko Flow',
  slogan: 'LTL Shipments Made Easy for Husky and SEKO',
  description: 'A platform that simplifies LTL shipments for Husky and SEKO. It provides real-time tracking, easy shipment management, and seamless coordination between the two companies.',
  year: '2026',
  isDesktop: true,
  skills: [
    'Flutter',
    'Dart',
    'Supabase',
  ],
  previewHeadlines: [
    'Track every shipment from one clear view.',
    'Create and manage shipments effortlessly between Husky and SEKO.',
    'See every shipment detail from pickup to delivery.'
  ],
  screenshots: [
    'lib/data/projects/seko_flow/screenshots/ss_seko_flow1.png',
    'lib/data/projects/seko_flow/screenshots/ss_seko_flow2.png',
    'lib/data/projects/seko_flow/screenshots/ss_seko_flow3.png',
  ],
);
