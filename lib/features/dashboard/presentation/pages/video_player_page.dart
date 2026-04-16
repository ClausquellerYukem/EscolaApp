import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/colors.dart';

const _lessons = [
  _LessonData(title: 'Introdução ao Cálculo', duration: '2h 30min', isCompleted: true, isCurrent: false),
  _LessonData(title: 'Limites e Derivadas', duration: '2h 30min', isCompleted: true, isCurrent: false),
  _LessonData(title: 'Integrais Definidas', duration: '2h 30min', isCompleted: false, isCurrent: true),
  _LessonData(title: 'Equações Diferenciais', duration: '2h 30min', isCompleted: false, isCurrent: false),
  _LessonData(title: 'Funções Multivariáveis', duration: '2h 30min', isCompleted: false, isCurrent: false),
];

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key});
  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  bool _isPlaying = false;
  double _progress = 0.37; // 37% through the video

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // ── Video area ────────────────────────────────────────────────────
          _VideoArea(
            isPlaying: _isPlaying,
            progress: _progress,
            onPlayPause: () => setState(() => _isPlaying = !_isPlaying),
            onSeek: (v) => setState(() => _progress = v),
          ),

          // ── Lesson list ───────────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Aulas do Curso',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '${_lessons.where((l) => l.isCompleted).length}/${_lessons.length} concluídas',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 300.ms),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    itemCount: _lessons.length,
                    itemBuilder: (context, i) => _LessonTile(
                      lesson: _lessons[i],
                      number: i + 1,
                      delay: i * 60 + 350,
                    ),
                  ),
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

class _VideoArea extends StatelessWidget {
  final bool isPlaying;
  final double progress;
  final VoidCallback onPlayPause;
  final ValueChanged<double> onSeek;

  const _VideoArea({
    required this.isPlaying,
    required this.progress,
    required this.onPlayPause,
    required this.onSeek,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.32,
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Video placeholder
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF111827), Color(0xFF0A1628)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Play button overlay
          Center(
            child: GestureDetector(
              onTap: onPlayPause,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withOpacity(isPlaying ? 0.7 : 0.9),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 34,
                ),
              ),
            ),
          ),

          // Top controls
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 12,
            right: 12,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.white, size: 20),
                ),
                const Expanded(
                  child: Text(
                    'Integrais Definidas',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.fullscreen_rounded,
                      color: Colors.white, size: 24),
                ),
              ],
            ),
          ),

          // Bottom progress controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 3,
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 7),
                      overlayShape:
                          const RoundSliderOverlayShape(overlayRadius: 14),
                      activeTrackColor: AppColors.primary,
                      inactiveTrackColor: Colors.white.withOpacity(0.25),
                      thumbColor: Colors.white,
                      overlayColor: AppColors.primary.withOpacity(0.2),
                    ),
                    child: Slider(
                      value: progress,
                      onChanged: onSeek,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatTime(progress * 4200), // ~70min total
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.replay_10_rounded,
                                  color: Colors.white, size: 20),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                  minWidth: 32, minHeight: 32),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.forward_10_rounded,
                                  color: Colors.white, size: 20),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                  minWidth: 32, minHeight: 32),
                            ),
                          ],
                        ),
                        const Text(
                          '1:10:00',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  String _formatTime(double seconds) {
    final m = (seconds / 60).floor();
    final s = (seconds % 60).floor();
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _LessonTile extends StatelessWidget {
  final _LessonData lesson;
  final int number;
  final int delay;

  const _LessonTile({
    required this.lesson,
    required this.number,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: lesson.isCurrent ? const Color(0xFFDBEAFE) : AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: lesson.isCurrent ? AppColors.primary : AppColors.border,
                width: lesson.isCurrent ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                // Number / Status
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: lesson.isCompleted
                        ? AppColors.chart2
                        : lesson.isCurrent
                            ? AppColors.primary
                            : AppColors.surfaceVariant,
                  ),
                  child: Center(
                    child: lesson.isCompleted
                        ? const Icon(Icons.check_rounded,
                            color: Colors.white, size: 16)
                        : lesson.isCurrent
                            ? const Icon(Icons.play_arrow_rounded,
                                color: Colors.white, size: 16)
                            : Text(
                                '$number',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: lesson.isCurrent
                              ? AppColors.primary
                              : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        lesson.duration,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                if (lesson.isCurrent)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'Atual',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                else
                  const Icon(
                    Icons.lock_outline_rounded,
                    size: 16,
                    color: AppColors.textMuted,
                  ),
              ],
            ),
          ),
        ),
      ).animate().fadeIn(
            delay: Duration(milliseconds: delay),
            duration: 350.ms,
          ).slideX(begin: 0.05),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _LessonData {
  final String title;
  final String duration;
  final bool isCompleted;
  final bool isCurrent;

  const _LessonData({
    required this.title,
    required this.duration,
    required this.isCompleted,
    required this.isCurrent,
  });
}
