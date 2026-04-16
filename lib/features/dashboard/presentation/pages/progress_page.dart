import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/colors.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Meu Progresso'),
        backgroundColor: AppColors.surface,
        elevation: 0,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Score overview card ────────────────────────────────────────
            _ScoreOverviewCard()
                .animate()
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.1),

            const SizedBox(height: 20),

            // ── Accuracy row ──────────────────────────────────────────────
            Text(
              'Precisão por Categoria',
              style: Theme.of(context).textTheme.titleMedium,
            ).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _AccuracyCard(
                    label: 'Exatas',
                    percent: 0.50,
                    color: AppColors.primary,
                    delay: 250,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _AccuracyCard(
                    label: 'Humanas',
                    percent: 0.64,
                    color: AppColors.chart2,
                    delay: 350,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ── Stats grid ────────────────────────────────────────────────
            Text(
              'Resumo Geral',
              style: Theme.of(context).textTheme.titleMedium,
            ).animate().fadeIn(delay: 400.ms),
            const SizedBox(height: 14),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 1.5,
              children: [
                _StatCard(
                  label: 'Nota Média',
                  value: '70%',
                  icon: Icons.trending_up_rounded,
                  color: AppColors.chart2,
                  delay: 450,
                ),
                _StatCard(
                  label: 'Provas Feitas',
                  value: '12',
                  icon: Icons.quiz_outlined,
                  color: AppColors.primary,
                  delay: 500,
                ),
                _StatCard(
                  label: 'Questões',
                  value: '183',
                  icon: Icons.help_outline_rounded,
                  color: AppColors.purple,
                  delay: 550,
                ),
                _StatCard(
                  label: 'Ranking',
                  value: '#8',
                  icon: Icons.emoji_events_rounded,
                  color: AppColors.chart4,
                  delay: 600,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ── Progress chart bar ─────────────────────────────────────────
            _WeeklyProgressCard()
                .animate()
                .fadeIn(delay: 700.ms)
                .slideY(begin: 0.1),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _ScoreOverviewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0A1628), Color(0xFF0969E9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sua Pontuação',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      '1.240 pts',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.arrow_upward_rounded,
                            color: Color(0xFF4ADE80), size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '+83 esta semana',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    const Text(
                      'Nível 4',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Progress to next level
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Próximo nível',
                    style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
                  Text('1240 / 1500 pts',
                    style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: 1240 / 1500,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  minHeight: 6,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AccuracyCard extends StatelessWidget {
  final String label;
  final double percent;
  final Color color;
  final int delay;

  const _AccuracyCard({
    required this.label,
    required this.percent,
    required this.color,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: CustomPaint(
              painter: _ArcPainter(progress: percent, color: color),
              child: Center(
                child: Text(
                  '${(percent * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            'precisão',
            style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: delay), duration: 400.ms).slideY(begin: 0.1);
  }
}

class _ArcPainter extends CustomPainter {
  final double progress;
  final Color color;
  const _ArcPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;
    final stroke = 8.0;

    // Background
    final bgPaint = Paint()
      ..color = color.withOpacity(0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);

    // Arc
    final fgPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(_ArcPainter old) => old.progress != progress;
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final int delay;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: delay), duration: 400.ms).slideY(begin: 0.1);
  }
}

class _WeeklyProgressCard extends StatelessWidget {
  static const _days = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab', 'Dom'];
  static const _values = [0.6, 0.8, 0.4, 0.9, 0.7, 0.3, 0.5];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Atividade da Semana',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(_days.length, (i) {
              final isToday = i == 3;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    children: [
                      Container(
                        height: 80 * _values[i],
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isToday
                                ? [AppColors.primary, AppColors.primaryLight]
                                : [
                                    AppColors.primary.withOpacity(0.25),
                                    AppColors.primary.withOpacity(0.15),
                                  ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _days[i],
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isToday ? FontWeight.w700 : FontWeight.w400,
                          color: isToday ? AppColors.primary : AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
