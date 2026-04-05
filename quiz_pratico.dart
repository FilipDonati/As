import 'package:flutter/material.dart';
import 'dart:math';

class QuizPraticoScreen extends StatefulWidget {
  final String language;
  final String languageCode;
  final String level;

  const QuizPraticoScreen({
    super.key,
    required this.language,
    required this.languageCode,
    required this.level,
  });

  @override
  State<QuizPraticoScreen> createState() => _QuizPraticoScreenState();
}

class _QuizPraticoScreenState extends State<QuizPraticoScreen> {
  int currentQuestion = 0;
  int score = 0;
  String? selectedAnswer;
  bool showResult = false;
  bool quizCompleted = false;
  
  List<Map<String, dynamic>> questions = [];

  @override
  void initState() {
    super.initState();
    _generateQuestions();
  }

  void _generateQuestions() {
    // Genera 10 domande casuali
    final random = Random();
    questions = List.generate(10, (index) {
      final options = ['Opzione A', 'Opzione B', 'Opzione C', 'Opzione D'];
      final correct = options[random.nextInt(4)];
      
      return {
        'question': 'Domanda ${index + 1}: Qual è la risposta corretta?',
        'options': options,
        'correct': correct,
      };
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

  @override
  Widget build(BuildContext context) {
    if (quizCompleted) {
      final percentage = (score / questions.length * 100).round();
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFF6B9D),
                Color(0xFFFFA06B),
                Color(0xFFFFD93D),
              ],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
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
                        size: 60,
                        color: percentage >= 70 ? const Color(0xFFFFD93D) : Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Quiz Completato!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
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
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '$score/${questions.length}',
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF6B9D),
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFFFF6B9D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 8,
                        ),
                        child: const Text(
                          'TORNA ALLE LEZIONI',
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
      );
    }

    final question = questions[currentQuestion];
    final progress = (currentQuestion + 1) / questions.length;

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
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF6B9D).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Punteggio: $score',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF6B9D),
                            ),
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
                      'Domanda ${currentQuestion + 1}/${questions.length}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // Domanda
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
                        child: Text(
                          question['question'],
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Opzioni
                      ...List.generate(question['options'].length, (index) {
                        final option = question['options'][index];
                        final isSelected = selectedAnswer == option;
                        final isCorrect = option == question['correct'];
                        
                        Color? bgColor;
                        Color? textColor;
                        
                        if (showResult) {
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
                              onTap: showResult ? null : () => _checkAnswer(option),
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
                                    if (showResult && isCorrect)
                                      const Icon(Icons.check_circle, color: Colors.white, size: 28),
                                    if (showResult && isSelected && !isCorrect)
                                      const Icon(Icons.cancel, color: Colors.white, size: 28),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),

                      if (showResult) ...[
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: selectedAnswer == question['correct']
                                ? const Color(0xFF6BCF7F).withOpacity(0.1)
                                : Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: selectedAnswer == question['correct']
                                  ? const Color(0xFF6BCF7F)
                                  : Colors.red,
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
                                    : Colors.red,
                                size: 48,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                selectedAnswer == question['correct']
                                    ? 'Corretto! 🎉'
                                    : 'Sbagliato! 😔',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: selectedAnswer == question['correct']
                                      ? const Color(0xFF6BCF7F)
                                      : Colors.red,
                                ),
                              ),
                              if (selectedAnswer != question['correct']) ...[
                                const SizedBox(height: 8),
                                Text(
                                  'Risposta corretta: ${question['correct']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _nextQuestion,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF6B9D),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                            ),
                            child: Text(
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
                          ),
                        ),
                      ],
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