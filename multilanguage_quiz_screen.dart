import 'package:flutter/material.dart';
import 'package:login_ora/data/models/vocabulary_model.dart';
import 'package:login_ora/presentation/screens/multilanguages_exercise_screen.dart';
import 'package:login_ora/services/api_client/vocabulary_service.dart';

class MultilingualQuizScreen extends StatefulWidget {
  final String language;
  final String languageCode;
  final String level;
  final String nativeLanguageCode; // Lingua dell'utente (es: 'it' per italiano)

  const MultilingualQuizScreen({
    super.key,
    required this.language,
    required this.languageCode,
    required this.level,
    this.nativeLanguageCode = 'it', // Default italiano
  });

  @override
  State<MultilingualQuizScreen> createState() => _MultilingualQuizScreenState();
}

class _MultilingualQuizScreenState extends State<MultilingualQuizScreen>
    with SingleTickerProviderStateMixin {
  int currentQuestion = 0;
  int score = 0;
  String? selectedAnswer;
  bool showResult = false;
  bool quizCompleted = false;
  
  List<QuizQuestion> questions = [];
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _generateQuestions();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _generateQuestions() {
    // Determina difficoltà in base al livello
    List<int> difficulties;
    switch (widget.level.toLowerCase()) {
      case 'beginner':
        difficulties = [1];
        break;
      case 'intermediate':
        difficulties = [1, 2];
        break;
      case 'advanced':
        difficulties = [2, 3];
        break;
      default:
        difficulties = [1];
    }

    // Genera quiz con VocabularyService
    questions = VocabularyService.generateQuiz(
      targetLanguageCode: widget.languageCode,
      nativeLanguageCode: widget.nativeLanguageCode,
      questionCount: 12,
      difficulties: difficulties,
    );
  }

  void _checkAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      showResult = true;
      if (answer == questions[currentQuestion].correctAnswer) {
        score++;
      }
    });
  }

  void _nextQuestion() {
    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
        selectedAnswer = null;
        showResult = false;
      });
      _animationController.reset();
      _animationController.forward();
    } else {
      setState(() {
        quizCompleted = true;
      });
      _animationController.reset();
      _animationController.forward();
    }
  }

  Color _getLevelColor() {
    switch (widget.level.toLowerCase()) {
      case 'beginner':
        return const Color(0xFF6BCF7F);
      case 'intermediate':
        return const Color(0xFFFFA06B);
      case 'advanced':
        return const Color(0xFFFF6B9D);
      default:
        return const Color(0xFF7C3AED);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (quizCompleted) {
      return _buildCompletionScreen();
    }

    return _buildQuizScreen();
  }

  Widget _buildCompletionScreen() {
    final percentage = (score / questions.length * 100).round();
    final levelColor = _getLevelColor();
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              levelColor,
              levelColor.withOpacity(0.7),
              const Color(0xFFFFD93D),
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Trofeo animato
                    TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 800),
                      tween: Tween<double>(begin: 0, end: 1),
                      builder: (context, double value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 30,
                                  spreadRadius: 5,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Icon(
                              percentage >= 70 
                                  ? Icons.emoji_events 
                                  : percentage >= 50
                                      ? Icons.sentiment_satisfied
                                      : Icons.sentiment_neutral,
                              size: 70,
                              color: percentage >= 70 
                                  ? const Color(0xFFFFD93D)
                                  : percentage >= 50
                                      ? Colors.orange
                                      : Colors.grey[400],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                    
                    // Titolo completamento
                    const Text(
                      'Quiz Completato!',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Info lingua e livello
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.4),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.language,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${widget.language} - ${_capitalizeFirst(widget.level)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Card punteggio
                    Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 30,
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Punteggio Finale',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          // Punteggio principale
                          TweenAnimationBuilder(
                            duration: const Duration(milliseconds: 1000),
                            tween: IntTween(begin: 0, end: score),
                            builder: (context, int value, child) {
                              return Text(
                                '$value/${questions.length}',
                                style: TextStyle(
                                  fontSize: 56,
                                  fontWeight: FontWeight.bold,
                                  color: levelColor,
                                ),
                              );
                            },
                          ),
                          
                          const SizedBox(height: 12),
                          
                          // Percentuale
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: percentage >= 70 
                                  ? const Color(0xFF6BCF7F).withOpacity(0.2)
                                  : percentage >= 50
                                      ? Colors.orange.withOpacity(0.2)
                                      : Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '$percentage%',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: percentage >= 70 
                                    ? const Color(0xFF6BCF7F)
                                    : percentage >= 50
                                        ? Colors.orange
                                        : Colors.grey[600],
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Messaggio di feedback
                          Text(
                            _getFeedbackMessage(percentage),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Statistiche
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            icon: Icons.check_circle,
                            label: 'Corrette',
                            value: score.toString(),
                            color: const Color(0xFF6BCF7F),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildStatCard(
                            icon: Icons.cancel,
                            label: 'Sbagliate',
                            value: (questions.length - score).toString(),
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Pulsante continua agli esercizi
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MultilingualExerciseScreen(
                                language: widget.language,
                                languageCode: widget.languageCode,
                                level: widget.level,
                                nativeLanguageCode: widget.nativeLanguageCode,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: levelColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 8,
                          shadowColor: Colors.black.withOpacity(0.3),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'CONTINUA GLI ESERCIZI',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, size: 24),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Pulsante rifai quiz
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            currentQuestion = 0;
                            score = 0;
                            selectedAnswer = null;
                            showResult = false;
                            quizCompleted = false;
                            _generateQuestions();
                          });
                          _animationController.reset();
                          _animationController.forward();
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'RIFAI IL QUIZ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizScreen() {
    final question = questions[currentQuestion];
    final levelColor = _getLevelColor();
    final progress = (currentQuestion + 1) / questions.length;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              levelColor.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header con progresso
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => _showExitDialog(),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '${widget.language} - ${_capitalizeFirst(widget.level)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: levelColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Domanda ${currentQuestion + 1} di ${questions.length}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: levelColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.stars, color: levelColor, size: 18),
                              const SizedBox(width: 4),
                              Text(
                                '$score',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: levelColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Barra di progresso
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TweenAnimationBuilder(
                        duration: const Duration(milliseconds: 500),
                        tween: Tween<double>(begin: 0, end: progress),
                        builder: (context, double value, child) {
                          return LinearProgressIndicator(
                            value: value,
                            minHeight: 8,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(levelColor),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Contenuto quiz
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // Categoria
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: levelColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: levelColor.withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _getCategoryIcon(question.category),
                                color: levelColor,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                question.category,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: levelColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 24),

                        // Domanda
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: levelColor.withOpacity(0.3),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: levelColor.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Traduci in ${widget.language}:',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                question.wordInTargetLanguage,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 32),

                        // Opzioni
                        ...List.generate(question.options.length, (index) {
                          final option = question.options[index];
                          final isSelected = selectedAnswer == option;
                          final isCorrect = option == question.correctAnswer;
                          
                          Color? bgColor;
                          Color? textColor;
                          Color? borderColor;
                          
                          if (showResult) {
                            if (isCorrect) {
                              bgColor = const Color(0xFF6BCF7F);
                              textColor = Colors.white;
                              borderColor = const Color(0xFF6BCF7F);
                            } else if (isSelected && !isCorrect) {
                              bgColor = Colors.red;
                              textColor = Colors.white;
                              borderColor = Colors.red;
                            } else {
                              borderColor = Colors.grey[300];
                            }
                          } else {
                            borderColor = levelColor.withOpacity(0.3);
                          }

                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: showResult ? null : () => _checkAnswer(option),
                                borderRadius: BorderRadius.circular(16),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: bgColor ?? Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: borderColor!,
                                      width: 2.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: (bgColor ?? Colors.grey[200]!).withOpacity(0.3),
                                        blurRadius: 12,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          color: (bgColor ?? levelColor.withOpacity(0.1)),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            String.fromCharCode(65 + index),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: textColor ?? levelColor,
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
                                            color: textColor ?? Colors.grey[800],
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      if (showResult && isCorrect)
                                        const Icon(
                                          Icons.check_circle,
                                          color: Colors.white,
                                          size: 32,
                                        ),
                                      if (showResult && isSelected && !isCorrect)
                                        const Icon(
                                          Icons.cancel,
                                          color: Colors.white,
                                          size: 32,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),

                        if (showResult) ...[
                          const SizedBox(height: 24),
                          
                          // Feedback
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: selectedAnswer == question.correctAnswer
                                    ? [
                                        const Color(0xFF6BCF7F).withOpacity(0.15),
                                        const Color(0xFF6BCF7F).withOpacity(0.05),
                                      ]
                                    : [
                                        Colors.red.withOpacity(0.15),
                                        Colors.red.withOpacity(0.05),
                                      ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: selectedAnswer == question.correctAnswer
                                    ? const Color(0xFF6BCF7F)
                                    : Colors.red,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  selectedAnswer == question.correctAnswer
                                      ? Icons.celebration
                                      : Icons.info_outline,
                                  color: selectedAnswer == question.correctAnswer
                                      ? const Color(0xFF6BCF7F)
                                      : Colors.red,
                                  size: 56,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  selectedAnswer == question.correctAnswer
                                      ? 'Perfetto! 🎉'
                                      : 'Ops! Quasi! 💪',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: selectedAnswer == question.correctAnswer
                                        ? const Color(0xFF6BCF7F)
                                        : Colors.red,
                                  ),
                                ),
                                if (selectedAnswer != question.correctAnswer) ...[
                                  const SizedBox(height: 12),
                                  Text(
                                    'Risposta corretta:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    question.correctAnswer,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Pulsante avanti
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: _nextQuestion,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: levelColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 6,
                                shadowColor: levelColor.withOpacity(0.4),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    currentQuestion < questions.length - 1
                                        ? 'PROSSIMA DOMANDA'
                                        : 'COMPLETA QUIZ',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.arrow_forward, color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Uscire dal quiz?'),
        content: const Text('Il tuo progresso andrà perso.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ANNULLA'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text(
              'ESCI',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  String _getFeedbackMessage(int percentage) {
    if (percentage >= 90) {
      return '🌟 Eccezionale! Sei un maestro!';
    } else if (percentage >= 70) {
      return '👏 Ottimo lavoro! Continua così!';
    } else if (percentage >= 50) {
      return '💪 Buon tentativo! Esercitati ancora!';
    } else {
      return '📚 Non mollare! La pratica rende perfetti!';
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'base':
        return Icons.star;
      case 'cibo':
        return Icons.restaurant;
      case 'viaggio':
        return Icons.flight;
      case 'lavoro':
        return Icons.work;
      case 'casa':
        return Icons.home;
      case 'tempo':
        return Icons.wb_sunny;
      case 'salute':
        return Icons.favorite;
      case 'famiglia':
        return Icons.family_restroom;
      case 'numeri':
        return Icons.numbers;
      case 'colori':
        return Icons.palette;
      case 'animali':
        return Icons.pets;
      case 'corpo':
        return Icons.accessibility;
      case 'vestiti':
        return Icons.checkroom;
      case 'sport':
        return Icons.sports_soccer;
      case 'tecnologia':
        return Icons.computer;
      default:
        return Icons.school;
    }
  }

  String _capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}