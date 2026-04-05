import 'package:flutter/material.dart';
import 'package:login_ora/data/models/multilanguages_exercise_model.dart';
import 'dart:math';

class MultilingualExerciseScreen extends StatefulWidget {
  final String language;
  final String languageCode;
  final String level;
  final ExerciseLesson? specificLesson;

  const MultilingualExerciseScreen({
    super.key,
    required this.language,
    required this.languageCode,
    required this.level,
    this.specificLesson,
    required String nativeLanguageCode,
  });

  @override
  State<MultilingualExerciseScreen> createState() =>
      _MultilingualExerciseScreenState();
}

class _MultilingualExerciseScreenState
    extends State<MultilingualExerciseScreen> {
  late ExerciseSession session;
  late ExerciseLesson currentLesson;
  int currentExerciseIndex = 0;
  String? selectedAnswer;
  List<String> orderedWords = [];
  TextEditingController translationController = TextEditingController();
  bool showResult = false;
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    _initializeLesson();
  }

  @override
  void dispose() {
    translationController.dispose();
    super.dispose();
  }

  void _initializeLesson() {
    if (widget.specificLesson != null) {
      currentLesson = widget.specificLesson!;
    } else {
      currentLesson = _createDefaultLesson();
    }

    session = ExerciseSession(
      lessonId: currentLesson.id,
      startTime: DateTime.now(),
    );
  }

  ExerciseLesson _createDefaultLesson() {
    return ExerciseLesson(
      id: 'default',
      title: MultiLanguageText(translations: {'en': 'Default Lesson'}),
      description: MultiLanguageText(
        translations: {'en': 'Practice exercises'},
      ),
      level: 1,
      category: 'basic',
      exercises: [],
    );
  }

  MultilingualExercise get currentExercise =>
      currentLesson.exercises[currentExerciseIndex];

  @override
  Widget build(BuildContext context) {
    if (isCompleted) {
      return _buildCompletionScreen();
    }

    if (currentLesson.exercises.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Esercizi')),
        body: const Center(child: Text('Nessun esercizio disponibile')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${currentLesson.title.get(widget.languageCode)} - ${currentExerciseIndex + 1}/${currentLesson.exercises.length}',
          style: const TextStyle(fontSize: 16),
        ),
        backgroundColor: _getColorForExerciseType(currentExercise.type),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _getColorForExerciseType(currentExercise.type).withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            _buildProgressBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildExerciseTypeLabel(),
                    const SizedBox(height: 20),
                    _buildDifficultyIndicator(),
                    const SizedBox(height: 20),
                    _buildExerciseContent(),
                    if (showResult) _buildResultFeedback(),
                  ],
                ),
              ),
            ),
            _buildActionButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return LinearProgressIndicator(
      value: (currentExerciseIndex + 1) / currentLesson.exercises.length,
      minHeight: 6,
      backgroundColor: Colors.grey[300],
      valueColor: AlwaysStoppedAnimation<Color>(
        _getColorForExerciseType(currentExercise.type),
      ),
    );
  }

  Widget _buildDifficultyIndicator() {
    return Row(
      children: [
        const Icon(Icons.trending_up, size: 20, color: Color(0xFFFFA06B)),
        const SizedBox(width: 8),
        Text(
          'Difficoltà: ',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        ...List.generate(5, (index) {
          return Icon(
            index < currentExercise.difficulty ? Icons.star : Icons.star_border,
            size: 16,
            color: const Color(0xFFFFA06B),
          );
        }),
      ],
    );
  }

  Widget _buildExerciseTypeLabel() {
    String label;
    IconData icon;
    Color color = _getColorForExerciseType(currentExercise.type);

    switch (currentExercise.type) {
      case ExerciseType.sentenceReorder:
        label = 'Riordina la Frase';
        icon = Icons.reorder;
        break;
      case ExerciseType.wordSelection:
        label = 'Seleziona le Parole';
        icon = Icons.touch_app;
        break;
      case ExerciseType.translateAndOrder:
        label = 'Traduci e Ordina';
        icon = Icons.translate;
        break;
      case ExerciseType.complexTranslation:
        label = 'Traduzione Complessa';
        icon = Icons.library_books;
        break;
      case ExerciseType.fillInBlank:
        label = 'Completa la Frase';
        icon = Icons.edit;
        break;
      case ExerciseType.listeningComprehension:
        label = 'Comprensione Ascolto';
        icon = Icons.headphones;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 2),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseContent() {
    switch (currentExercise.type) {
      case ExerciseType.sentenceReorder:
        return _buildSentenceReorderExercise();
      case ExerciseType.wordSelection:
        return _buildWordSelectionExercise();
      case ExerciseType.translateAndOrder:
        return _buildTranslateAndOrderExercise();
      case ExerciseType.complexTranslation:
        return _buildComplexTranslationExercise();
      case ExerciseType.fillInBlank:
        return _buildFillInBlankExercise();
      case ExerciseType.listeningComprehension:
        return _buildListeningComprehensionExercise();
    }
  }

  // ESERCIZIO 1: Riordina la frase
  Widget _buildSentenceReorderExercise() {
    if (orderedWords.isEmpty && !showResult) {
      final words = currentExercise.sentence
          .get(widget.languageCode)
          .split(' / ')
          .where((w) => w.trim().isNotEmpty)
          .toList();
      orderedWords = List.from(words)..shuffle(Random());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 4,
          color: const Color(0xFFFF6B9D).withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(
                  Icons.help_outline,
                  size: 40,
                  color: Color(0xFFFF6B9D),
                ),
                const SizedBox(height: 12),
                Text(
                  currentExercise.question.get(widget.languageCode),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Trascina le parole nell\'ordine corretto:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300, width: 2),
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: orderedWords
                .map((word) => _buildDraggableWord(word))
                .toList(),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: showResult
                ? null
                : () {
                    setState(() {
                      selectedAnswer = orderedWords.join(' ');
                      _checkAnswer();
                    });
                  },
            icon: const Icon(Icons.check),
            label: const Text('Verifica Ordine'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              backgroundColor: const Color(0xFFFF6B9D),
              foregroundColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDraggableWord(String word) {
    return Draggable<String>(
      data: word,
      feedback: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFF6B9D).withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            word,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      childWhenDragging: Opacity(opacity: 0.5, child: _buildWordChip(word)),
      child: DragTarget<String>(
        onAcceptWithDetails: (draggedWord) {
          setState(() {
            final draggedIndex = orderedWords.indexOf(draggedWord as String);
            final targetIndex = orderedWords.indexOf(word);
            orderedWords.removeAt(draggedIndex);
            orderedWords.insert(targetIndex, draggedWord as String);
          });
        },
        builder: (context, candidateData, rejectedData) {
          return _buildWordChip(word);
        },
      ),
    );
  }

  Widget _buildWordChip(String word) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFF6B9D).withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFFF6B9D).withOpacity(0.5),
          width: 2,
        ),
      ),
      child: Text(
        word,
        style: const TextStyle(
          color: Color(0xFFFF6B9D),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ESERCIZIO 2: Seleziona parole in ordine
  Widget _buildWordSelectionExercise() {
    List<String> selectedWords = selectedAnswer?.split(',') ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              currentExercise.question.get(widget.languageCode),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFD93D).withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.amber.shade200, width: 2),
          ),
          child: Text(
            currentExercise.sentence.get(widget.languageCode),
            style: const TextStyle(fontSize: 18, height: 1.5),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Seleziona le parole nell\'ordine corretto:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (currentExercise.wordOptions != null)
          ...currentExercise.wordOptions!.map((wordOption) {
            final word = wordOption.get(widget.languageCode);
            final isSelected = selectedWords.contains(word);
            final selectionOrder = selectedWords.indexOf(word) + 1;

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: showResult
                    ? null
                    : () {
                        setState(() {
                          if (isSelected) {
                            selectedWords.remove(word);
                          } else {
                            selectedWords.add(word);
                          }
                          selectedAnswer = selectedWords.join(',');
                        });
                      },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF6BCF7F).withOpacity(0.3)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? Colors.green : Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      if (isSelected)
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Color(0xFF6BCF7F),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '$selectionOrder',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      else
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 2,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          word,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
      ],
    );
  }

  // ESERCIZIO 3: Traduci e ordina
  Widget _buildTranslateAndOrderExercise() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 4,
          color: const Color(0xFFFFA06B).withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(Icons.translate, size: 40, color: Color(0xFFFFA06B)),
                const SizedBox(height: 12),
                Text(
                  currentExercise.question.get(widget.languageCode),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFF6B9D).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFFF6B9D).withOpacity(0.3),
              width: 2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.info_outline, color: Color(0xFFFF6B9D)),
                  SizedBox(width: 8),
                  Text(
                    'Frase da tradurre:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                currentExercise.sentence.get('en'), // Mostra sempre in inglese
                style: const TextStyle(fontSize: 18, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Scrivi la traduzione:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: translationController,
          enabled: !showResult,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Scrivi la traduzione qui...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          onChanged: (value) {
            selectedAnswer = value;
          },
        ),
      ],
    );
  }

  // ESERCIZIO 4: Traduzione complessa
  Widget _buildComplexTranslationExercise() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 4,
          color: Colors.red.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(Icons.library_books, size: 40, color: Colors.red),
                const SizedBox(height: 12),
                Text(
                  currentExercise.question.get(widget.languageCode),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFFF6B9D).withOpacity(0.08),
                const Color(0xFFFF6B9D).withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFFF6B9D).withOpacity(0.4),
              width: 2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.menu_book, color: Color(0xFFCC3370)),
                  SizedBox(width: 8),
                  Text(
                    'Frase complessa da tradurre:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                currentExercise.sentence.get('en'), // Sempre in inglese
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.8,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Scrivi la traduzione completa:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: translationController,
          enabled: !showResult,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: 'Scrivi la traduzione completa qui...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          onChanged: (value) {
            selectedAnswer = value;
          },
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFD93D).withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              Icon(Icons.tips_and_updates, color: Color(0xFFFFD93D), size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Suggerimento: Presta attenzione ai tempi verbali e alle subordinate',
                  style: TextStyle(fontSize: 12, color: Color(0xFFFFD93D)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ESERCIZIO 5: Fill in the blank
  Widget _buildFillInBlankExercise() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              currentExercise.question.get(widget.languageCode),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF6BCF7F).withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF6BCF7F).withOpacity(0.4),
              width: 2,
            ),
          ),
          child: Text(
            currentExercise.sentence.get(widget.languageCode),
            style: const TextStyle(
              fontSize: 18,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Scegli la parola corretta:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (currentExercise.wordOptions != null)
          ...currentExercise.wordOptions!.map((wordOption) {
            final word = wordOption.get(widget.languageCode);
            final isSelected = selectedAnswer == word;
            final isCorrect =
                word == currentExercise.correctAnswer.get(widget.languageCode);

            Color backgroundColor;
            Color borderColor;
            Color textColor;

            if (showResult) {
              if (isCorrect) {
                backgroundColor = const Color(0xFF6BCF7F).withOpacity(0.2);
                borderColor = Colors.green;
                textColor = const Color(0xFF6BCF7F);
              } else if (isSelected) {
                backgroundColor = Colors.red.withOpacity(0.2);
                borderColor = Colors.red;
                textColor = Colors.red;
              } else {
                backgroundColor = Colors.white;
                borderColor = Colors.grey.shade300;
                textColor = Colors.black87;
              }
            } else {
              backgroundColor = isSelected
                  ? const Color(0xFFFF6B9D).withOpacity(0.1)
                  : Colors.white;
              borderColor = isSelected ? Colors.blue : Colors.grey.shade300;
              textColor = isSelected ? Colors.blue.shade900 : Colors.black87;
            }

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: showResult
                    ? null
                    : () {
                        setState(() {
                          selectedAnswer = word;
                        });
                      },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: borderColor, width: 2),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: borderColor, width: 2),
                          color: isSelected ? borderColor : Colors.transparent,
                        ),
                        child: isSelected
                            ? const Icon(
                                Icons.check,
                                size: 16,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          word,
                          style: TextStyle(
                            fontSize: 16,
                            color: textColor,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      if (showResult && isCorrect)
                        const Icon(
                          Icons.check_circle,
                          color: Color(0xFF6BCF7F),
                        ),
                      if (showResult && isSelected && !isCorrect)
                        const Icon(Icons.cancel, color: Colors.red),
                    ],
                  ),
                ),
              ),
            );
          }),
      ],
    );
  }

  // ESERCIZIO 6: Listening comprehension
  Widget _buildListeningComprehensionExercise() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 4,
          color: const Color(0xFFFFA06B).withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(
                  Icons.headphones,
                  size: 50,
                  color: Color(0xFFFFA06B),
                ),
                const SizedBox(height: 16),
                Text(
                  currentExercise.question.get(widget.languageCode),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    // Simula riproduzione audio
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '🔊 Audio: "${currentExercise.sentence.get(widget.languageCode)}"',
                        ),
                        duration: const Duration(seconds: 3),
                        backgroundColor: const Color(0xFFFFA06B),
                      ),
                    );
                  },
                  icon: const Icon(Icons.play_arrow, size: 32),
                  label: const Text(
                    'ASCOLTA',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFA06B),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Scegli la parola che hai sentito:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (currentExercise.wordOptions != null)
          ...currentExercise.wordOptions!.map((wordOption) {
            final word = wordOption.get(widget.languageCode);
            final isSelected = selectedAnswer == word;
            final isCorrect =
                word == currentExercise.correctAnswer.get(widget.languageCode);

            Color backgroundColor;
            Color borderColor;

            if (showResult) {
              if (isCorrect) {
                backgroundColor = const Color(0xFF6BCF7F).withOpacity(0.2);
                borderColor = Colors.green;
              } else if (isSelected) {
                backgroundColor = Colors.red.withOpacity(0.2);
                borderColor = Colors.red;
              } else {
                backgroundColor = Colors.white;
                borderColor = Colors.grey.shade300;
              }
            } else {
              backgroundColor = isSelected
                  ? const Color(0xFFFFA06B).withOpacity(0.2)
                  : Colors.white;
              borderColor = isSelected ? Colors.indigo : Colors.grey.shade300;
            }

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: showResult
                    ? null
                    : () {
                        setState(() {
                          selectedAnswer = word;
                        });
                      },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: borderColor, width: 2),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.volume_up, color: borderColor, size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          word,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                      if (showResult && isCorrect)
                        const Icon(
                          Icons.check_circle,
                          color: Color(0xFF6BCF7F),
                          size: 28,
                        ),
                      if (showResult && isSelected && !isCorrect)
                        const Icon(Icons.cancel, color: Colors.red, size: 28),
                    ],
                  ),
                ),
              ),
            );
          }),
      ],
    );
  }

  Widget _buildResultFeedback() {
    final isCorrect = _isAnswerCorrect();

    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isCorrect
            ? const Color(0xFF6BCF7F).withOpacity(0.2)
            : Colors.red.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCorrect ? Colors.green : Colors.red,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                color: isCorrect ? Colors.green : Colors.red,
                size: 32,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  isCorrect ? 'Corretto! 🎉' : 'Non corretto 😕',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isCorrect ? const Color(0xFF6BCF7F) : Colors.red,
                  ),
                ),
              ),
            ],
          ),
          if (!isCorrect) ...[
            const SizedBox(height: 12),
            const Text(
              'Risposta corretta:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              currentExercise.correctAnswer.get(widget.languageCode),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
          if (currentExercise.explanation != null) ...[
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.lightbulb_outline,
                  color: Color(0xFFFFD93D),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    currentExercise.explanation!.get(widget.languageCode),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _handleButtonPress,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              backgroundColor: _getColorForExerciseType(currentExercise.type),
              foregroundColor: Colors.white,
            ),
            child: Text(_getButtonText()),
          ),
        ),
      ),
    );
  }

  String _getButtonText() {
    if (!showResult) {
      return 'Verifica Risposta';
    }
    return currentExerciseIndex < currentLesson.exercises.length - 1
        ? 'Prossimo Esercizio'
        : 'Completa';
  }

  void _handleButtonPress() {
    if (!showResult) {
      if (currentExercise.type == ExerciseType.translateAndOrder ||
          currentExercise.type == ExerciseType.complexTranslation) {
        selectedAnswer = translationController.text;
      }

      if (selectedAnswer == null || selectedAnswer!.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Fornisci una risposta')));
        return;
      }

      _checkAnswer();
    } else {
      _nextExercise();
    }
  }

  void _checkAnswer() {
    final isCorrect = _isAnswerCorrect();

    final userAnswer = UserAnswer(
      exerciseId: currentExercise.id,
      userAnswer: selectedAnswer!,
      correctAnswer: currentExercise.correctAnswer.get(widget.languageCode),
      isCorrect: isCorrect,
      timestamp: DateTime.now(),
    );

    session.addAnswer(userAnswer);

    setState(() {
      showResult = true;
    });
  }

  bool _isAnswerCorrect() {
    if (selectedAnswer == null) return false;

    final correct = currentExercise.correctAnswer.get(widget.languageCode);
    final answer = selectedAnswer!.trim().toLowerCase();
    final correctAnswer = correct.trim().toLowerCase();

    // Per traduzione, accetta risposte simili (80% somiglianza)
    if (currentExercise.type == ExerciseType.translateAndOrder ||
        currentExercise.type == ExerciseType.complexTranslation) {
      return _calculateSimilarity(answer, correctAnswer) > 0.8;
    }

    return answer == correctAnswer;
  }

  double _calculateSimilarity(String s1, String s2) {
    if (s1 == s2) return 1.0;
    if (s1.isEmpty || s2.isEmpty) return 0.0;

    final longer = s1.length > s2.length ? s1 : s2;
    final shorter = s1.length > s2.length ? s2 : s1;

    final longerLength = longer.length;
    if (longerLength == 0) return 1.0;

    return (longerLength - _editDistance(longer, shorter)) / longerLength;
  }

  int _editDistance(String s1, String s2) {
    final costs = List<int>.filled(s2.length + 1, 0);

    for (var i = 0; i <= s1.length; i++) {
      var lastValue = i;
      for (var j = 0; j <= s2.length; j++) {
        if (i == 0) {
          costs[j] = j;
        } else if (j > 0) {
          var newValue = costs[j - 1];
          if (s1[i - 1] != s2[j - 1]) {
            newValue = min(min(newValue, lastValue), costs[j]) + 1;
          }
          costs[j - 1] = lastValue;
          lastValue = newValue;
        }
      }
      if (i > 0) costs[s2.length] = lastValue;
    }

    return costs[s2.length];
  }

  int min(int a, int b) => a < b ? a : b;

  void _nextExercise() {
    if (currentExerciseIndex < currentLesson.exercises.length - 1) {
      setState(() {
        currentExerciseIndex++;
        selectedAnswer = null;
        orderedWords = [];
        translationController.clear();
        showResult = false;
      });
    } else {
      session.complete();
      setState(() {
        isCompleted = true;
      });
    }
  }

  Color _getColorForExerciseType(ExerciseType type) {
    switch (type) {
      case ExerciseType.sentenceReorder:
        return const Color(0xFFFF6B9D); // Rosa
      case ExerciseType.wordSelection:
        return const Color(0xFF6BCF7F); // Verde
      case ExerciseType.translateAndOrder:
        return const Color(0xFFFFA06B); // Arancione
      case ExerciseType.complexTranslation:
        return const Color(0xFFFF6B9D); // Rosa
      case ExerciseType.fillInBlank:
        return const Color(0xFFFF6B9D); // Rosa
      case ExerciseType.listeningComprehension:
        return const Color(0xFFFFA06B); // Arancione
    }
  }

  Widget _buildCompletionScreen() {
    final percentage = session.percentage.round();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFF6B9D), Color(0xFFFFA06B), Color(0xFFFFD93D)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
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
                      percentage >= 70
                          ? Icons.emoji_events
                          : Icons.sentiment_neutral,
                      size: 60,
                      color: percentage >= 70
                          ? const Color(0xFFFFD93D)
                          : Colors.grey[400],
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
                          '${session.correctCount}/${session.totalCount}',
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
                            color: percentage >= 70
                                ? const Color(0xFF6BCF7F)
                                : const Color(0xFFFFA06B),
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
}
