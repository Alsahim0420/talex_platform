import 'package:flutter/material.dart';
import 'package:talex_platform/core/constants/app_colors.dart';
import 'package:talex_platform/features/auth/presentation/widgets/auth_field.dart';
import 'package:talex_platform/features/auth/presentation/widgets/auth_social_button.dart';

class AuthRegisterForm extends StatelessWidget {
  const AuthRegisterForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.companyController,
    required this.passwordController,
    required this.onSubmit,
    required this.onLogin,
    this.onGoogleSignUp,
    this.isLoading = false,
    this.isGoogleLoading = false,
    this.title = 'Create your account',
    this.subtitle = 'Create your account to get started with TaleX.',
    this.nameLabel = 'Full Name',
    this.nameHint = 'Jane Doe',
    this.emailLabel = 'Email address',
    this.emailHint = 'jane@company.com',
    this.companyLabel = 'Company Name',
    this.companyHint = 'Acme Corp',
    this.passwordLabel = 'Password',
    this.submitText = 'Sign up',
    this.dividerText = 'Or continue with',
    this.googleSignUpText = 'Sign up with Google',
    this.accountPrompt = 'Already have an account?',
    this.loginText = 'Log in',
    this.requiredError = 'This field is required',
    this.emailError = 'Enter a valid email',
    this.passwordError = 'At least 6 characters',
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController,
      emailController,
      companyController,
      passwordController;
  final VoidCallback onSubmit, onLogin;
  final VoidCallback? onGoogleSignUp;
  final bool isLoading, isGoogleLoading;
  final String title,
      subtitle,
      nameLabel,
      nameHint,
      emailLabel,
      emailHint,
      companyLabel,
      companyHint,
      passwordLabel,
      submitText,
      dividerText,
      googleSignUpText,
      accountPrompt,
      loginText,
      requiredError,
      emailError,
      passwordError;

  @override
  Widget build(BuildContext context) => Form(
    key: formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 34,
            fontWeight: FontWeight.w700,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          subtitle,
          style: const TextStyle(color: AppColors.subtitle, fontSize: 16),
        ),
        const SizedBox(height: 28),
        _field(nameLabel, nameHint, nameController, validator: _required),
        const SizedBox(height: 22),
        _field(
          emailLabel,
          emailHint,
          emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (value) =>
              value == null || !value.contains('@') ? emailError : null,
        ),
        const SizedBox(height: 22),
        _field(
          companyLabel,
          companyHint,
          companyController,
          validator: _required,
        ),
        const SizedBox(height: 22),
        _field(
          passwordLabel,
          '••••••••',
          passwordController,
          obscureText: true,
          validator: (value) => (value?.length ?? 0) < 6 ? passwordError : null,
          onSubmitted: (_) => onSubmit(),
        ),
        const SizedBox(height: 32),
        SizedBox(
          height: 44,
          child: FilledButton(
            onPressed: isLoading || isGoogleLoading ? null : onSubmit,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primaryButton,
              disabledBackgroundColor: AppColors.primaryButton,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: isLoading
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(submitText),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            const Expanded(child: Divider(color: AppColors.divider)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                dividerText,
                style: const TextStyle(
                  color: AppColors.subtitle,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Expanded(child: Divider(color: AppColors.divider)),
          ],
        ),
        const SizedBox(height: 20),
        AuthSocialButton(
          label: googleSignUpText,
          onPressed: isLoading || isGoogleLoading ? null : onGoogleSignUp,
          icon: const GoogleMark(),
          isLoading: isGoogleLoading,
          height: 44,
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                accountPrompt,
                style: const TextStyle(color: AppColors.subtitle, fontSize: 15),
              ),
            ),
            TextButton(
              onPressed: onLogin,
              style: TextButton.styleFrom(foregroundColor: AppColors.accent),
              child: Text(loginText),
            ),
          ],
        ),
      ],
    ),
  );

  String? _required(String? value) =>
      value == null || value.trim().isEmpty ? requiredError : null;

  Widget _field(
    String label,
    String hint,
    TextEditingController controller, {
    TextInputType? keyboardType,
    bool obscureText = false,
    FormFieldValidator<String>? validator,
    ValueChanged<String>? onSubmitted,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AuthFieldLabel(label),
      const SizedBox(height: 8),
      AuthField(
        controller: controller,
        hint: hint,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        onSubmitted: onSubmitted,
        height: 45,
      ),
    ],
  );
}
