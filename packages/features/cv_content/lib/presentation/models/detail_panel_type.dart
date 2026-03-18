import 'package:shared/constants/app_constants.dart';

enum DetailPanelType {
  projects,
  experience,
  contact;

  int get gradientSeed => switch (this) {
        DetailPanelType.projects => AppConstants.gradientSeedProjects,
        DetailPanelType.experience => AppConstants.gradientSeedExperience,
        DetailPanelType.contact => AppConstants.gradientSeedContact,
      };
}
