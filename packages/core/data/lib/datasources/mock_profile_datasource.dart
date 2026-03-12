import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@dev
@lazySingleton
class MockProfileDatasource {
  Profile getProfile() => const Profile(
        fullName: 'Maciej Doe',
        title: 'Senior Flutter Developer',
        about:
            'Passionate mobile developer with extensive experience in building '
            'cross-platform applications using Flutter. Focused on clean '
            'architecture, testability, and delivering high-quality user '
            'experiences.',
        email: 'maciej@example.com',
        phoneNumber: '+48 123 456 789',
        linkedInUrl: 'https://linkedin.com/in/maciej',
        githubUrl: 'https://github.com/maciej',
        skills: [
          Skill(name: 'Flutter', category: 'Mobile'),
          Skill(name: 'Dart', category: 'Languages', sortOrder: 1),
          Skill(name: 'Kotlin', category: 'Languages', sortOrder: 2),
          Skill(name: 'Swift', category: 'Languages', sortOrder: 3),
          Skill(name: 'Firebase', category: 'Backend', sortOrder: 4),
          Skill(name: 'Git', category: 'Tools', sortOrder: 5),
          Skill(name: 'CI/CD', category: 'Tools', sortOrder: 6),
          Skill(name: 'Figma', category: 'Tools', sortOrder: 7),
        ],
        languages: [
          Language(
            name: 'Polish',
            proficiency: LanguageProficiency.native,
          ),
          Language(
            name: 'English',
            proficiency: LanguageProficiency.c1,
          ),
        ],
        interests: [
          'Open Source',
          'Mobile Development',
          'UI/UX Design',
        ],
      );
}
