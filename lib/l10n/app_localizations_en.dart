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
  String get secureSignIn => 'Secure Sign In';

  @override
  String get workEmail => 'Email address';

  @override
  String get emailAddress => 'Email address';

  @override
  String get emailAddressHint => 'candidate@email.com';

  @override
  String get validEmailAddressError => 'Enter a valid email address';

  @override
  String get emailHint => 'email@example.com';

  @override
  String get password => 'Password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get signIn => 'Sign In';

  @override
  String get continueWith => 'Or continue with';

  @override
  String get signInGoogle => 'Sign in with Google';

  @override
  String get signUpGoogle => 'Sign up with Google';

  @override
  String get googleSignInError =>
      'Unable to sign in with Google. Please try again.';

  @override
  String get newToTalex => 'New to TaleX?';

  @override
  String get createAccountLink => 'Create account';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get validEmailError => 'Enter a valid email address';

  @override
  String get passwordLengthError => 'Password must have at least 6 characters';

  @override
  String get resetEmailSent => 'Check your email to reset your password.';

  @override
  String get createAccount => 'Create your account';

  @override
  String get registerSubtitle =>
      'Create your account to get started with TaleX.';

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
      '“TaleX transformed our selection process and helped our team make better decisions.”';

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
  String get invitationsTitle => 'Invitations';

  @override
  String get invitationsSubtitle =>
      'Enable people and track their assigned assessments.';

  @override
  String get enablePerson => 'Enable person';

  @override
  String get enablePersonSubtitle =>
      'Assign an assessment and send an access invitation.';

  @override
  String get personName => 'Person\'s name';

  @override
  String get personNameHint => 'First and last name';

  @override
  String get selectAssessment => 'Assigned assessment';

  @override
  String get invitationExpiry => 'Invitation validity';

  @override
  String daysValue(int count) {
    return '$count days';
  }

  @override
  String get optionalMessage => 'Optional message';

  @override
  String get optionalMessageHint => 'Add instructions for the person...';

  @override
  String get sendInvitation => 'Send invitation';

  @override
  String get invitationSent =>
      'The person was enabled and the invitation was created.';

  @override
  String get invitationResent =>
      'The invitation was resent and its validity was renewed.';

  @override
  String get invitationCancelled => 'The invitation was cancelled.';

  @override
  String get noInvitations => 'No people have been enabled yet';

  @override
  String get noInvitationsDescription =>
      'Enable the first person and assign an assessment.';

  @override
  String expiresOn(String date) {
    return 'Expires: $date';
  }

  @override
  String get resend => 'Resend';

  @override
  String get cancelInvitation => 'Cancel invitation';

  @override
  String get confirmCancellation =>
      'Cancel this invitation? The person will lose access to the assessment.';

  @override
  String get keepInvitation => 'Keep invitation';

  @override
  String get statusExpired => 'Expired';

  @override
  String get statusCancelled => 'Cancelled';

  @override
  String get statusInterrupted => 'Interrupted';

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

  @override
  String get adminCommandCenter => 'Command center';

  @override
  String get adminCommandSubtitle =>
      'An executive read of TaleX: operations, customers, and growth.';

  @override
  String get adminCompanies => 'Companies';

  @override
  String get adminProcesses => 'Processes';

  @override
  String get adminPeople => 'People';

  @override
  String get adminAffinity => 'Affinity';

  @override
  String get adminCommercial => 'Commercial';

  @override
  String get adminSales => 'Sales';

  @override
  String get adminAnalytics => 'Analytics';

  @override
  String get adminAlerts => 'Alerts';

  @override
  String get adminXebec => 'Xebec';

  @override
  String get adminSettings => 'Settings';

  @override
  String get adminSearchHint => 'Search companies, processes, or people...';

  @override
  String get kpiTotalCompanies => 'Total companies';

  @override
  String get kpiActiveCompanies => 'Active companies';

  @override
  String get kpiEvaluatedPeople => 'People evaluated';

  @override
  String get kpiCompletedEvaluations => 'Completed assessments';

  @override
  String get kpiAffinities => 'Affinities detected';

  @override
  String get kpiPeriodSales => 'Period sales';

  @override
  String get kpiMrr => 'MRR';

  @override
  String get kpiAtRisk => 'Companies at risk';

  @override
  String get recentActivity => 'Recent activity';

  @override
  String get noActivity => 'No activity has been recorded yet.';

  @override
  String get talexFunnel => 'TaleX funnel';

  @override
  String get funnelCompanies => 'Companies';

  @override
  String get funnelProcesses => 'Processes';

  @override
  String get funnelInvited => 'People invited';

  @override
  String get funnelStarted => 'Assessments started';

  @override
  String get funnelCompleted => 'Assessments completed';

  @override
  String get funnelAffinities => 'Affinities detected';

  @override
  String get funnelDecisions => 'Results / decisions';

  @override
  String get noData => 'No data';

  @override
  String get noInformationYet => 'There is no information yet.';

  @override
  String get retry => 'Retry';

  @override
  String get newCompany => 'New company';

  @override
  String get newProcess => 'New process';

  @override
  String get newPerson => 'Register person';

  @override
  String get newDeal => 'New opportunity';

  @override
  String get newSale => 'Record sale';

  @override
  String get companyStatusActive => 'Active';

  @override
  String get companyStatusOnboarding => 'Onboarding';

  @override
  String get companyStatusInactive => 'Inactive';

  @override
  String get companyStatusAtRisk => 'At risk';

  @override
  String get companyStatusSuspended => 'Suspended';

  @override
  String get processStatusActive => 'Active';

  @override
  String get processStatusClosed => 'Closed';

  @override
  String get evaluationInvited => 'Invited';

  @override
  String get evaluationStarted => 'Started';

  @override
  String get evaluationInProgress => 'In progress';

  @override
  String get evaluationCompleted => 'Completed';

  @override
  String get evaluationAbandoned => 'Abandoned';

  @override
  String get affinityHigh => 'High affinity';

  @override
  String get affinityMedium => 'Medium affinity';

  @override
  String get affinityLow => 'Low affinity';

  @override
  String get affinityUnknown => 'Unclassified';

  @override
  String get dealProspect => 'Prospect';

  @override
  String get dealContacted => 'Contacted';

  @override
  String get dealMeeting => 'Meeting';

  @override
  String get dealProposal => 'Proposal';

  @override
  String get dealNegotiation => 'Negotiation';

  @override
  String get dealClient => 'Customer';

  @override
  String get filterAll => 'All';

  @override
  String get lastActivity => 'Last activity';

  @override
  String get joinedAt => 'Joined';

  @override
  String get openDetail => 'Open details';

  @override
  String get backToCompanies => 'Back to companies';

  @override
  String get companyOverview => 'Overview';

  @override
  String get companyCommercial => 'Commercial';

  @override
  String get companyMetrics => 'Utilization';

  @override
  String get noCompanies => 'There are no companies in TaleX yet.';

  @override
  String get noProcesses => 'There are no processes to show.';

  @override
  String get noPeople =>
      'There are no evaluated people to show. Sensitive answers are not exposed.';

  @override
  String get noDeals => 'There are no opportunities in the pipeline.';

  @override
  String get noSales => 'There are no sales recorded in this period.';

  @override
  String get noAlerts => 'There are no alerts calculated from current data.';

  @override
  String get period7 => '7 days';

  @override
  String get period30 => '30 days';

  @override
  String get period90 => '90 days';

  @override
  String get period12m => '12 months';

  @override
  String get completionRate => 'Completion rate';

  @override
  String get suggestedAction => 'Suggested action';

  @override
  String get xebecSubtitle =>
      'Xebec answers with the real command-center context.';

  @override
  String get xebecPlaceholder => 'How is TaleX doing?';

  @override
  String get xebecEmpty =>
      'Ask about TaleX health, companies at risk, or opportunities. Xebec uses real metrics, not guesses.';

  @override
  String get askXebec => 'Ask';

  @override
  String get adminSettingsSubtitle =>
      'Users, roles, and real system parameters. Nothing fictional.';

  @override
  String get superAdminHelp =>
      'SuperAdmin is granted if the email is listed in config/superadmin.emails or the user document already has role=superadmin. Credentials live in Firebase Auth; change them with password reset or the console.';

  @override
  String get adminUsers => 'Users';

  @override
  String get roleLabel => 'Role';

  @override
  String get adminSaved => 'Changes were saved in TaleX.';

  @override
  String get amount => 'Amount';

  @override
  String get plan => 'Plan';

  @override
  String get owner => 'Owner';

  @override
  String get nextAction => 'Next action';

  @override
  String get product => 'Product or service';

  @override
  String get recurring => 'Recurring (MRR)';

  @override
  String get estimatedValue => 'Estimated value';

  @override
  String get affinityScore => 'Affinity score (0-100)';

  @override
  String get statusLabel => 'Status';

  @override
  String get priorityHigh => 'High';

  @override
  String get priorityMedium => 'Medium';

  @override
  String get priorityLow => 'Low';

  @override
  String get alertRisk => 'Risk';

  @override
  String get alertOperational => 'Operational';

  @override
  String get alertCommercial => 'Commercial';

  @override
  String get alertProduct => 'Product';

  @override
  String get alertOpportunity => 'Opportunity';

  @override
  String get salesPeriod => 'Period sales';

  @override
  String get salesCumulative => 'Cumulative sales';

  @override
  String get newCustomers => 'Customers in period';

  @override
  String get averageTicket => 'Average ticket';

  @override
  String get growth => 'Growth vs previous period';

  @override
  String get activityByDay => 'Activity by day';
}
