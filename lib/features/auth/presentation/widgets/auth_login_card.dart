import 'package:flutter/material.dart';
import 'package:talex_platform/core/constants/app_colors.dart';
import 'package:talex_platform/core/constants/app_icons.dart';
import 'package:talex_platform/features/auth/presentation/widgets/auth_field.dart';
import 'package:talex_platform/features/auth/presentation/widgets/auth_social_button.dart';

class AuthLoginCard extends StatelessWidget {
  const AuthLoginCard({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onSubmit,
    required this.onForgot,
    this.isLoading = false,
    this.isSocialLoading = false,
    this.onSocialPressed,
    this.title = 'Secure Sign In',
    this.emailLabel = 'Email address',
    this.emailHint = 'email@example.com',
    this.passwordLabel = 'Password',
    this.passwordHint = '••••••••',
    this.forgotText = 'Forgot password?',
    this.submitText = 'Sign In',
    this.dividerText = 'Or continue with',
    this.socialText = 'Sign in with Google',
    this.width = 448,
    this.padding = const EdgeInsets.fromLTRB(32, 34, 32, 32),
    this.backgroundColor = AppColors.white,
    this.borderColor = AppColors.softBorder,
    this.submitColor = AppColors.primaryButton,
    this.emailValidator,
    this.passwordValidator,
    this.socialIcon = const GoogleMark(),
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSubmit;
  final VoidCallback onForgot;
  final VoidCallback? onSocialPressed;
  final bool isLoading;
  final bool isSocialLoading;
  final String title,
      emailLabel,
      emailHint,
      passwordLabel,
      passwordHint,
      forgotText,
      submitText,
      dividerText,
      socialText;
  final double width;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor, borderColor, submitColor;
  final FormFieldValidator<String>? emailValidator;
  final FormFieldValidator<String>? passwordValidator;
  final Widget socialIcon;

  @override
  Widget build(BuildContext context) => Container(
    width: width,
    padding: padding,
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: borderColor),
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
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.ink,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              letterSpacing: -.5,
            ),
          ),
          const SizedBox(height: 27),
          AuthFieldLabel(emailLabel),
          const SizedBox(height: 8),
          AuthField(
            controller: emailController,
            hint: emailHint,
            icon: AppIcons.email,
            keyboardType: TextInputType.emailAddress,
            validator: emailValidator,
          ),
          const SizedBox(height: 22),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AuthFieldLabel(passwordLabel),
              TextButton(
                onPressed: onForgot,
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.accent,
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: Text(forgotText),
              ),
            ],
          ),
          const SizedBox(height: 8),
          AuthField(
            controller: passwordController,
            hint: passwordHint,
            icon: AppIcons.password,
            obscureText: true,
            onSubmitted: (_) => onSubmit(),
            validator: passwordValidator,
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 36,
            child: FilledButton(
              onPressed: isLoading ? null : onSubmit,
              style: FilledButton.styleFrom(
                backgroundColor: submitColor,
                disabledBackgroundColor: submitColor,
                shape: const RoundedRectangleBorder(),
                textStyle: const TextStyle(fontSize: 15),
              ),
              child: isLoading
                  ? const SizedBox.square(
                      dimension: 17,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(submitText),
            ),
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Expanded(child: Divider(color: AppColors.divider)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: Text(
                  dividerText,
                  style: const TextStyle(
                    color: AppColors.subtitle,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(child: Divider(color: AppColors.divider)),
            ],
          ),
          const SizedBox(height: 24),
          AuthSocialButton(
            label: socialText,
            onPressed: isSocialLoading ? null : onSocialPressed,
            icon: socialIcon,
            isLoading: isSocialLoading,
          ),
        ],
      ),
    ),
  );
}
