import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talex_platform/features/auth/presentation/bloc/auth_bloc.dart';

const _ink = Color(0xFF071326);
const _muted = Color(0xFF76777C);
const _accent = Color(0xFF4547E5);

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthBloc>().add(
      AuthSignInRequested(email: _email.text.trim(), password: _password.text),
    );
  }

  void _forgotPassword() => context.read<AuthBloc>().add(
    AuthPasswordResetRequested(email: _email.text.trim()),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFFBF9FA),
    body: BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        final message =
            state.failure?.message ??
            (state.status == AuthStatus.passwordResetSent
                ? 'Revisa tu correo para restablecer la contraseña.'
                : null);
        if (message != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: constraints.maxHeight < 800 ? 64 : 208),
                  const Text(
                    'TaleX',
                    style: TextStyle(
                      color: _ink,
                      fontSize: 48,
                      height: 1,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -2.2,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Enterprise Logic',
                    style: TextStyle(
                      color: Color(0xFF45464A),
                      fontSize: 16,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 34),
                  _LoginCard(
                    formKey: _formKey,
                    email: _email,
                    password: _password,
                    onSubmit: _submit,
                    onForgot: _forgotPassword,
                  ),
                  const SizedBox(height: 38),
                  const _LegalFooter(),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class _LoginCard extends StatelessWidget {
  const _LoginCard({
    required this.formKey,
    required this.email,
    required this.password,
    required this.onSubmit,
    required this.onForgot,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController email;
  final TextEditingController password;
  final VoidCallback onSubmit;
  final VoidCallback onForgot;

  @override
  Widget build(BuildContext context) => Container(
    width: 448,
    padding: const EdgeInsets.fromLTRB(32, 34, 32, 32),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFDEDEDE)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0A071326),
          blurRadius: 16,
          offset: Offset(0, 7),
        ),
      ],
    ),
    child: Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Secure Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _ink,
              fontSize: 24,
              height: 1.2,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 27),
          const _FieldLabel('Work Email'),
          const SizedBox(height: 8),
          _LoginField(
            controller: email,
            hint: 'executive@company.com',
            icon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => value == null || !value.contains('@')
                ? 'Enter a valid work email'
                : null,
          ),
          const SizedBox(height: 22),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const _FieldLabel('Password'),
              TextButton(
                onPressed: onForgot,
                style: TextButton.styleFrom(
                  foregroundColor: _accent,
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: const Text('Forgot password?'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _LoginField(
            controller: password,
            hint: '••••••••',
            icon: Icons.lock_outline_rounded,
            obscureText: true,
            onSubmitted: (_) => onSubmit(),
            validator: (value) => (value?.length ?? 0) < 6
                ? 'Password must have at least 6 characters'
                : null,
          ),
          const SizedBox(height: 24),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) => SizedBox(
              height: 36,
              child: FilledButton(
                onPressed: state.status == AuthStatus.loading ? null : onSubmit,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF1E2A3D),
                  disabledBackgroundColor: const Color(0xFF1E2A3D),
                  shape: const RoundedRectangleBorder(),
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                child: state.status == AuthStatus.loading
                    ? const SizedBox.square(
                        dimension: 17,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Sign In'),
              ),
            ),
          ),
          const SizedBox(height: 25),
          const _DividerLabel(),
          const SizedBox(height: 24),
          SizedBox(
            height: 42,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: _ink,
                side: const BorderSide(color: Color(0xFFE1E1E1)),
                shape: const RoundedRectangleBorder(),
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _LinkedInMark(),
                  SizedBox(width: 9),
                  Text('Sign in with LinkedIn'),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(
      color: _ink,
      fontSize: 15,
      height: 1.2,
      fontWeight: FontWeight.w600,
    ),
  );
}

class _LoginField extends StatelessWidget {
  const _LoginField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.onSubmitted,
  });
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 43,
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onFieldSubmitted: onSubmitted,
      style: const TextStyle(color: _ink, fontSize: 15),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: _muted, fontSize: 15),
        prefixIcon: Icon(icon, color: _muted, size: 21),
        contentPadding: const EdgeInsets.symmetric(vertical: 11),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: Color(0xFFBFC1C8)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: Color(0xFFBFC1C8)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: _ink, width: 1.2),
        ),
        errorStyle: const TextStyle(height: 0, fontSize: 0),
      ),
    ),
  );
}

class _DividerLabel extends StatelessWidget {
  const _DividerLabel();
  @override
  Widget build(BuildContext context) => const Row(
    children: [
      Expanded(child: Divider(color: Color(0xFFE2E2E2), height: 1)),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 9),
        child: Text(
          'Or continue with',
          style: TextStyle(
            color: Color(0xFF45464A),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      Expanded(child: Divider(color: Color(0xFFE2E2E2), height: 1)),
    ],
  );
}

class _LinkedInMark extends StatelessWidget {
  const _LinkedInMark();
  @override
  Widget build(BuildContext context) => Container(
    width: 20,
    height: 20,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: const Color(0xFF087CB7),
      borderRadius: BorderRadius.circular(2),
    ),
    child: const Text(
      'in',
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
        height: 1,
        fontWeight: FontWeight.w800,
        letterSpacing: -1,
      ),
    ),
  );
}

class _LegalFooter extends StatelessWidget {
  const _LegalFooter();
  @override
  Widget build(BuildContext context) => const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Privacy Policy',
        style: TextStyle(
          color: Color(0xFF4A4A4E),
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 23),
        child: Text(
          '•',
          style: TextStyle(color: Color(0xFFDEDEDE), fontSize: 13),
        ),
      ),
      Text(
        'Terms of Service',
        style: TextStyle(
          color: Color(0xFF4A4A4E),
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}
