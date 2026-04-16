import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/colors.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController    = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isSignUp        = false; // Toggle between Sign In / Sign Up

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            // ── Top hero gradient strip ────────────────────────────────────
            Container(
              height: MediaQuery.of(context).size.height * 0.38,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0A1628), Color(0xFF0969E9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),

            // ── Ambient glow circles ───────────────────────────────────────
            Positioned(
              top: 20,
              right: -30,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
            ),
            Positioned(
              top: 80,
              left: -40,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.cyan.withOpacity(0.12),
                ),
              ),
            ),

            // ── Scrollable form body ───────────────────────────────────────
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),

                    // Logo + brand
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.school_rounded,
                                size: 38,
                                color: Colors.white,
                              ),
                            ),
                          ).animate().scale(duration: 500.ms, curve: Curves.easeOutBack),
                          const SizedBox(height: 14),
                          const Text(
                            'EduConnect',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: -0.3,
                            ),
                          ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
                          const SizedBox(height: 4),
                          Text(
                            'Plataforma Educacional Inteligente',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white.withOpacity(0.75),
                            ),
                          ).animate().fadeIn(delay: 300.ms, duration: 500.ms),
                        ],
                      ),
                    ),

                    const SizedBox(height: 36),

                    // ── White card form ────────────────────────────────────
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.10),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Tab toggle: Entrar / Cadastrar
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.surfaceVariant,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(4),
                            child: Row(
                              children: [
                                _buildTab('Entrar',   !_isSignUp, () => setState(() => _isSignUp = false)),
                                _buildTab('Cadastrar', _isSignUp, () => setState(() => _isSignUp = true)),
                              ],
                            ),
                          ).animate().fadeIn(delay: 400.ms),

                          const SizedBox(height: 24),

                          if (_isSignUp) ...[
                            _buildField(
                              controller: TextEditingController(),
                              label: 'Nome completo',
                              icon: Icons.person_outline_rounded,
                              hint: 'Seu nome',
                            ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1),
                            const SizedBox(height: 14),
                          ],

                          // Email
                          _buildField(
                            controller: _emailController,
                            label: 'E-mail',
                            icon: Icons.email_outlined,
                            hint: 'seu@email.com',
                            keyboardType: TextInputType.emailAddress,
                          ).animate().fadeIn(delay: 450.ms).slideY(begin: 0.1),
                          const SizedBox(height: 14),

                          // Password
                          _buildPasswordField()
                              .animate()
                              .fadeIn(delay: 500.ms)
                              .slideY(begin: 0.1),

                          if (!_isSignUp) ...[
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: _launchSupport,
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 0),
                                ),
                                child: const Text(
                                  'Esqueceu a senha?',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ).animate().fadeIn(delay: 530.ms),
                          ] else ...[
                            const SizedBox(height: 14),
                            _buildField(
                              controller: TextEditingController(),
                              label: 'Confirmar senha',
                              icon: Icons.lock_outline_rounded,
                              hint: '••••••••',
                              obscure: true,
                            ).animate().fadeIn(delay: 540.ms).slideY(begin: 0.1),
                          ],

                          const SizedBox(height: 20),

                          // Submit button
                          _buildSubmitButton()
                              .animate()
                              .fadeIn(delay: 600.ms)
                              .slideY(begin: 0.1),

                          const SizedBox(height: 16),

                          // Divider
                          Row(
                            children: [
                              const Expanded(child: Divider()),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  'ou continue com',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ),
                              const Expanded(child: Divider()),
                            ],
                          ).animate().fadeIn(delay: 650.ms),

                          const SizedBox(height: 16),

                          // Social sign-in (Google placeholder)
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.g_mobiledata_rounded, size: 22),
                            label: const Text('Continuar com Google'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.textPrimary,
                              side: const BorderSide(color: AppColors.border),
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ).animate().fadeIn(delay: 700.ms),
                        ],
                      ),
                    ).animate().fadeIn(delay: 350.ms).slideY(begin: 0.15),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String label, bool selected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    TextInputType? keyboardType,
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, size: 20),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        labelText: 'Senha',
        hintText: '••••••••',
        prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20),
        suffixIcon: GestureDetector(
          onTap: () => setState(() => _obscurePassword = !_obscurePassword),
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(
              _obscurePassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: AppColors.textMuted,
              size: 20,
            ),
          ),
        ),
        suffixIconConstraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.go('/home');
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFC62828),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: Colors.white, size: 26),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Erro no acesso',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            state.message,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ).animate().shake(duration: 400.ms).fadeIn(duration: 200.ms),
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : () {
                    context.read<AuthBloc>().add(
                          LoginRequested(
                            _emailController.text,
                            _passwordController.text,
                            'EDU01',
                          ),
                        );
                  },
            child: isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(_isSignUp ? 'Criar conta' : 'Entrar'),
          ),
        );
      },
    );
  }

  Future<void> _launchSupport() async {
    const phone = '5511999999999';
    const message = 'Olá! Gostaria de recuperar minha senha de acesso ao EduConnect.';
    final url = Uri.parse('whatsapp://send?phone=$phone&text=${Uri.encodeComponent(message)}');
    final fallback = Uri.parse('https://wa.me/$phone?text=${Uri.encodeComponent(message)}');
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        await launchUrl(fallback, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('WhatsApp error: $e');
    }
  }
}
