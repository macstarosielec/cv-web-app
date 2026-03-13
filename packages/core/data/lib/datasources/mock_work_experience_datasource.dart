import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@dev
@lazySingleton
class MockWorkExperienceDatasource {
  List<WorkExperience> getWorkExperiences() => [
        WorkExperience(
          id: '1',
          title: 'Senior Flutter Developer',
          company: 'TechCorp',
          startDate: DateTime(2023, 3),
          responsibilities: [
            'Leading mobile development team of 4 engineers',
            'Architecting Flutter applications with clean architecture',
            'Conducting code reviews and mentoring junior developers',
            'Collaborating with product and design teams on feature planning',
          ],
        ),
        WorkExperience(
          id: '2',
          title: 'Flutter Developer',
          company: 'WellnessApp Inc.',
          startDate: DateTime(2021, 6),
          endDate: DateTime(2023, 2),
          responsibilities: [
            'Developed cross-platform mobile applications with Flutter',
            'Implemented state management solutions using BLoC pattern',
            'Integrated third-party APIs and native platform features',
          ],
          sortOrder: 1,
        ),
        WorkExperience(
          id: '3',
          title: 'Junior Mobile Developer',
          company: 'StartupHub',
          startDate: DateTime(2019, 9),
          endDate: DateTime(2021, 5),
          responsibilities: [
            'Built mobile applications using Flutter and native Android',
            'Participated in agile development process',
            'Wrote unit and widget tests',
          ],
          sortOrder: 2,
        ),
      ];
}
