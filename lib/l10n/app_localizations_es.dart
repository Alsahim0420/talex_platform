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

  @override
  String get adminCommandCenter => 'Centro de mando';

  @override
  String get adminCommandSubtitle =>
      'Una lectura ejecutiva de TaleX: operación, clientes y crecimiento.';

  @override
  String get adminCompanies => 'Empresas';

  @override
  String get adminProcesses => 'Procesos';

  @override
  String get adminPeople => 'Personas';

  @override
  String get adminAffinity => 'Afinidad';

  @override
  String get adminCommercial => 'Comercial';

  @override
  String get adminSales => 'Ventas';

  @override
  String get adminAnalytics => 'Analytics';

  @override
  String get adminAlerts => 'Alertas';

  @override
  String get adminXebec => 'Xebec';

  @override
  String get adminSettings => 'Configuración';

  @override
  String get adminSearchHint => 'Buscar empresas, procesos o personas...';

  @override
  String get kpiTotalCompanies => 'Empresas totales';

  @override
  String get kpiActiveCompanies => 'Empresas activas';

  @override
  String get kpiEvaluatedPeople => 'Personas evaluadas';

  @override
  String get kpiCompletedEvaluations => 'Evaluaciones completadas';

  @override
  String get kpiAffinities => 'Afinidades detectadas';

  @override
  String get kpiPeriodSales => 'Ventas del periodo';

  @override
  String get kpiMrr => 'MRR';

  @override
  String get kpiAtRisk => 'Empresas en riesgo';

  @override
  String get recentActivity => 'Actividad reciente';

  @override
  String get noActivity => 'Aún no hay actividad registrada.';

  @override
  String get talexFunnel => 'Embudo TaleX';

  @override
  String get funnelCompanies => 'Empresas';

  @override
  String get funnelProcesses => 'Procesos';

  @override
  String get funnelInvited => 'Personas invitadas';

  @override
  String get funnelStarted => 'Evaluaciones iniciadas';

  @override
  String get funnelCompleted => 'Evaluaciones completadas';

  @override
  String get funnelAffinities => 'Afinidades detectadas';

  @override
  String get funnelDecisions => 'Resultados / decisiones';

  @override
  String get noData => 'Sin datos';

  @override
  String get noInformationYet => 'Aún no hay información.';

  @override
  String get retry => 'Reintentar';

  @override
  String get newCompany => 'Nueva empresa';

  @override
  String get newProcess => 'Nuevo proceso';

  @override
  String get newPerson => 'Registrar persona';

  @override
  String get newDeal => 'Nueva oportunidad';

  @override
  String get newSale => 'Registrar venta';

  @override
  String get companyStatusActive => 'Activa';

  @override
  String get companyStatusOnboarding => 'En onboarding';

  @override
  String get companyStatusInactive => 'Inactiva';

  @override
  String get companyStatusAtRisk => 'En riesgo';

  @override
  String get companyStatusSuspended => 'Suspendida';

  @override
  String get processStatusActive => 'Activo';

  @override
  String get processStatusClosed => 'Cerrado';

  @override
  String get evaluationInvited => 'Invitada';

  @override
  String get evaluationStarted => 'Iniciada';

  @override
  String get evaluationInProgress => 'En progreso';

  @override
  String get evaluationCompleted => 'Completada';

  @override
  String get evaluationAbandoned => 'Abandonada';

  @override
  String get affinityHigh => 'Afinidad alta';

  @override
  String get affinityMedium => 'Afinidad media';

  @override
  String get affinityLow => 'Afinidad baja';

  @override
  String get affinityUnknown => 'Sin clasificar';

  @override
  String get dealProspect => 'Prospecto';

  @override
  String get dealContacted => 'Contactado';

  @override
  String get dealMeeting => 'Reunión';

  @override
  String get dealProposal => 'Propuesta';

  @override
  String get dealNegotiation => 'Negociación';

  @override
  String get dealClient => 'Cliente';

  @override
  String get filterAll => 'Todos';

  @override
  String get lastActivity => 'Última actividad';

  @override
  String get joinedAt => 'Incorporación';

  @override
  String get openDetail => 'Abrir detalle';

  @override
  String get backToCompanies => 'Volver a empresas';

  @override
  String get companyOverview => 'Resumen';

  @override
  String get companyCommercial => 'Comercial';

  @override
  String get companyMetrics => 'Utilización';

  @override
  String get noCompanies => 'Todavía no hay empresas en TaleX.';

  @override
  String get noProcesses => 'No hay procesos para mostrar.';

  @override
  String get noPeople =>
      'No hay personas evaluadas para mostrar. No se exponen respuestas sensibles.';

  @override
  String get noDeals => 'No hay oportunidades en el pipeline.';

  @override
  String get noSales => 'No hay ventas registradas en este periodo.';

  @override
  String get noAlerts => 'No hay alertas calculadas con los datos actuales.';

  @override
  String get period7 => '7 días';

  @override
  String get period30 => '30 días';

  @override
  String get period90 => '90 días';

  @override
  String get period12m => '12 meses';

  @override
  String get completionRate => 'Tasa de finalización';

  @override
  String get suggestedAction => 'Acción sugerida';

  @override
  String get xebecSubtitle =>
      'Xebec responde con el contexto real del centro de mando.';

  @override
  String get xebecPlaceholder => '¿Cómo está TaleX?';

  @override
  String get xebecEmpty =>
      'Pregunta por el estado de TaleX, empresas en riesgo u oportunidades. Xebec usa métricas reales, no suposiciones.';

  @override
  String get askXebec => 'Preguntar';

  @override
  String get adminSettingsSubtitle =>
      'Usuarios, roles y parámetros reales del sistema. Nada ficticio.';

  @override
  String get superAdminHelp =>
      'El SuperAdmin se eleva si su correo está en config/superadmin.emails o si el documento de usuario ya tiene role=superadmin. Las credenciales viven en Firebase Auth; cámbialas con recuperación de contraseña o la consola.';

  @override
  String get adminUsers => 'Usuarios';

  @override
  String get roleLabel => 'Rol';

  @override
  String get adminSaved => 'Los cambios se guardaron en TaleX.';

  @override
  String get amount => 'Importe';

  @override
  String get plan => 'Plan';

  @override
  String get owner => 'Responsable';

  @override
  String get nextAction => 'Próxima acción';

  @override
  String get product => 'Producto o servicio';

  @override
  String get recurring => 'Recurrente (MRR)';

  @override
  String get estimatedValue => 'Valor estimado';

  @override
  String get affinityScore => 'Puntaje de afinidad (0-100)';

  @override
  String get statusLabel => 'Estado';

  @override
  String get priorityHigh => 'Alta';

  @override
  String get priorityMedium => 'Media';

  @override
  String get priorityLow => 'Baja';

  @override
  String get alertRisk => 'Riesgo';

  @override
  String get alertOperational => 'Operacional';

  @override
  String get alertCommercial => 'Comercial';

  @override
  String get alertProduct => 'Producto';

  @override
  String get alertOpportunity => 'Oportunidad';

  @override
  String get salesPeriod => 'Ventas del periodo';

  @override
  String get salesCumulative => 'Ventas acumuladas';

  @override
  String get newCustomers => 'Clientes en el periodo';

  @override
  String get averageTicket => 'Ticket promedio';

  @override
  String get growth => 'Crecimiento vs periodo anterior';

  @override
  String get activityByDay => 'Actividad por día';
}
