import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // ── Header with gradient ──────────────────────────────────────────
          _HomeHeader(),
          // ── Menu items ───────────────────────────────────────────────────
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _MenuItem(
                  icon: Icons.menu_book_rounded,
                  label: 'Meus Cursos',
                  subtitle: '6 cursos em andamento',
                  color: AppColors.primary,
                  delay: 0,
                  onTap: () => context.go('/courses'),
                ),
                _MenuItem(
                  icon: Icons.assignment_outlined,
                  label: 'Tarefas',
                  subtitle: '3 pendentes esta semana',
                  color: AppColors.purple,
                  delay: 60,
                  onTap: () => context.go('/assignments'),
                ),
                _MenuItem(
                  icon: Icons.notifications_outlined,
                  label: 'Notificações',
                  subtitle: '2 novas mensagens',
                  color: AppColors.chart4,
                  delay: 120,
                  onTap: () {},
                ),
                _MenuItem(
                  icon: Icons.bar_chart_rounded,
                  label: 'Meu Progresso',
                  subtitle: 'Ver relatório completo',
                  color: AppColors.chart2,
                  delay: 180,
                  onTap: () => context.go('/progress'),
                ),
                _MenuItem(
                  icon: Icons.info_outline_rounded,
                  label: 'Informações',
                  subtitle: 'Sobre o EduConnect',
                  color: AppColors.textMuted,
                  delay: 240,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        left: 20,
        right: 20,
        bottom: 28,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0A1628), Color(0xFF0969E9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row
          Row(
            children: [
              // Avatar
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(color: Colors.white.withOpacity(0.4), width: 2),
                ),
                child: const Center(
                  child: Icon(Icons.person_rounded, color: Colors.white, size: 28),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Olá, Estudante!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Cursos 15 · Continue aprendendo',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined, color: Colors.white),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Quick stats row
          Row(
            children: [
              _StatChip(label: 'Cursos', value: '15', icon: Icons.menu_book_rounded),
              const SizedBox(width: 10),
              _StatChip(label: 'Horas', value: '248', icon: Icons.timer_outlined),
              const SizedBox(width: 10),
              _StatChip(label: 'Troféus', value: '8', icon: Icons.emoji_events_outlined),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms);
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const _StatChip({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: Colors.white.withOpacity(0.8)),
            const SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.65),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final int delay;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.delay,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textMuted,
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ).animate().fadeIn(delay: Duration(milliseconds: delay + 200), duration: 400.ms).slideX(begin: 0.05),
    );
  }
}
