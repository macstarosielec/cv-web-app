abstract final class AppConstants {
  // App Names
  static const cvAppNameProd = 'RESUME';
  static const cvAppNameDev = '[DEV] RESUME';
  static const adminAppNameProd = 'RESUME ADMIN PANEL';
  static const adminAppNameDev = '[DEV] RESUME ADMIN PANEL';

  // Firestore Collections
  static const firestoreCollectionProfile = 'profile';
  static const firestoreCollectionProjects = 'projects';
  static const firestoreCollectionWorkExperiences = 'work_experiences';
  static const firestoreDocProfileMain = 'main';

  // Firestore Field Names
  static const fieldSkills = 'skills';
  static const fieldLanguages = 'languages';
  static const fieldSocialLinks = 'socialLinks';
  static const fieldSortOrder = 'sortOrder';
  static const fieldStartDate = 'startDate';
  static const fieldEndDate = 'endDate';

  // Analytics Events
  static const eventPanelOpened = 'panel_opened';
  static const eventProjectHovered = 'project_hovered';
  static const eventExperienceHovered = 'experience_hovered';

  // Analytics Parameters
  static const paramPanelName = 'panel_name';
  static const paramProjectName = 'project_name';
  static const paramTitle = 'title';
  static const paramCompany = 'company';

  // Local Storage
  static const localStorageKeyVisited = 'cv_app_visited';

  // Gradient Seeds
  static const gradientSeedProjects = 42;
  static const gradientSeedExperience = 84;
  static const gradientSeedContact = 126;
}
