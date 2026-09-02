import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appName.
  ///
  /// In es, this message translates to:
  /// **'TaleX'**
  String get appName;

  /// No description provided for @secureSignIn.
  ///
  /// In es, this message translates to:
  /// **'Inicio de sesión seguro'**
  String get secureSignIn;

  /// No description provided for @workEmail.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico'**
  String get workEmail;

  /// No description provided for @emailAddress.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico'**
  String get emailAddress;

  /// No description provided for @emailAddressHint.
  ///
  /// In es, this message translates to:
  /// **'candidato@correo.com'**
  String get emailAddressHint;

  /// No description provided for @validEmailAddressError.
  ///
  /// In es, this message translates to:
  /// **'Ingresa un correo electrónico válido'**
  String get validEmailAddressError;

  /// No description provided for @emailHint.
  ///
  /// In es, this message translates to:
  /// **'correo@ejemplo.com'**
  String get emailHint;

  /// No description provided for @password.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In es, this message translates to:
  /// **'¿Olvidaste tu contraseña?'**
  String get forgotPassword;

  /// No description provided for @signIn.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión'**
  String get signIn;

  /// No description provided for @continueWith.
  ///
  /// In es, this message translates to:
  /// **'O continúa con'**
  String get continueWith;

  /// No description provided for @signInGoogle.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión con Google'**
  String get signInGoogle;

  /// No description provided for @signUpGoogle.
  ///
  /// In es, this message translates to:
  /// **'Crear cuenta con Google'**
  String get signUpGoogle;

  /// No description provided for @googleSignInError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo iniciar sesión con Google. Inténtalo nuevamente.'**
  String get googleSignInError;

  /// No description provided for @newToTalex.
  ///
  /// In es, this message translates to:
  /// **'¿Nuevo en TaleX?'**
  String get newToTalex;

  /// No description provided for @createAccountLink.
  ///
  /// In es, this message translates to:
  /// **'Crear cuenta'**
  String get createAccountLink;

  /// No description provided for @privacyPolicy.
  ///
  /// In es, this message translates to:
  /// **'Política de privacidad'**
  String get privacyPolicy;

  /// No description provided for @termsOfService.
  ///
  /// In es, this message translates to:
  /// **'Términos del servicio'**
  String get termsOfService;

  /// No description provided for @validEmailError.
  ///
  /// In es, this message translates to:
  /// **'Ingresa un correo electrónico válido'**
  String get validEmailError;

  /// No description provided for @passwordLengthError.
  ///
  /// In es, this message translates to:
  /// **'La contraseña debe tener al menos 6 caracteres'**
  String get passwordLengthError;

  /// No description provided for @resetEmailSent.
  ///
  /// In es, this message translates to:
  /// **'Revisa tu correo para restablecer la contraseña.'**
  String get resetEmailSent;

  /// No description provided for @createAccount.
  ///
  /// In es, this message translates to:
  /// **'Crea tu cuenta'**
  String get createAccount;

  /// No description provided for @registerSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Crea tu cuenta para comenzar en TaleX.'**
  String get registerSubtitle;

  /// No description provided for @fullName.
  ///
  /// In es, this message translates to:
  /// **'Nombre completo'**
  String get fullName;

  /// No description provided for @fullNameHint.
  ///
  /// In es, this message translates to:
  /// **'María Pérez'**
  String get fullNameHint;

  /// No description provided for @companyName.
  ///
  /// In es, this message translates to:
  /// **'Nombre de la empresa'**
  String get companyName;

  /// No description provided for @companyHint.
  ///
  /// In es, this message translates to:
  /// **'Empresa S.A.S.'**
  String get companyHint;

  /// No description provided for @signUp.
  ///
  /// In es, this message translates to:
  /// **'Registrarse'**
  String get signUp;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In es, this message translates to:
  /// **'¿Ya tienes una cuenta?'**
  String get alreadyHaveAccount;

  /// No description provided for @logIn.
  ///
  /// In es, this message translates to:
  /// **'Inicia sesión'**
  String get logIn;

  /// No description provided for @requiredField.
  ///
  /// In es, this message translates to:
  /// **'Este campo es obligatorio'**
  String get requiredField;

  /// No description provided for @testimonial.
  ///
  /// In es, this message translates to:
  /// **'“TaleX transformó nuestro proceso de selección y ayudó a nuestro equipo a tomar mejores decisiones.”'**
  String get testimonial;

  /// No description provided for @testimonialName.
  ///
  /// In es, this message translates to:
  /// **'Sarah Jenkins'**
  String get testimonialName;

  /// No description provided for @testimonialRole.
  ///
  /// In es, this message translates to:
  /// **'VP de Ingeniería, Nexus Dynamics'**
  String get testimonialRole;

  /// No description provided for @welcomeUser.
  ///
  /// In es, this message translates to:
  /// **'Bienvenido, {name}'**
  String welcomeUser(String name);

  /// No description provided for @signOut.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get signOut;

  /// No description provided for @dashboard.
  ///
  /// In es, this message translates to:
  /// **'Panel principal'**
  String get dashboard;

  /// No description provided for @roles.
  ///
  /// In es, this message translates to:
  /// **'Invitaciones'**
  String get roles;

  /// No description provided for @candidates.
  ///
  /// In es, this message translates to:
  /// **'Personas habilitadas'**
  String get candidates;

  /// No description provided for @assessments.
  ///
  /// In es, this message translates to:
  /// **'Evaluaciones'**
  String get assessments;

  /// No description provided for @managers.
  ///
  /// In es, this message translates to:
  /// **'Equipo'**
  String get managers;

  /// No description provided for @reports.
  ///
  /// In es, this message translates to:
  /// **'Reportes'**
  String get reports;

  /// No description provided for @settings.
  ///
  /// In es, this message translates to:
  /// **'Configuración'**
  String get settings;

  /// No description provided for @support.
  ///
  /// In es, this message translates to:
  /// **'Soporte'**
  String get support;

  /// No description provided for @documentation.
  ///
  /// In es, this message translates to:
  /// **'Documentación'**
  String get documentation;

  /// No description provided for @searchHint.
  ///
  /// In es, this message translates to:
  /// **'Buscar personas, invitaciones o evaluaciones...'**
  String get searchHint;

  /// No description provided for @overview.
  ///
  /// In es, this message translates to:
  /// **'Resumen'**
  String get overview;

  /// No description provided for @overviewSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Seguimiento general de las evaluaciones asignadas por tu equipo.'**
  String get overviewSubtitle;

  /// No description provided for @generateReport.
  ///
  /// In es, this message translates to:
  /// **'Generar reporte'**
  String get generateReport;

  /// No description provided for @newRole.
  ///
  /// In es, this message translates to:
  /// **'Habilitar persona'**
  String get newRole;

  /// No description provided for @activeRoles.
  ///
  /// In es, this message translates to:
  /// **'Invitaciones enviadas'**
  String get activeRoles;

  /// No description provided for @evaluatedCandidates.
  ///
  /// In es, this message translates to:
  /// **'Pendientes de iniciar'**
  String get evaluatedCandidates;

  /// No description provided for @averageFitScore.
  ///
  /// In es, this message translates to:
  /// **'Evaluaciones en curso'**
  String get averageFitScore;

  /// No description provided for @hiringVelocity.
  ///
  /// In es, this message translates to:
  /// **'Evaluaciones completadas'**
  String get hiringVelocity;

  /// No description provided for @thisWeekChange.
  ///
  /// In es, this message translates to:
  /// **'+8 esta semana'**
  String get thisWeekChange;

  /// No description provided for @thisMonthChange.
  ///
  /// In es, this message translates to:
  /// **'5 vencen próximamente'**
  String get thisMonthChange;

  /// No description provided for @stableTopRoles.
  ///
  /// In es, this message translates to:
  /// **'Actividad en tiempo real'**
  String get stableTopRoles;

  /// No description provided for @daysFromQuarter.
  ///
  /// In es, this message translates to:
  /// **'+42 este mes'**
  String get daysFromQuarter;

  /// No description provided for @topMatches.
  ///
  /// In es, this message translates to:
  /// **'Actividad reciente'**
  String get topMatches;

  /// No description provided for @viewAll.
  ///
  /// In es, this message translates to:
  /// **'Ver todos'**
  String get viewAll;

  /// No description provided for @candidate.
  ///
  /// In es, this message translates to:
  /// **'Candidato'**
  String get candidate;

  /// No description provided for @matchedRole.
  ///
  /// In es, this message translates to:
  /// **'Evaluación'**
  String get matchedRole;

  /// No description provided for @affinity.
  ///
  /// In es, this message translates to:
  /// **'Estado'**
  String get affinity;

  /// No description provided for @action.
  ///
  /// In es, this message translates to:
  /// **'Acción'**
  String get action;

  /// No description provided for @pendingActions.
  ///
  /// In es, this message translates to:
  /// **'Acciones pendientes'**
  String get pendingActions;

  /// No description provided for @reviewRequirements.
  ///
  /// In es, this message translates to:
  /// **'Resultados listos para revisar'**
  String get reviewRequirements;

  /// No description provided for @finalApproval.
  ///
  /// In es, this message translates to:
  /// **'Invitaciones próximas a vencer'**
  String get finalApproval;

  /// No description provided for @scheduleInterview.
  ///
  /// In es, this message translates to:
  /// **'Evaluación interrumpida'**
  String get scheduleInterview;

  /// No description provided for @statusCompleted.
  ///
  /// In es, this message translates to:
  /// **'Completada'**
  String get statusCompleted;

  /// No description provided for @statusInProgress.
  ///
  /// In es, this message translates to:
  /// **'En curso'**
  String get statusInProgress;

  /// No description provided for @statusPending.
  ///
  /// In es, this message translates to:
  /// **'Pendiente'**
  String get statusPending;

  /// No description provided for @logicalReasoningAssessment.
  ///
  /// In es, this message translates to:
  /// **'Razonamiento lógico'**
  String get logicalReasoningAssessment;

  /// No description provided for @decisionMakingAssessment.
  ///
  /// In es, this message translates to:
  /// **'Toma de decisiones'**
  String get decisionMakingAssessment;

  /// No description provided for @problemSolvingAssessment.
  ///
  /// In es, this message translates to:
  /// **'Resolución de problemas'**
  String get problemSolvingAssessment;

  /// No description provided for @completedToday.
  ///
  /// In es, this message translates to:
  /// **'Completada hoy'**
  String get completedToday;

  /// No description provided for @expiresTomorrow.
  ///
  /// In es, this message translates to:
  /// **'5 invitaciones vencen mañana'**
  String get expiresTomorrow;

  /// No description provided for @connectionInterrupted.
  ///
  /// In es, this message translates to:
  /// **'Requiere seguimiento del reclutador'**
  String get connectionInterrupted;

  /// No description provided for @invitationsTitle.
  ///
  /// In es, this message translates to:
  /// **'Invitaciones'**
  String get invitationsTitle;

  /// No description provided for @invitationsSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Habilita personas y realiza seguimiento a sus evaluaciones.'**
  String get invitationsSubtitle;

  /// No description provided for @enablePerson.
  ///
  /// In es, this message translates to:
  /// **'Habilitar persona'**
  String get enablePerson;

  /// No description provided for @enablePersonSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Asigna una evaluación y envía una invitación de acceso.'**
  String get enablePersonSubtitle;

  /// No description provided for @personName.
  ///
  /// In es, this message translates to:
  /// **'Nombre de la persona'**
  String get personName;

  /// No description provided for @personNameHint.
  ///
  /// In es, this message translates to:
  /// **'Nombre y apellido'**
  String get personNameHint;

  /// No description provided for @selectAssessment.
  ///
  /// In es, this message translates to:
  /// **'Evaluación asignada'**
  String get selectAssessment;

  /// No description provided for @invitationExpiry.
  ///
  /// In es, this message translates to:
  /// **'Vigencia de la invitación'**
  String get invitationExpiry;

  /// No description provided for @daysValue.
  ///
  /// In es, this message translates to:
  /// **'{count} días'**
  String daysValue(int count);

  /// No description provided for @optionalMessage.
  ///
  /// In es, this message translates to:
  /// **'Mensaje opcional'**
  String get optionalMessage;

  /// No description provided for @optionalMessageHint.
  ///
  /// In es, this message translates to:
  /// **'Agrega instrucciones para la persona...'**
  String get optionalMessageHint;

  /// No description provided for @sendInvitation.
  ///
  /// In es, this message translates to:
  /// **'Enviar invitación'**
  String get sendInvitation;

  /// No description provided for @invitationSent.
  ///
  /// In es, this message translates to:
  /// **'La persona fue habilitada y la invitación fue creada.'**
  String get invitationSent;

  /// No description provided for @invitationResent.
  ///
  /// In es, this message translates to:
  /// **'La invitación fue reenviada y su vigencia fue renovada.'**
  String get invitationResent;

  /// No description provided for @invitationCancelled.
  ///
  /// In es, this message translates to:
  /// **'La invitación fue cancelada.'**
  String get invitationCancelled;

  /// No description provided for @noInvitations.
  ///
  /// In es, this message translates to:
  /// **'Aún no hay personas habilitadas'**
  String get noInvitations;

  /// No description provided for @noInvitationsDescription.
  ///
  /// In es, this message translates to:
  /// **'Habilita la primera persona para asignarle una evaluación.'**
  String get noInvitationsDescription;

  /// No description provided for @expiresOn.
  ///
  /// In es, this message translates to:
  /// **'Vence: {date}'**
  String expiresOn(String date);

  /// No description provided for @resend.
  ///
  /// In es, this message translates to:
  /// **'Reenviar'**
  String get resend;

  /// No description provided for @cancelInvitation.
  ///
  /// In es, this message translates to:
  /// **'Cancelar invitación'**
  String get cancelInvitation;

  /// No description provided for @confirmCancellation.
  ///
  /// In es, this message translates to:
  /// **'¿Deseas cancelar esta invitación? La persona perderá el acceso a la evaluación.'**
  String get confirmCancellation;

  /// No description provided for @keepInvitation.
  ///
  /// In es, this message translates to:
  /// **'Conservar'**
  String get keepInvitation;

  /// No description provided for @statusExpired.
  ///
  /// In es, this message translates to:
  /// **'Vencida'**
  String get statusExpired;

  /// No description provided for @statusCancelled.
  ///
  /// In es, this message translates to:
  /// **'Cancelada'**
  String get statusCancelled;

  /// No description provided for @statusInterrupted.
  ///
  /// In es, this message translates to:
  /// **'Interrumpida'**
  String get statusInterrupted;

  /// No description provided for @settingsTitle.
  ///
  /// In es, this message translates to:
  /// **'Configuración'**
  String get settingsTitle;

  /// No description provided for @settingsSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Administra tu organización, procesos de contratación y seguridad.'**
  String get settingsSubtitle;

  /// No description provided for @saveChanges.
  ///
  /// In es, this message translates to:
  /// **'Guardar cambios'**
  String get saveChanges;

  /// No description provided for @changesSaved.
  ///
  /// In es, this message translates to:
  /// **'Los cambios se guardaron correctamente.'**
  String get changesSaved;

  /// No description provided for @organizationProfile.
  ///
  /// In es, this message translates to:
  /// **'Perfil de la organización'**
  String get organizationProfile;

  /// No description provided for @organizationDescription.
  ///
  /// In es, this message translates to:
  /// **'Información que identifica a tu empresa dentro de TaleX.'**
  String get organizationDescription;

  /// No description provided for @organizationName.
  ///
  /// In es, this message translates to:
  /// **'Nombre de la organización'**
  String get organizationName;

  /// No description provided for @industry.
  ///
  /// In es, this message translates to:
  /// **'Industria'**
  String get industry;

  /// No description provided for @companySize.
  ///
  /// In es, this message translates to:
  /// **'Tamaño de la empresa'**
  String get companySize;

  /// No description provided for @timezone.
  ///
  /// In es, this message translates to:
  /// **'Zona horaria'**
  String get timezone;

  /// No description provided for @notificationsTitle.
  ///
  /// In es, this message translates to:
  /// **'Notificaciones'**
  String get notificationsTitle;

  /// No description provided for @notificationsDescription.
  ///
  /// In es, this message translates to:
  /// **'Elige qué actualizaciones deseas recibir.'**
  String get notificationsDescription;

  /// No description provided for @candidateUpdates.
  ///
  /// In es, this message translates to:
  /// **'Actividad de evaluaciones'**
  String get candidateUpdates;

  /// No description provided for @candidateUpdatesDescription.
  ///
  /// In es, this message translates to:
  /// **'Avisos cuando una evaluación inicia, se completa o vence.'**
  String get candidateUpdatesDescription;

  /// No description provided for @weeklyDigest.
  ///
  /// In es, this message translates to:
  /// **'Resumen semanal'**
  String get weeklyDigest;

  /// No description provided for @weeklyDigestDescription.
  ///
  /// In es, this message translates to:
  /// **'Métricas y actividad del proceso cada lunes.'**
  String get weeklyDigestDescription;

  /// No description provided for @securityTitle.
  ///
  /// In es, this message translates to:
  /// **'Seguridad y acceso'**
  String get securityTitle;

  /// No description provided for @securityDescription.
  ///
  /// In es, this message translates to:
  /// **'Protege el acceso de tu equipo a la plataforma.'**
  String get securityDescription;

  /// No description provided for @twoFactorAuth.
  ///
  /// In es, this message translates to:
  /// **'Autenticación de dos factores'**
  String get twoFactorAuth;

  /// No description provided for @twoFactorDescription.
  ///
  /// In es, this message translates to:
  /// **'Solicita un segundo factor a los administradores.'**
  String get twoFactorDescription;

  /// No description provided for @sessionTimeout.
  ///
  /// In es, this message translates to:
  /// **'Tiempo de sesión'**
  String get sessionTimeout;

  /// No description provided for @manageMembers.
  ///
  /// In es, this message translates to:
  /// **'Administrar miembros'**
  String get manageMembers;

  /// No description provided for @technologyIndustry.
  ///
  /// In es, this message translates to:
  /// **'Tecnología'**
  String get technologyIndustry;

  /// No description provided for @employeesRange.
  ///
  /// In es, this message translates to:
  /// **'51–200 empleados'**
  String get employeesRange;

  /// No description provided for @minutes30.
  ///
  /// In es, this message translates to:
  /// **'30 minutos'**
  String get minutes30;

  /// No description provided for @adminCommandCenter.
  ///
  /// In es, this message translates to:
  /// **'Centro de mando'**
  String get adminCommandCenter;

  /// No description provided for @adminCommandSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Una lectura ejecutiva de TaleX: operación, clientes y crecimiento.'**
  String get adminCommandSubtitle;

  /// No description provided for @adminCompanies.
  ///
  /// In es, this message translates to:
  /// **'Empresas'**
  String get adminCompanies;

  /// No description provided for @adminProcesses.
  ///
  /// In es, this message translates to:
  /// **'Procesos'**
  String get adminProcesses;

  /// No description provided for @adminPeople.
  ///
  /// In es, this message translates to:
  /// **'Personas'**
  String get adminPeople;

  /// No description provided for @adminAffinity.
  ///
  /// In es, this message translates to:
  /// **'Afinidad'**
  String get adminAffinity;

  /// No description provided for @adminCommercial.
  ///
  /// In es, this message translates to:
  /// **'Comercial'**
  String get adminCommercial;

  /// No description provided for @adminSales.
  ///
  /// In es, this message translates to:
  /// **'Ventas'**
  String get adminSales;

  /// No description provided for @adminAnalytics.
  ///
  /// In es, this message translates to:
  /// **'Analytics'**
  String get adminAnalytics;

  /// No description provided for @adminAlerts.
  ///
  /// In es, this message translates to:
  /// **'Alertas'**
  String get adminAlerts;

  /// No description provided for @adminXebec.
  ///
  /// In es, this message translates to:
  /// **'Xebec'**
  String get adminXebec;

  /// No description provided for @adminSettings.
  ///
  /// In es, this message translates to:
  /// **'Configuración'**
  String get adminSettings;

  /// No description provided for @adminSearchHint.
  ///
  /// In es, this message translates to:
  /// **'Buscar empresas, procesos o personas...'**
  String get adminSearchHint;

  /// No description provided for @kpiTotalCompanies.
  ///
  /// In es, this message translates to:
  /// **'Empresas totales'**
  String get kpiTotalCompanies;

  /// No description provided for @kpiActiveCompanies.
  ///
  /// In es, this message translates to:
  /// **'Empresas activas'**
  String get kpiActiveCompanies;

  /// No description provided for @kpiEvaluatedPeople.
  ///
  /// In es, this message translates to:
  /// **'Personas evaluadas'**
  String get kpiEvaluatedPeople;

  /// No description provided for @kpiCompletedEvaluations.
  ///
  /// In es, this message translates to:
  /// **'Evaluaciones completadas'**
  String get kpiCompletedEvaluations;

  /// No description provided for @kpiAffinities.
  ///
  /// In es, this message translates to:
  /// **'Afinidades detectadas'**
  String get kpiAffinities;

  /// No description provided for @kpiPeriodSales.
  ///
  /// In es, this message translates to:
  /// **'Ventas del periodo'**
  String get kpiPeriodSales;

  /// No description provided for @kpiMrr.
  ///
  /// In es, this message translates to:
  /// **'MRR'**
  String get kpiMrr;

  /// No description provided for @kpiAtRisk.
  ///
  /// In es, this message translates to:
  /// **'Empresas en riesgo'**
  String get kpiAtRisk;

  /// No description provided for @recentActivity.
  ///
  /// In es, this message translates to:
  /// **'Actividad reciente'**
  String get recentActivity;

  /// No description provided for @noActivity.
  ///
  /// In es, this message translates to:
  /// **'Aún no hay actividad registrada.'**
  String get noActivity;

  /// No description provided for @talexFunnel.
  ///
  /// In es, this message translates to:
  /// **'Embudo TaleX'**
  String get talexFunnel;

  /// No description provided for @funnelCompanies.
  ///
  /// In es, this message translates to:
  /// **'Empresas'**
  String get funnelCompanies;

  /// No description provided for @funnelProcesses.
  ///
  /// In es, this message translates to:
  /// **'Procesos'**
  String get funnelProcesses;

  /// No description provided for @funnelInvited.
  ///
  /// In es, this message translates to:
  /// **'Personas invitadas'**
  String get funnelInvited;

  /// No description provided for @funnelStarted.
  ///
  /// In es, this message translates to:
  /// **'Evaluaciones iniciadas'**
  String get funnelStarted;

  /// No description provided for @funnelCompleted.
  ///
  /// In es, this message translates to:
  /// **'Evaluaciones completadas'**
  String get funnelCompleted;

  /// No description provided for @funnelAffinities.
  ///
  /// In es, this message translates to:
  /// **'Afinidades detectadas'**
  String get funnelAffinities;

  /// No description provided for @funnelDecisions.
  ///
  /// In es, this message translates to:
  /// **'Resultados / decisiones'**
  String get funnelDecisions;

  /// No description provided for @noData.
  ///
  /// In es, this message translates to:
  /// **'Sin datos'**
  String get noData;

  /// No description provided for @noInformationYet.
  ///
  /// In es, this message translates to:
  /// **'Aún no hay información.'**
  String get noInformationYet;

  /// No description provided for @retry.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get retry;

  /// No description provided for @newCompany.
  ///
  /// In es, this message translates to:
  /// **'Nueva empresa'**
  String get newCompany;

  /// No description provided for @newProcess.
  ///
  /// In es, this message translates to:
  /// **'Nuevo proceso'**
  String get newProcess;

  /// No description provided for @newPerson.
  ///
  /// In es, this message translates to:
  /// **'Registrar persona'**
  String get newPerson;

  /// No description provided for @newDeal.
  ///
  /// In es, this message translates to:
  /// **'Nueva oportunidad'**
  String get newDeal;

  /// No description provided for @newSale.
  ///
  /// In es, this message translates to:
  /// **'Registrar venta'**
  String get newSale;

  /// No description provided for @companyStatusActive.
  ///
  /// In es, this message translates to:
  /// **'Activa'**
  String get companyStatusActive;

  /// No description provided for @companyStatusOnboarding.
  ///
  /// In es, this message translates to:
  /// **'En onboarding'**
  String get companyStatusOnboarding;

  /// No description provided for @companyStatusInactive.
  ///
  /// In es, this message translates to:
  /// **'Inactiva'**
  String get companyStatusInactive;

  /// No description provided for @companyStatusAtRisk.
  ///
  /// In es, this message translates to:
  /// **'En riesgo'**
  String get companyStatusAtRisk;

  /// No description provided for @companyStatusSuspended.
  ///
  /// In es, this message translates to:
  /// **'Suspendida'**
  String get companyStatusSuspended;

  /// No description provided for @processStatusActive.
  ///
  /// In es, this message translates to:
  /// **'Activo'**
  String get processStatusActive;

  /// No description provided for @processStatusClosed.
  ///
  /// In es, this message translates to:
  /// **'Cerrado'**
  String get processStatusClosed;

  /// No description provided for @evaluationInvited.
  ///
  /// In es, this message translates to:
  /// **'Invitada'**
  String get evaluationInvited;

  /// No description provided for @evaluationStarted.
  ///
  /// In es, this message translates to:
  /// **'Iniciada'**
  String get evaluationStarted;

  /// No description provided for @evaluationInProgress.
  ///
  /// In es, this message translates to:
  /// **'En progreso'**
  String get evaluationInProgress;

  /// No description provided for @evaluationCompleted.
  ///
  /// In es, this message translates to:
  /// **'Completada'**
  String get evaluationCompleted;

  /// No description provided for @evaluationAbandoned.
  ///
  /// In es, this message translates to:
  /// **'Abandonada'**
  String get evaluationAbandoned;

  /// No description provided for @affinityHigh.
  ///
  /// In es, this message translates to:
  /// **'Afinidad alta'**
  String get affinityHigh;

  /// No description provided for @affinityMedium.
  ///
  /// In es, this message translates to:
  /// **'Afinidad media'**
  String get affinityMedium;

  /// No description provided for @affinityLow.
  ///
  /// In es, this message translates to:
  /// **'Afinidad baja'**
  String get affinityLow;

  /// No description provided for @affinityUnknown.
  ///
  /// In es, this message translates to:
  /// **'Sin clasificar'**
  String get affinityUnknown;

  /// No description provided for @dealProspect.
  ///
  /// In es, this message translates to:
  /// **'Prospecto'**
  String get dealProspect;

  /// No description provided for @dealContacted.
  ///
  /// In es, this message translates to:
  /// **'Contactado'**
  String get dealContacted;

  /// No description provided for @dealMeeting.
  ///
  /// In es, this message translates to:
  /// **'Reunión'**
  String get dealMeeting;

  /// No description provided for @dealProposal.
  ///
  /// In es, this message translates to:
  /// **'Propuesta'**
  String get dealProposal;

  /// No description provided for @dealNegotiation.
  ///
  /// In es, this message translates to:
  /// **'Negociación'**
  String get dealNegotiation;

  /// No description provided for @dealClient.
  ///
  /// In es, this message translates to:
  /// **'Cliente'**
  String get dealClient;

  /// No description provided for @filterAll.
  ///
  /// In es, this message translates to:
  /// **'Todos'**
  String get filterAll;

  /// No description provided for @lastActivity.
  ///
  /// In es, this message translates to:
  /// **'Última actividad'**
  String get lastActivity;

  /// No description provided for @joinedAt.
  ///
  /// In es, this message translates to:
  /// **'Incorporación'**
  String get joinedAt;

  /// No description provided for @openDetail.
  ///
  /// In es, this message translates to:
  /// **'Abrir detalle'**
  String get openDetail;

  /// No description provided for @backToCompanies.
  ///
  /// In es, this message translates to:
  /// **'Volver a empresas'**
  String get backToCompanies;

  /// No description provided for @companyOverview.
  ///
  /// In es, this message translates to:
  /// **'Resumen'**
  String get companyOverview;

  /// No description provided for @companyCommercial.
  ///
  /// In es, this message translates to:
  /// **'Comercial'**
  String get companyCommercial;

  /// No description provided for @companyMetrics.
  ///
  /// In es, this message translates to:
  /// **'Utilización'**
  String get companyMetrics;

  /// No description provided for @noCompanies.
  ///
  /// In es, this message translates to:
  /// **'Todavía no hay empresas en TaleX.'**
  String get noCompanies;

  /// No description provided for @noProcesses.
  ///
  /// In es, this message translates to:
  /// **'No hay procesos para mostrar.'**
  String get noProcesses;

  /// No description provided for @noPeople.
  ///
  /// In es, this message translates to:
  /// **'No hay personas evaluadas para mostrar. No se exponen respuestas sensibles.'**
  String get noPeople;

  /// No description provided for @noDeals.
  ///
  /// In es, this message translates to:
  /// **'No hay oportunidades en el pipeline.'**
  String get noDeals;

  /// No description provided for @noSales.
  ///
  /// In es, this message translates to:
  /// **'No hay ventas registradas en este periodo.'**
  String get noSales;

  /// No description provided for @noAlerts.
  ///
  /// In es, this message translates to:
  /// **'No hay alertas calculadas con los datos actuales.'**
  String get noAlerts;

  /// No description provided for @period7.
  ///
  /// In es, this message translates to:
  /// **'7 días'**
  String get period7;

  /// No description provided for @period30.
  ///
  /// In es, this message translates to:
  /// **'30 días'**
  String get period30;

  /// No description provided for @period90.
  ///
  /// In es, this message translates to:
  /// **'90 días'**
  String get period90;

  /// No description provided for @period12m.
  ///
  /// In es, this message translates to:
  /// **'12 meses'**
  String get period12m;

  /// No description provided for @completionRate.
  ///
  /// In es, this message translates to:
  /// **'Tasa de finalización'**
  String get completionRate;

  /// No description provided for @suggestedAction.
  ///
  /// In es, this message translates to:
  /// **'Acción sugerida'**
  String get suggestedAction;

  /// No description provided for @xebecSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Xebec responde con el contexto real del centro de mando.'**
  String get xebecSubtitle;

  /// No description provided for @xebecPlaceholder.
  ///
  /// In es, this message translates to:
  /// **'¿Cómo está TaleX?'**
  String get xebecPlaceholder;

  /// No description provided for @xebecEmpty.
  ///
  /// In es, this message translates to:
  /// **'Pregunta por el estado de TaleX, empresas en riesgo u oportunidades. Xebec usa métricas reales, no suposiciones.'**
  String get xebecEmpty;

  /// No description provided for @askXebec.
  ///
  /// In es, this message translates to:
  /// **'Preguntar'**
  String get askXebec;

  /// No description provided for @adminSettingsSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Usuarios, roles y parámetros reales del sistema. Nada ficticio.'**
  String get adminSettingsSubtitle;

  /// No description provided for @superAdminHelp.
  ///
  /// In es, this message translates to:
  /// **'El SuperAdmin se eleva si su correo está en config/superadmin.emails o si el documento de usuario ya tiene role=superadmin. Las credenciales viven en Firebase Auth; cámbialas con recuperación de contraseña o la consola.'**
  String get superAdminHelp;

  /// No description provided for @adminUsers.
  ///
  /// In es, this message translates to:
  /// **'Usuarios'**
  String get adminUsers;

  /// No description provided for @roleLabel.
  ///
  /// In es, this message translates to:
  /// **'Rol'**
  String get roleLabel;

  /// No description provided for @adminSaved.
  ///
  /// In es, this message translates to:
  /// **'Los cambios se guardaron en TaleX.'**
  String get adminSaved;

  /// No description provided for @amount.
  ///
  /// In es, this message translates to:
  /// **'Importe'**
  String get amount;

  /// No description provided for @plan.
  ///
  /// In es, this message translates to:
  /// **'Plan'**
  String get plan;

  /// No description provided for @owner.
  ///
  /// In es, this message translates to:
  /// **'Responsable'**
  String get owner;

  /// No description provided for @nextAction.
  ///
  /// In es, this message translates to:
  /// **'Próxima acción'**
  String get nextAction;

  /// No description provided for @product.
  ///
  /// In es, this message translates to:
  /// **'Producto o servicio'**
  String get product;

  /// No description provided for @recurring.
  ///
  /// In es, this message translates to:
  /// **'Recurrente (MRR)'**
  String get recurring;

  /// No description provided for @estimatedValue.
  ///
  /// In es, this message translates to:
  /// **'Valor estimado'**
  String get estimatedValue;

  /// No description provided for @affinityScore.
  ///
  /// In es, this message translates to:
  /// **'Puntaje de afinidad (0-100)'**
  String get affinityScore;

  /// No description provided for @statusLabel.
  ///
  /// In es, this message translates to:
  /// **'Estado'**
  String get statusLabel;

  /// No description provided for @priorityHigh.
  ///
  /// In es, this message translates to:
  /// **'Alta'**
  String get priorityHigh;

  /// No description provided for @priorityMedium.
  ///
  /// In es, this message translates to:
  /// **'Media'**
  String get priorityMedium;

  /// No description provided for @priorityLow.
  ///
  /// In es, this message translates to:
  /// **'Baja'**
  String get priorityLow;

  /// No description provided for @alertRisk.
  ///
  /// In es, this message translates to:
  /// **'Riesgo'**
  String get alertRisk;

  /// No description provided for @alertOperational.
  ///
  /// In es, this message translates to:
  /// **'Operacional'**
  String get alertOperational;

  /// No description provided for @alertCommercial.
  ///
  /// In es, this message translates to:
  /// **'Comercial'**
  String get alertCommercial;

  /// No description provided for @alertProduct.
  ///
  /// In es, this message translates to:
  /// **'Producto'**
  String get alertProduct;

  /// No description provided for @alertOpportunity.
  ///
  /// In es, this message translates to:
  /// **'Oportunidad'**
  String get alertOpportunity;

  /// No description provided for @salesPeriod.
  ///
  /// In es, this message translates to:
  /// **'Ventas del periodo'**
  String get salesPeriod;

  /// No description provided for @salesCumulative.
  ///
  /// In es, this message translates to:
  /// **'Ventas acumuladas'**
  String get salesCumulative;

  /// No description provided for @newCustomers.
  ///
  /// In es, this message translates to:
  /// **'Clientes en el periodo'**
  String get newCustomers;

  /// No description provided for @averageTicket.
  ///
  /// In es, this message translates to:
  /// **'Ticket promedio'**
  String get averageTicket;

  /// No description provided for @growth.
  ///
  /// In es, this message translates to:
  /// **'Crecimiento vs periodo anterior'**
  String get growth;

  /// No description provided for @activityByDay.
  ///
  /// In es, this message translates to:
  /// **'Actividad por día'**
  String get activityByDay;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
