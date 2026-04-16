import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/colors.dart';

const _courses = [
  _CourseData(
    title: 'Matemática Avançada',
    subtitle: 'Álgebra Linear e Cálculo',
    hours: 85,
    progress: 0.72,
    icon: Icons.functions_rounded,
    color: AppColors.primary,
    tag: '6 módulos',
  ),
  _CourseData(
    title: 'Física Quântica',
    subtitle: 'Mecânica e Ondas',
    hours: 95,
    progress: 0.45,
    icon: Icons.science_outlined,
    color: AppColors.purple,
    tag: '8 módulos',
  ),
  _CourseData(
    title: 'História do Brasil',
    subtitle: 'Império e República',
    hours: 53,
    progress: 0.90,
    icon: Icons.history_edu_rounded,
    color: Color(0xFFEA580C), // orange
    tag: '4 módulos',
    isHighlighted: true,
  ),
  _CourseData(
    title: 'Língua Portuguesa',
    subtitle: 'Gramática e Redação',
    hours: 90,
    progress: 0.30,
    icon: Icons.spellcheck_rounded,
    color: AppColors.chart2,
    tag: '7 módulos',
  ),
  _CourseData(
    title: 'Química Orgânica',
    subtitle: 'Compostos e Reações',
    hours: 74,
    progress: 0.60,
    icon: Icons.biotech_outlined,
    color: AppColors.cyan,
    tag: '5 módulos',
  ),
  _CourseData(
    title: 'Geografia Global',
    subtitle: 'Geopolítica e Clima',
    hours: 90,
    progress: 0.15,
    icon: Icons.public_rounded,
    color: AppColors.chart4,
    tag: '6 módulos',
  ),
];

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});
  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  String _searchQuery = '';
  int _selectedCategory = 0;

  static const _categories = [
    'Todos',
    'Em andamento',
    'Concluídos',
    'Salvos',
  ];

  List<_CourseData> get _filtered {
    if (_searchQuery.isEmpty) return _courses;
    final q = _searchQuery.toLowerCase();
    return _courses.where((c) => c.title.toLowerCase().contains(q)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Meus Cursos'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: const Divider(height: 1),
        ),
      ),
      body: Column(
        children: [
          // ── Search bar ────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: 'Buscar curso...',
                prefixIcon: const Icon(Icons.search_rounded, size: 20),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded, size: 18),
                        onPressed: () => setState(() => _searchQuery = ''),
                      )
                    : null,
              ),
            ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.1),
          ),

          // ── Category chips ─────────────────────────────────────────────
          SizedBox(
            height: 52,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              itemCount: _categories.length,
              itemBuilder: (context, i) {
                final selected = i == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(_categories[i]),
                    selected: selected,
                    onSelected: (_) => setState(() => _selectedCategory = i),
                    backgroundColor: AppColors.surfaceVariant,
                    selectedColor: const Color(0xFFDBEAFE),
                    labelStyle: TextStyle(
                      color: selected ? AppColors.primary : AppColors.textSecondary,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                      fontSize: 13,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    side: BorderSide(
                      color: selected ? AppColors.primary : Colors.transparent,
                    ),
                  ),
                );
              },
            ),
          ).animate().fadeIn(delay: 100.ms),

          // ── Results count ─────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Row(
              children: [
                Text(
                  '${_filtered.length} cursos encontrados',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // ── Course list ───────────────────────────────────────────────────
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              itemCount: _filtered.length,
              itemBuilder: (context, i) {
                return _CourseListTile(
                  course: _filtered[i],
                  rank: i + 1,
                  delay: i * 60,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _CourseListTile extends StatelessWidget {
  final _CourseData course;
  final int rank;
  final int delay;

  const _CourseListTile({
    required this.course,
    required this.rank,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: course.isHighlighted ? AppColors.primary : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: course.isHighlighted
                    ? Colors.transparent
                    : AppColors.border,
              ),
            ),
            child: Row(
              children: [
                // Rank badge
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: course.isHighlighted
                        ? Colors.white.withOpacity(0.2)
                        : AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '#$rank',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: course.isHighlighted
                          ? Colors.white
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Icon
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: course.isHighlighted
                        ? Colors.white.withOpacity(0.2)
                        : course.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    course.icon,
                    color: course.isHighlighted ? Colors.white : course.color,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: course.isHighlighted
                              ? Colors.white
                              : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        course.subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: course.isHighlighted
                              ? Colors.white.withOpacity(0.75)
                              : AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: course.progress,
                          backgroundColor: course.isHighlighted
                              ? Colors.white.withOpacity(0.25)
                              : AppColors.surfaceVariant,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            course.isHighlighted ? Colors.white : course.color,
                          ),
                          minHeight: 4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                // Hours
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${course.hours}h',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: course.isHighlighted ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      course.tag,
                      style: TextStyle(
                        fontSize: 11,
                        color: course.isHighlighted
                            ? Colors.white.withOpacity(0.7)
                            : AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ).animate().fadeIn(
            delay: Duration(milliseconds: delay + 150),
            duration: 350.ms,
          ).slideY(begin: 0.1),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _CourseData {
  final String title;
  final String subtitle;
  final int hours;
  final double progress;
  final IconData icon;
  final Color color;
  final String tag;
  final bool isHighlighted;

  const _CourseData({
    required this.title,
    required this.subtitle,
    required this.hours,
    required this.progress,
    required this.icon,
    required this.color,
    required this.tag,
    this.isHighlighted = false,
  });
}
