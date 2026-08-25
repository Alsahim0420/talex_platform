// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'TaleX';

  @override
  String get secureSignIn => 'Inicio de sesión seguro';

  @override
  String get workEmail => 'Correo electrónico';

  @override
  String get emailAddress => 'Correo electrónico';

  @override
  String get emailAddressHint => 'candidato@correo.com';

  @override
  String get validEmailAddressError => 'Ingresa un correo electrónico válido';

  @override
  String get emailHint => 'correo@ejemplo.com';

  @override
  String get password => 'Contraseña';

  @override
  String get forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get continueWith => 'O continúa con';

  @override
  String get signInGoogle => 'Iniciar sesión con Google';

  @override
  String get signUpGoogle => 'Crear cuenta con Google';

  @override
  String get googleSignInError =>
      'No se pudo iniciar sesión con Google. Inténtalo nuevamente.';

  @override
  String get newToTalex => '¿Nuevo en TaleX?';

  @override
  String get createAccountLink => 'Crear cuenta';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get termsOfService => 'Términos del servicio';

  @override
  String get validEmailError => 'Ingresa un correo electrónico válido';

  @override
  String get passwordLengthError =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get resetEmailSent =>
      'Revisa tu correo para restablecer la contraseña.';

  @override
  String get createAccount => 'Crea tu cuenta';

  @override
  String get registerSubtitle => 'Crea tu cuenta para comenzar en TaleX.';

  @override
  String get fullName => 'Nombre completo';

  @override
  String get fullNameHint => 'María Pérez';

  @override
  String get companyName => 'Nombre de la empresa';

  @override
  String get companyHint => 'Empresa S.A.S.';

  @override
  String get signUp => 'Registrarse';

  @override
  String get alreadyHaveAccount => '¿Ya tienes una cuenta?';

  @override
  String get logIn => 'Inicia sesión';

  @override
  String get requiredField => 'Este campo es obligatorio';

  @override
  String get testimonial =>
      '“TaleX transformó nuestro proceso de selección y ayudó a nuestro equipo a tomar mejores decisiones.”';

  @override
  String get testimonialName => 'Sarah Jenkins';

  @override
  String get testimonialRole => 'VP de Ingeniería, Nexus Dynamics';

  @override
  String welcomeUser(String name) {
    return 'Bienvenido, $name';
  }

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String get dashboard => 'Panel principal';

  @override
  String get roles => 'Invitaciones';

  @override
  String get candidates => 'Personas habilitadas';

  @override
  String get assessments => 'Evaluaciones';

  @override
  String get managers => 'Equipo';

  @override
  String get reports => 'Reportes';

  @override
  String get settings => 'Configuración';

  @override
  String get support => 'Soporte';

  @override
  String get documentation => 'Documentación';

  @override
  String get searchHint => 'Buscar personas, invitaciones o evaluaciones...';

  @override
  String get overview => 'Resumen';

  @override
  String get overviewSubtitle =>
      'Seguimiento general de las evaluaciones asignadas por tu equipo.';

  @override
  String get generateReport => 'Generar reporte';

  @override
  String get newRole => 'Habilitar persona';

  @override
  String get activeRoles => 'Invitaciones enviadas';

  @override
  String get evaluatedCandidates => 'Pendientes de iniciar';

  @override
  String get averageFitScore => 'Evaluaciones en curso';

  @override
  String get hiringVelocity => 'Evaluaciones completadas';

  @override
  String get thisWeekChange => '+8 esta semana';

  @override
  String get thisMonthChange => '5 vencen próximamente';

  @override
  String get stableTopRoles => 'Actividad en tiempo real';

  @override
  String get daysFromQuarter => '+42 este mes';

  @override
  String get topMatches => 'Actividad reciente';

  @override
  String get viewAll => 'Ver todos';

  @override
  String get candidate => 'Candidato';

  @override
  String get matchedRole => 'Evaluación';

  @override
  String get affinity => 'Estado';

  @override
  String get action => 'Acción';

  @override
  String get pendingActions => 'Acciones pendientes';

  @override
  String get reviewRequirements => 'Resultados listos para revisar';

  @override
  String get finalApproval => 'Invitaciones próximas a vencer';

  @override
  String get scheduleInterview => 'Evaluación interrumpida';

  @override
  String get statusCompleted => 'Completada';

  @override
  String get statusInProgress => 'En curso';

  @override
  String get statusPending => 'Pendiente';

  @override
  String get logicalReasoningAssessment => 'Razonamiento lógico';

  @override
  String get decisionMakingAssessment => 'Toma de decisiones';

  @override
  String get problemSolvingAssessment => 'Resolución de problemas';

  @override
  String get completedToday => 'Completada hoy';

  @override
  String get expiresTomorrow => '5 invitaciones vencen mañana';

  @override
  String get connectionInterrupted => 'Requiere seguimiento del reclutador';

  @override
  String get invitationsTitle => 'Invitaciones';

  @override
  String get invitationsSubtitle =>
      'Habilita personas y realiza seguimiento a sus evaluaciones.';

  @override
  String get enablePerson => 'Habilitar persona';

  @override
  String get enablePersonSubtitle =>
      'Asigna una evaluación y envía una invitación de acceso.';

  @override
  String get personName => 'Nombre de la persona';

  @override
  String get personNameHint => 'Nombre y apellido';

  @override
  String get selectAssessment => 'Evaluación asignada';

  @override
  String get invitationExpiry => 'Vigencia de la invitación';

  @override
  String daysValue(int count) {
    return '$count días';
  }

  @override
  String get optionalMessage => 'Mensaje opcional';

  @override
  String get optionalMessageHint => 'Agrega instrucciones para la persona...';

  @override
  String get sendInvitation => 'Enviar invitación';

  @override
  String get invitationSent =>
      'La persona fue habilitada y la invitación fue creada.';

  @override
  String get invitationResent =>
      'La invitación fue reenviada y su vigencia fue renovada.';

  @override
  String get invitationCancelled => 'La invitación fue cancelada.';

  @override
  String get noInvitations => 'Aún no hay personas habilitadas';

  @override
  String get noInvitationsDescription =>
      'Habilita la primera persona para asignarle una evaluación.';

  @override
  String expiresOn(String date) {
    return 'Vence: $date';
  }

  @override
  String get resend => 'Reenviar';

  @override
  String get cancelInvitation => 'Cancelar invitación';

  @override
  String get confirmCancellation =>
      '¿Deseas cancelar esta invitación? La persona perderá el acceso a la evaluación.';

  @override
  String get keepInvitation => 'Conservar';

  @override
  String get statusExpired => 'Vencida';

  @override
  String get statusCancelled => 'Cancelada';

  @override
  String get statusInterrupted => 'Interrumpida';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get settingsSubtitle =>
      'Administra tu organización, procesos de contratación y seguridad.';

  @override
  String get saveChanges => 'Guardar cambios';

  @override
  String get changesSaved => 'Los cambios se guardaron correctamente.';

  @override
  String get organizationProfile => 'Perfil de la organización';

  @override
  String get organizationDescription =>
      'Información que identifica a tu empresa dentro de TaleX.';

  @override
  String get organizationName => 'Nombre de la organización';

  @override
  String get industry => 'Industria';

  @override
  String get companySize => 'Tamaño de la empresa';

  @override
  String get timezone => 'Zona horaria';

  @override
  String get notificationsTitle => 'Notificaciones';

  @override
  String get notificationsDescription =>
      'Elige qué actualizaciones deseas recibir.';

  @override
  String get candidateUpdates => 'Actividad de evaluaciones';

  @override
  String get candidateUpdatesDescription =>
      'Avisos cuando una evaluación inicia, se completa o vence.';

  @override
  String get weeklyDigest => 'Resumen semanal';

  @override
  String get weeklyDigestDescription =>
      'Métricas y actividad del proceso cada lunes.';

  @override
  String get securityTitle => 'Seguridad y acceso';

  @override
  String get securityDescription =>
      'Protege el acceso de tu equipo a la plataforma.';

  @override
  String get twoFactorAuth => 'Autenticación de dos factores';

  @override
  String get twoFactorDescription =>
      'Solicita un segundo factor a los administradores.';

  @override
  String get sessionTimeout => 'Tiempo de sesión';

  @override
  String get manageMembers => 'Administrar miembros';

  @override
  String get technologyIndustry => 'Tecnología';

  @override
  String get employeesRange => '51–200 empleados';

  @override
  String get minutes30 => '30 minutos';
}
