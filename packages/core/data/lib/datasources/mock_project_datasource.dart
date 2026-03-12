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
      ];
}
