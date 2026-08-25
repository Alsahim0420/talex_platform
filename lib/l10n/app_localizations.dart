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
