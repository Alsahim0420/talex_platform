// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'TaleX';

  @override
  String get tagline => 'Enterprise Logic';

  @override
  String get secureSignIn => 'Secure Sign In';

  @override
  String get workEmail => 'Work Email';

  @override
  String get emailHint => 'executive@company.com';

  @override
  String get password => 'Password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get signIn => 'Sign In';

  @override
  String get continueWith => 'Or continue with';

  @override
  String get signInLinkedIn => 'Sign in with LinkedIn';

  @override
  String get newToTalex => 'New to TaleX?';

  @override
  String get createAccountLink => 'Create account';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get validEmailError => 'Enter a valid work email';

  @override
  String get passwordLengthError => 'Password must have at least 6 characters';

  @override
  String get resetEmailSent => 'Check your email to reset your password.';

  @override
  String get createAccount => 'Create your account';

  @override
  String get registerSubtitle =>
      'Deploy enterprise logic flows with confidence.';

  @override
  String get fullName => 'Full Name';

  @override
  String get fullNameHint => 'Jane Doe';

  @override
  String get companyName => 'Company Name';

  @override
  String get companyHint => 'Acme Corp';

  @override
  String get signUp => 'Sign up';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get logIn => 'Log in';

  @override
  String get requiredField => 'This field is required';

  @override
  String get testimonial =>
      '“TaleX transformed our logic routing, reducing structural latency by 40% in the first quarter.”';

  @override
  String get testimonialName => 'Sarah Jenkins';

  @override
  String get testimonialRole => 'VP of Engineering, Nexus Dynamics';

  @override
  String welcomeUser(String name) {
    return 'Welcome, $name';
  }

  @override
  String get signOut => 'Sign out';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get roles => 'Invitations';

  @override
  String get candidates => 'Enabled people';

  @override
  String get assessments => 'Assessments';

  @override
  String get managers => 'Team';

  @override
  String get reports => 'Reports';

  @override
  String get settings => 'Settings';

  @override
  String get support => 'Support';

  @override
  String get documentation => 'Documentation';

  @override
  String get searchHint => 'Search people, invitations, or assessments...';

  @override
  String get overview => 'Overview';

  @override
  String get overviewSubtitle =>
      'A general view of the assessments assigned by your team.';

  @override
  String get generateReport => 'Generate Report';

  @override
  String get newRole => 'Enable person';

  @override
  String get activeRoles => 'Invitations sent';

  @override
  String get evaluatedCandidates => 'Not started';

  @override
  String get averageFitScore => 'Assessments in progress';

  @override
  String get hiringVelocity => 'Completed assessments';

  @override
  String get thisWeekChange => '+8 this week';

  @override
  String get thisMonthChange => '5 expire soon';

  @override
  String get stableTopRoles => 'Real-time activity';

  @override
  String get daysFromQuarter => '+42 this month';

  @override
  String get topMatches => 'Recent activity';

  @override
  String get viewAll => 'View All';

  @override
  String get candidate => 'Candidate';

  @override
  String get matchedRole => 'Assessment';

  @override
  String get affinity => 'Status';

  @override
  String get action => 'Action';

  @override
  String get pendingActions => 'Pending Actions';

  @override
  String get reviewRequirements => 'Results ready to review';

  @override
  String get finalApproval => 'Invitations expiring soon';

  @override
  String get scheduleInterview => 'Interrupted assessment';

  @override
  String get statusCompleted => 'Completed';

  @override
  String get statusInProgress => 'In progress';

  @override
  String get statusPending => 'Pending';

  @override
  String get logicalReasoningAssessment => 'Logical reasoning';

  @override
  String get decisionMakingAssessment => 'Decision making';

  @override
  String get problemSolvingAssessment => 'Problem solving';

  @override
  String get completedToday => 'Completed today';

  @override
  String get expiresTomorrow => '5 invitations expire tomorrow';

  @override
  String get connectionInterrupted => 'Recruiter follow-up required';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSubtitle =>
      'Manage your organization, hiring workflows, and security.';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get changesSaved => 'Your changes were saved successfully.';

  @override
  String get organizationProfile => 'Organization profile';

  @override
  String get organizationDescription =>
      'Information that identifies your company across TaleX.';

  @override
  String get organizationName => 'Organization name';

  @override
  String get industry => 'Industry';

  @override
  String get companySize => 'Company size';

  @override
  String get timezone => 'Time zone';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsDescription =>
      'Choose which workflow updates you receive.';

  @override
  String get candidateUpdates => 'Assessment activity';

  @override
  String get candidateUpdatesDescription =>
      'Updates when an assessment starts, completes, or expires.';

  @override
  String get weeklyDigest => 'Weekly digest';

  @override
  String get weeklyDigestDescription =>
      'Pipeline metrics and activity every Monday.';

  @override
  String get securityTitle => 'Security and access';

  @override
  String get securityDescription =>
      'Protect your team\'s access to the platform.';

  @override
  String get twoFactorAuth => 'Two-factor authentication';

  @override
  String get twoFactorDescription =>
      'Require a second factor for administrator accounts.';

  @override
  String get sessionTimeout => 'Session timeout';

  @override
  String get manageMembers => 'Manage members';

  @override
  String get technologyIndustry => 'Technology';

  @override
  String get employeesRange => '51–200 employees';

  @override
  String get minutes30 => '30 minutes';
}
