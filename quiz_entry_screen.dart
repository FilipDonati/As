import 'package:flutter/material.dart';
import 'package:login_ora/presentation/screens/home_screen.dart';
import 'package:login_ora/presentation/screens/tab_language/language_selection_screen.dart';
import 'package:login_ora/presentation/screens/tab_language/question_generator.dart';
import 'package:login_ora/presentation/screens/tab_language/question_generator_v2.dart';

class QuizPage extends StatefulWidget {
  final String language;
  final String languageCode;
  final String level;
  final String flag;
  final dynamic localeProvider;

  const QuizPage({
    super.key,
    required this.language,
    required this.languageCode,
    required this.level,
    required this.flag,
    required this.localeProvider,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> questions = [];
  int currentQuestion = 0;
  int score = 0;
  String? selectedAnswer;
  bool showResult = false;
  bool quizCompleted = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _generateQuestions();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _generateQuestions() {
    final isAdvanced =
        widget.level == 'Intermedio' || widget.level == 'Avanzato';
    final List<Map<String, dynamic>> generated;
    if (isAdvanced) {
      generated = QuestionGeneratorV2(
        widget.languageCode,
        widget.level,
      ).generateQuestions();
    } else {
      generated = QuestionGenerator(
        widget.languageCode,
        widget.level,
      ).generateQuestions();
    }
    // Limita a 8 domande come richiesto
    setState(() {
      questions = generated.length > 8 ? generated.sublist(0, 8) : generated;
    });
  }

  void _checkAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      showResult = true;
      if (answer == questions[currentQuestion]['correct']) {
        score++;
      }
    });
    _animationController.forward(from: 0);
  }

  void _nextQuestion() {
    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
        selectedAnswer = null;
        showResult = false;
      });
    } else {
      setState(() {
        quizCompleted = true;
      });
    }
  }

  void _goToHome() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => HomePage(
          language: widget.language,
          languageCode: widget.languageCode,
          level: widget.level,
          flag: widget.flag,
          localeProvider: widget.localeProvider,
        ),
      ),
      (route) => false,
    );
  }

  void _restartQuiz() {
    setState(() {
      currentQuestion = 0;
      score = 0;
      selectedAnswer = null;
      showResult = false;
      quizCompleted = false;
    });
    _generateQuestions();
  }

  // Colore basato sul livello
  Color _getLevelColor() {
    switch (widget.level) {
      case 'Principiante':
        return const Color(0xFF6BCF7F); // Verde
      case 'Elementare':
        return const Color(0xFF3B82F6); // Blu
      case 'Intermedio':
        return const Color(0xFFFFA06B); // Arancione
      case 'Avanzato':
        return const Color(0xFFFF6B9D); // Rosa
      default:
        return const Color(0xFF7C3AED); // Viola default
    }
  }

  @override
  Widget build(BuildContext context) {
    final levelColor = _getLevelColor();

    if (quizCompleted) {
      final percentage = (score / questions.length * 100).round();
      final isPassed = percentage >= 70;

      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                isPassed ? const Color(0xFF6BCF7F) : const Color(0xFFFFA06B),
                isPassed ? const Color(0xFF4CAF50) : const Color(0xFFFF8A50),
                Colors.white,
              ],
              stops: const [0.0, 0.3, 0.7],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Trofeo/Medaglia animata
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: isPassed
                              ? [
                                  const Color(0xFFFFD93D),
                                  const Color(0xFFFFA726),
                                ]
                              : [
                                  const Color(0xFFBDBDBD),
                                  const Color(0xFF9E9E9E),
                                ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color:
                                (isPassed
                                        ? const Color(0xFFFFD93D)
                                        : Colors.grey)
                                    .withOpacity(0.5),
                            blurRadius: 30,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: Icon(
                        isPassed ? Icons.emoji_events : Icons.sentiment_neutral,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Titolo
                    Text(
                      'Quiz Completato!',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.flag,
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.language,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Card risultati
                    Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Punteggio',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '$score/${questions.length}',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: isPassed
                                    ? [
                                        const Color(0xFF6BCF7F),
                                        const Color(0xFF4CAF50),
                                      ]
                                    : [
                                        const Color(0xFFFFA06B),
                                        const Color(0xFFFF8A50),
                                      ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '$percentage%',
                              style: const TextStyle(
                                fontSize: 56,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            isPassed
                                ? '🎉 Ottimo lavoro!'
                                : '💪 Continua così!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: isPassed
                                  ? const Color(0xFF6BCF7F)
                                  : const Color(0xFFFFA06B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Bottoni azione
                    _buildResultButton(
                      icon: Icons.home,
                      label: 'Vai alla Home',
                      gradient: const LinearGradient(
                        colors: [Color(0xFF7C3AED), Color(0xFFA855F7)],
                      ),
                      onPressed: _goToHome,
                    ),
                    const SizedBox(height: 16),
                    _buildResultButton(
                      icon: Icons.refresh,
                      label: 'Riprova Quiz',
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3B82F6), Color(0xFF06B6D4)],
                      ),
                      onPressed: _restartQuiz,
                    ),
                    const SizedBox(height: 16),
                    _buildResultButton(
                      icon: Icons.language,
                      label: 'Cambia Lingua',
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF6B9D), Color(0xFFFFA06B)],
                      ),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => const LanguageSelectionPage(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Quiz in corso
    final question = questions[currentQuestion];
    final progress = (currentQuestion + 1) / questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.flag, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                '${widget.language} - ${widget.level}',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  levelColor.withOpacity(0.3),
                  levelColor.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: levelColor, width: 2),
            ),
            child: Row(
              children: [
                Icon(Icons.star, size: 16, color: levelColor),
                const SizedBox(width: 4),
                Text(
                  '$score',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: levelColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress bar animata
          SizedBox(
            height: 8,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        levelColor.withOpacity(0.2),
                        levelColor.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [levelColor, levelColor.withOpacity(0.7)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: levelColor.withOpacity(0.5),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Header info
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [levelColor.withOpacity(0.1), Colors.white],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Domanda ${currentQuestion + 1}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'di ${questions.length}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: levelColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: levelColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: levelColor, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        '$score corrette',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: levelColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Card domanda
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          levelColor.withOpacity(0.15),
                          levelColor.withOpacity(0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: levelColor.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Text(
                      question['question'],
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Opzioni risposta
                  ...List.generate(question['options'].length, (index) {
                    final option = question['options'][index];
                    final isSelected = selectedAnswer == option;
                    final isCorrect = option == question['correct'];

                    Color? buttonColor;
                    Color? borderColor;
                    if (showResult) {
                      if (isCorrect) {
                        buttonColor = const Color(0xFF6BCF7F);
                        borderColor = const Color(0xFF4CAF50);
                      } else if (isSelected && !isCorrect) {
                        buttonColor = const Color(0xFFFF6B9D);
                        borderColor = const Color(0xFFE91E63);
                      }
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: showResult ? null : () => _checkAnswer(option),
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: buttonColor != null
                                  ? LinearGradient(
                                      colors: [
                                        buttonColor,
                                        buttonColor.withOpacity(0.8),
                                      ],
                                    )
                                  : LinearGradient(
                                      colors: [Colors.white, Colors.grey[50]!],
                                    ),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color:
                                    borderColor ??
                                    (isSelected
                                        ? levelColor
                                        : Colors.grey[300]!),
                                width: isSelected ? 3 : 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: (buttonColor ?? Colors.grey)
                                      .withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: buttonColor != null
                                        ? Colors.white.withOpacity(0.3)
                                        : levelColor.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      String.fromCharCode(65 + index),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: buttonColor != null
                                            ? Colors.white
                                            : levelColor,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    option,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: buttonColor != null
                                          ? Colors.white
                                          : Colors.grey[800],
                                    ),
                                  ),
                                ),
                                if (showResult && (isCorrect || isSelected))
                                  Icon(
                                    isCorrect
                                        ? Icons.check_circle
                                        : Icons.cancel,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),

                  // Feedback e bottone prossima domanda
                  if (showResult) ...[
                    const SizedBox(height: 24),
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: selectedAnswer == question['correct']
                                ? [
                                    const Color(0xFF6BCF7F).withOpacity(0.2),
                                    const Color(0xFF4CAF50).withOpacity(0.1),
                                  ]
                                : [
                                    const Color(0xFFFF6B9D).withOpacity(0.2),
                                    const Color(0xFFE91E63).withOpacity(0.1),
                                  ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selectedAnswer == question['correct']
                                ? const Color(0xFF6BCF7F)
                                : const Color(0xFFFF6B9D),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              selectedAnswer == question['correct']
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              color: selectedAnswer == question['correct']
                                  ? const Color(0xFF6BCF7F)
                                  : const Color(0xFFFF6B9D),
                              size: 56,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              selectedAnswer == question['correct']
                                  ? '🎉 Esatto!'
                                  : '❌ Ops!',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: selectedAnswer == question['correct']
                                    ? const Color(0xFF6BCF7F)
                                    : const Color(0xFFFF6B9D),
                              ),
                            ),
                            if (selectedAnswer != question['correct']) ...[
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.lightbulb,
                                      color: Color(0xFFFFD93D),
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Flexible(
                                      child: Text(
                                        'Corretta: ${question['correct']}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [levelColor, levelColor.withOpacity(0.8)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: levelColor.withOpacity(0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: _nextQuestion,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              currentQuestion < questions.length - 1
                                  ? 'Prossima Domanda'
                                  : 'Completa Quiz',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward, size: 24),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultButton({
    required IconData icon,
    required String label,
    required LinearGradient gradient,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradient.colors[0].withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 24),
        label: Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
