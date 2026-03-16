// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get projects => 'Projects';

  @override
  String get commercialProjects => 'Commercial Projects';

  @override
  String get personalProjects => 'Personal Projects';

  @override
  String get experience => 'Work Experience';

  @override
  String get contact => 'Contact';

  @override
  String get skills => 'Skills';

  @override
  String get languages => 'Languages';

  @override
  String get phone => 'Phone';

  @override
  String get gitHub => 'GitHub';

  @override
  String get githubUrl => 'GitHub URL (optional)';

  @override
  String get present => 'Present';

  @override
  String get current => 'Current';

  @override
  String errorMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get errorNetwork =>
      'Could not connect. Check your connection and try again.';

  @override
  String get errorNotFound => 'The requested data could not be found.';

  @override
  String get errorPermission =>
      'You don\'t have permission to access this data.';

  @override
  String get errorAuth => 'Invalid email or password. Please try again.';

  @override
  String get errorUnknown => 'Something went wrong. Please try again.';

  @override
  String get retry => 'Retry';

  @override
  String get reloadPage => 'Reload Page';

  @override
  String get monthJan => 'Jan';

  @override
  String get monthFeb => 'Feb';

  @override
  String get monthMar => 'Mar';

  @override
  String get monthApr => 'Apr';

  @override
  String get monthMay => 'May';

  @override
  String get monthJun => 'Jun';

  @override
  String get monthJul => 'Jul';

  @override
  String get monthAug => 'Aug';

  @override
  String get monthSep => 'Sep';

  @override
  String get monthOct => 'Oct';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Dec';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get signOut => 'Sign Out';

  @override
  String get signIn => 'Sign In';

  @override
  String get profile => 'Profile';

  @override
  String get basicInfo => 'BASIC INFO';

  @override
  String get fullName => 'Full Name';

  @override
  String get title => 'Title';

  @override
  String get about => 'About';

  @override
  String get phoneNumber => 'Phone Number (optional)';

  @override
  String get socialLinks => 'Social Links';

  @override
  String get platformName => 'Platform name';

  @override
  String get platformUrl => 'URL';

  @override
  String get addSocialLink => 'Add social link';

  @override
  String get saveProfile => 'Save Profile';

  @override
  String get skillName => 'Skill name';

  @override
  String get categoryOptional => 'Category (optional)';

  @override
  String get add => 'Add';

  @override
  String get languageName => 'Language name';

  @override
  String get addInterest => 'Add interest';

  @override
  String get interests => 'Interests';

  @override
  String get addProject => 'Add Project';

  @override
  String get editProject => 'Edit Project';

  @override
  String get projectType => 'Type:';

  @override
  String get commercial => 'Commercial';

  @override
  String get personal => 'Personal';

  @override
  String get techStack => 'TECH STACK';

  @override
  String get addTechnology => 'Add technology';

  @override
  String get responsibilities => 'RESPONSIBILITIES';

  @override
  String get addResponsibility => 'Add responsibility';

  @override
  String get addExperience => 'Add Experience';

  @override
  String get editExperience => 'Edit Experience';

  @override
  String get dates => 'DATES';

  @override
  String get startDate => 'Start:';

  @override
  String get endDate => 'End:';

  @override
  String get deleteProject => 'Delete Project';

  @override
  String get deleteExperience => 'Delete Experience';

  @override
  String confirmDeleteItem(String name) {
    return 'Are you sure you want to delete \"$name\"?';
  }

  @override
  String get emailRequired => 'Email is required';

  @override
  String get enterValidEmail => 'Enter a valid email';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get adminPanel => 'Admin Panel';

  @override
  String get signInToContinue => 'Sign in to continue';

  @override
  String get personalProject => 'Personal project';

  @override
  String get discard => 'Discard';

  @override
  String get projectName => 'Project name';

  @override
  String get descriptionOptional => 'Description (optional)';

  @override
  String get company => 'Company';

  @override
  String get role => 'Role';

  @override
  String get location => 'Location';

  @override
  String get timezone => 'Timezone';

  @override
  String get downloadCv => 'View CV';

  @override
  String get cvPdf => 'CV (PDF)';
}
