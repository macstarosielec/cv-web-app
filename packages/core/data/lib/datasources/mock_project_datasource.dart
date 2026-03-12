import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@dev
@lazySingleton
class MockProjectDatasource {
  List<Project> getProjects() => const [
        Project(
          id: '1',
          name: 'E-Commerce Platform',
          company: 'TechCorp',
          role: 'Lead Flutter Developer',
          description: 'A full-featured e-commerce mobile application '
              'serving thousands of daily active users.',
          techStack: [
            'Flutter',
            'Dart',
            'Firebase',
            'Stripe',
            'BLoC',
          ],
          responsibilities: [
            'Led a team of 4 developers building the mobile app',
            'Designed and implemented clean architecture with BLoC state management',
            'Integrated payment processing with Stripe',
            'Achieved 99.5% crash-free rate in production',
          ],
        ),
        Project(
          id: '2',
          name: 'Health & Fitness Tracker',
          company: 'WellnessApp Inc.',
          role: 'Senior Flutter Developer',
          techStack: [
            'Flutter',
            'Dart',
            'GraphQL',
            'Hive',
            'Provider',
          ],
          responsibilities: [
            'Built real-time activity tracking with native platform integration',
            'Implemented offline-first architecture using Hive',
            'Created custom chart widgets for health data visualization',
          ],
          sortOrder: 1,
        ),
        Project(
          id: '3',
          name: 'Banking Dashboard',
          company: 'FinServ Solutions',
          role: 'Flutter Developer',
          description: 'Internal dashboard for monitoring financial '
              'transactions and generating reports.',
          techStack: [
            'Flutter Web',
            'Dart',
            'REST API',
            'GetIt',
            'Freezed',
          ],
          responsibilities: [
            'Developed responsive web dashboard with Flutter',
            'Implemented complex data tables with sorting and filtering',
            'Built PDF report generation module',
          ],
          sortOrder: 2,
        ),
        Project(
          id: '4',
          name: 'Smart Home Controller',
          company: 'IoT Systems Ltd.',
          role: 'Flutter Developer',
          description: 'Cross-platform app to manage and automate '
              'smart home devices via MQTT.',
          techStack: [
            'Flutter',
            'Dart',
            'MQTT',
            'Riverpod',
            'SQLite',
          ],
          responsibilities: [
            'Integrated MQTT protocol for real-time device communication',
            'Built custom UI widgets for device control panels',
            'Implemented local scheduling engine with SQLite persistence',
          ],
          sortOrder: 3,
        ),
        Project(
          id: '5',
          name: 'Logistics Fleet Tracker',
          company: 'CargoFlow',
          role: 'Senior Mobile Engineer',
          description: 'Real-time fleet management platform with '
              'route optimization and driver dispatching.',
          techStack: [
            'Flutter',
            'Dart',
            'Google Maps',
            'WebSockets',
            'Firebase',
          ],
          responsibilities: [
            'Built live map view with real-time vehicle tracking',
            'Implemented geofencing and route deviation alerts',
            'Designed offline mode for areas with poor connectivity',
            'Reduced delivery ETA errors by 35% with route optimization',
          ],
          sortOrder: 4,
        ),
        Project(
          id: '6',
          name: 'EdTech Learning Platform',
          company: 'LearnSpace',
          role: 'Lead Mobile Developer',
          description: 'Interactive learning app with video courses, '
              'quizzes, and progress tracking for 50k+ students.',
          techStack: [
            'Flutter',
            'Dart',
            'Firebase',
            'Video Player',
            'BLoC',
            'Algolia',
          ],
          responsibilities: [
            'Architected the mobile app from scratch serving 50k+ users',
            'Built adaptive video player with offline download support',
            'Implemented full-text search with Algolia integration',
            'Created gamification system with badges and leaderboards',
          ],
          sortOrder: 5,
        ),
        Project(
          id: '7',
          name: 'Insurance Claims Portal',
          company: 'SecureLife Insurance',
          role: 'Flutter Developer',
          techStack: [
            'Flutter Web',
            'Dart',
            'REST API',
            'BLoC',
            'PDF',
          ],
          responsibilities: [
            'Developed multi-step claims submission wizard',
            'Implemented document upload with image compression',
            'Built role-based access control for agents and customers',
          ],
          sortOrder: 6,
        ),
        Project(
          id: '8',
          name: 'Restaurant POS System',
          company: 'DineFlow',
          role: 'Mobile Developer',
          description: 'Tablet-based point-of-sale system for '
              'restaurants with kitchen display integration.',
          techStack: [
            'Flutter',
            'Dart',
            'Bluetooth',
            'Hive',
            'GetIt',
          ],
          responsibilities: [
            'Built order management UI optimized for tablet devices',
            'Integrated Bluetooth receipt printer communication',
            'Implemented offline-first POS with background sync',
          ],
          sortOrder: 7,
        ),
      ];
}
