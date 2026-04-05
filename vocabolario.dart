import 'package:flutter/material.dart';
import 'dart:async';

import 'package:login_ora/data/models/vocabulary_model.dart';
import 'package:login_ora/services/api_client/vocabulary_service.dart';

class VocabolarioScreen extends StatefulWidget {
  final String language;
  final String languageCode;

  const VocabolarioScreen({
    super.key,
    required this.language,
    required this.languageCode,
  });

  @override
  State<VocabolarioScreen> createState() => _VocabolarioScreenState();
}

class _VocabolarioScreenState extends State<VocabolarioScreen> with SingleTickerProviderStateMixin {
  String selectedCategory = 'Tutti';
  String searchQuery = '';
  late List<VocabularyWord> allWords;
  late AnimationController _animationController;
  
  // Quiz state
  bool isQuizActive = false;
  List<QuizQuestion>? quizQuestions;
  int currentQuestionIndex = 0;
  String? selectedAnswer;
  bool showQuizResult = false;
  Timer? quizTimer;
  int remainingSeconds = 60; // 1 minute
  List<bool> quizAnswers = [];
  int quizScore = 0;

  @override
  void initState() {
    super.initState();
    allWords = VocabularyService.getAllWords();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    quizTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  List<VocabularyWord> get filteredVocabulary {
    return VocabularyService.filterWords(
      words: allWords,
      category: selectedCategory == 'Tutti' ? null : selectedCategory,
      searchQuery: searchQuery.isEmpty ? null : searchQuery,
    );
  }

  void _startQuiz() {
    setState(() {
      isQuizActive = true;
      currentQuestionIndex = 0;
      selectedAnswer = null;
      showQuizResult = false;
      remainingSeconds = 60;
      quizAnswers = [];
      quizScore = 0;

      // Generate 12 random questions
      quizQuestions = VocabularyService.generateQuiz(
        targetLanguageCode: widget.languageCode,
        nativeLanguageCode: 'en', // Or use user's native language
        questionCount: 12,
      );
    });

    // Start 1-minute timer
    quizTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingSeconds > 0) {
          remainingSeconds--;
        } else {
          _endQuiz();
        }
      });
    });

    _animationController.forward();
  }

  void _checkAnswer(String answer) {
    if (quizQuestions == null || showQuizResult) return;

    final isCorrect = answer == quizQuestions![currentQuestionIndex].correctAnswer;
    
    setState(() {
      selectedAnswer = answer;
      showQuizResult = true;
      quizAnswers.add(isCorrect);
      if (isCorrect) quizScore++;
    });

    // Auto-advance to next question after 1.5 seconds
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted && isQuizActive) {
        _nextQuestion();
      }
    });
  }

  void _nextQuestion() {
    if (currentQuestionIndex < quizQuestions!.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
        showQuizResult = false;
      });
    } else {
      _endQuiz();
    }
  }

  void _endQuiz() {
    quizTimer?.cancel();
    setState(() {
      isQuizActive = false;
    });
    _showQuizResults();
  }

  void _showQuizResults() {
    final percentage = (quizScore / quizQuestions!.length * 100).round();
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFF6B9D), Color(0xFFFFA06B), Color(0xFFFFD93D)],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  percentage >= 70 ? Icons.emoji_events : Icons.sentiment_neutral,
                  size: 50,
                  color: percentage >= 70 ? const Color(0xFFFFD93D) : Colors.grey[400],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Quiz Completato!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '$quizScore/${quizQuestions!.length}',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$percentage%',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: percentage >= 70 ? const Color(0xFF6BCF7F) : Colors.orange,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                percentage >= 90
                    ? 'Eccellente! 🌟'
                    : percentage >= 70
                        ? 'Molto bene! 👍'
                        : 'Continua così! 💪',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFFF6B9D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 8,
                  ),
                  child: const Text(
                    'CHIUDI',
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
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isQuizActive && quizQuestions != null) {
      return _buildQuizScreen();
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF6BCF7F).withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildCategoryFilter(),
              Expanded(
                child: filteredVocabulary.isEmpty
                    ? _buildEmptyState()
                    : _buildVocabularyList(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: _startQuiz,
            heroTag: 'quiz',
            icon: const Icon(Icons.quiz),
            label: const Text('Quiz 1min'),
            backgroundColor: const Color(0xFFFF6B9D),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('📚 Aggiungi parola - In arrivo!'),
                  backgroundColor: Color(0xFF6BCF7F),
                ),
              );
            },
            heroTag: 'add',
            backgroundColor: const Color(0xFF6BCF7F),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6BCF7F), Color(0xFF3B82F6)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6BCF7F).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Vocabolario',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '${filteredVocabulary.length} parole',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.book, color: Colors.white, size: 28),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              onChanged: (value) => setState(() => searchQuery = value),
              decoration: const InputDecoration(
                hintText: 'Cerca parole...',
                prefixIcon: Icon(Icons.search, color: Color(0xFF6BCF7F)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: VocabularyService.categories.length,
        itemBuilder: (context, index) {
          final category = VocabularyService.categories[index];
          final isSelected = selectedCategory == category;

          return GestureDetector(
            onTap: () => setState(() => selectedCategory = category),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? const LinearGradient(
                        colors: [Color(0xFF6BCF7F), Color(0xFF3B82F6)],
                      )
                    : null,
                color: isSelected ? null : Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFF6BCF7F).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.grey[700],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVocabularyList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredVocabulary.length,
      itemBuilder: (context, index) {
        final word = filteredVocabulary[index];
        return _buildVocabularyCard(word);
      },
    );
  }

  Widget _buildVocabularyCard(VocabularyWord word) {
    final translation = word.getTranslation(widget.languageCode);
    final example = word.getExample(widget.languageCode);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ExpansionTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF6BCF7F).withOpacity(0.2),
                const Color(0xFF3B82F6).withOpacity(0.2),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              translation.isNotEmpty ? translation[0].toUpperCase() : '?',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6BCF7F),
              ),
            ),
          ),
        ),
        title: Text(
          translation,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              word.getTranslation('en'), // English translation as subtitle
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF6BCF7F),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF6BCF7F).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                word.category,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF6BCF7F),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.volume_up, color: Color(0xFF6BCF7F)),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('🔊 Pronuncia: $translation'),
                duration: const Duration(seconds: 2),
                backgroundColor: const Color(0xFF6BCF7F),
              ),
            );
          },
        ),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF6BCF7F).withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (example.isNotEmpty) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.format_quote, size: 18, color: Color(0xFF6BCF7F)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          example,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[800],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildActionButton(Icons.favorite_border, 'Preferiti', const Color(0xFFFF6B9D)),
                    _buildActionButton(Icons.check_circle_outline, 'Imparata', const Color(0xFF6BCF7F)),
                    _buildActionButton(Icons.share, 'Condividi', const Color(0xFF3B82F6)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$label aggiunto!'),
            backgroundColor: color,
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Nessuna parola trovata',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            'Prova a cercare qualcos\'altro',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizScreen() {
    final question = quizQuestions![currentQuestionIndex];
    final progress = (currentQuestionIndex + 1) / quizQuestions!.length;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFFF6B9D).withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Quiz Header
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Uscire dal quiz?'),
                                content: const Text('Il tuo progresso andrà perso.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Continua'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _endQuiz();
                                    },
                                    child: const Text('Esci'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: remainingSeconds <= 10
                                ? Colors.red.withOpacity(0.2)
                                : const Color(0xFFFF6B9D).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.timer,
                                color: remainingSeconds <= 10 ? Colors.red : const Color(0xFFFF6B9D),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '$remainingSeconds s',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: remainingSeconds <= 10 ? Colors.red : const Color(0xFFFF6B9D),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 10,
                        backgroundColor: Colors.grey[200],
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFF6B9D)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Domanda ${currentQuestionIndex + 1}/${quizQuestions!.length}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // Question
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFFFF6B9D).withOpacity(0.1),
                              const Color(0xFFFFA06B).withOpacity(0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: const Color(0xFFFF6B9D).withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Traduci:',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 12),
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

                      // Options
                      ...List.generate(question.options.length, (index) {
                        final option = question.options[index];
                        final isSelected = selectedAnswer == option;
                        final isCorrect = option == question.correctAnswer;

                        Color? bgColor;
                        Color? textColor;

                        if (showQuizResult) {
                          if (isCorrect) {
                            bgColor = const Color(0xFF6BCF7F);
                            textColor = Colors.white;
                          } else if (isSelected && !isCorrect) {
                            bgColor = Colors.red;
                            textColor = Colors.white;
                          }
                        }

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: showQuizResult ? null : () => _checkAnswer(option),
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: bgColor ?? Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: bgColor ?? Colors.grey[300]!,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: (bgColor ?? Colors.grey[200])!.withOpacity(0.3),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          String.fromCharCode(65 + index),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: textColor ?? Colors.grey[700],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        option,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: textColor ?? Colors.grey[800],
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    if (showQuizResult && isCorrect)
                                      const Icon(Icons.check_circle, color: Colors.white, size: 28),
                                    if (showQuizResult && isSelected && !isCorrect)
                                      const Icon(Icons.cancel, color: Colors.white, size: 28),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}