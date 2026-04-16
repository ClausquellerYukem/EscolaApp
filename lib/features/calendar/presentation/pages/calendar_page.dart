import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/colors.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDate = DateTime(2026, 3, 18);
  final DateTime _focusedMonth = DateTime(2026, 3, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Agenda'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1),
        ),
      ),
      body: Column(
        children: [
          // ── Calendar widget ───────────────────────────────────────────────
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: _buildCalendar(),
          ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),

          // ── Events for selected day ───────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Eventos — ${_selectedDate.day} de março',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Ver todos'),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 200.ms),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              children: [
                _EventTile(
                  title: 'Prova de Matemática',
                  subtitle: 'Cálculo — Sala 14',
                  time: '09:00',
                  color: AppColors.primary,
                  delay: 300,
                ),
                _EventTile(
                  title: 'Laboratório de Física',
                  subtitle: 'Mecânica Quântica',
                  time: '14:00',
                  color: AppColors.purple,
                  delay: 380,
                ),
                _EventTile(
                  title: 'Entrega — Redação',
                  subtitle: 'Enviar via portal até 23:59',
                  time: '23:59',
                  color: AppColors.error,
                  delay: 460,
                ),
                _EventTile(
                  title: 'Reforço de Química',
                  subtitle: 'Online — Meet',
                  time: '18:30',
                  color: AppColors.chart2,
                  delay: 540,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    final dayNames = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab'];
    final firstDayOfMonth = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final daysInMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0).day;
    final startWeekday = firstDayOfMonth.weekday % 7;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'MARÇO',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: AppColors.textPrimary,
                letterSpacing: 1,
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.chevron_left_rounded, size: 22),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.chevron_right_rounded, size: 22),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: dayNames.map((d) => SizedBox(
                width: 36,
                child: Text(d,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted)),
              )).toList(),
        ),
        const SizedBox(height: 8),
        ...List.generate(6, (week) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (dow) {
                final dayIndex = week * 7 + dow - startWeekday + 1;
                if (dayIndex < 1 || dayIndex > daysInMonth) {
                  return const SizedBox(width: 36, height: 36);
                }
                final date = DateTime(_focusedMonth.year, _focusedMonth.month, dayIndex);
                final isSelected = date.day == _selectedDate.day && date.month == _selectedDate.month;
                final hasEvent = [4, 5, 18, 23, 24].contains(dayIndex);
                final isToday = dayIndex == 16;
                return GestureDetector(
                  onTap: () => setState(() => _selectedDate = date),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : isToday
                              ? const Color(0xFFDBEAFE)
                              : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          '$dayIndex',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : isToday
                                    ? AppColors.primary
                                    : AppColors.textPrimary,
                          ),
                        ),
                        if (hasEvent && !isSelected)
                          Positioned(
                            bottom: 4,
                            child: Container(
                              width: 4,
                              height: 4,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ],
    );
  }
}

class _EventTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final Color color;
  final int delay;

  const _EventTile({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.color,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 44,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14)),
                      const SizedBox(height: 3),
                      Text(subtitle,
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    time,
                    style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w600, color: color),
                  ),
                ),
              ],
            ),
          ),
        ),
      ).animate().fadeIn(delay: Duration(milliseconds: delay), duration: 350.ms).slideX(begin: 0.05),
    );
  }
}
