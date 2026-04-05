import 'package:flutter/material.dart';
import 'dart:math';
import 'package:login_ora/data/models/language_model.dart';

class EserciziScreen extends StatefulWidget {
  final Lesson lesson;

  const EserciziScreen({super.key, required this.lesson, required String titolo, required String lingua});

  @override
  State<EserciziScreen> createState() => _EserciziScreenState();
}

class _EserciziScreenState extends State<EserciziScreen> {
  int currentExerciseIndex = 0;
  String? selectedAnswer;
  bool showResult = false;
  int correctAnswers = 0;
  List<String> draggedWords = [];
  bool isCompleted = false;

  Exercise get currentExercise => widget.lesson.exercises[currentExerciseIndex];
  bool get isLastExercise =>
      currentExerciseIndex == widget.lesson.exercises.length - 1;

  @override
  Widget build(BuildContext context) {
    if (isCompleted) {
      return _buildCompletionScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Esercizio ${currentExerciseIndex + 1}/${widget.lesson.exercises.length}'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (currentExerciseIndex + 1) / widget.lesson.exercises.length,
            minHeight: 6,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildExerciseTypeLabel(),
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
    );
  }

  Widget _buildExerciseTypeLabel() {
    String label;
    IconData icon;
    Color color;

    switch (currentExercise.type) {
      case ExerciseType.fillInTheBlank:
        label = 'Completa la frase';
        icon = Icons.edit;
        color = Colors.blue;
        break;
      case ExerciseType.wordPosition:
        label = 'Ordina le parole';
        icon = Icons.reorder;
        color = Colors.purple;
        break;
      case ExerciseType.listenAndComplete:
        label = 'Ascolta e completa';
        icon = Icons.headphones;
        color = Colors.orange;
        break;
      case ExerciseType.multipleChoice:
        label = 'Scelta multipla';
        icon = Icons.quiz;
        color = Colors.green;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseContent() {
    switch (currentExercise.type) {
      case ExerciseType.fillInTheBlank:
        return _buildFillInTheBlankExercise();
      case ExerciseType.wordPosition:
        return _buildWordPositionExercise();
      case ExerciseType.listenAndComplete:
        return _buildListenAndCompleteExercise();
      case ExerciseType.multipleChoice:
        return _buildMultipleChoiceExercise();
    }
  }

  Widget _buildFillInTheBlankExercise() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              currentExercise.question,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Scegli la parola corretta:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...currentExercise.options.map((option) => _buildOptionButton(option)),
      ],
    );
  }

  Widget _buildMultipleChoiceExercise() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          color: Colors.blue.shade50,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(Icons.help_outline, size: 40, color: Colors.blue),
                const SizedBox(height: 12),
                Text(
                  currentExercise.question,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        ...currentExercise.options.map((option) => _buildOptionButton(option)),
      ],
    );
  }

  Widget _buildWordPositionExercise() {
    if (draggedWords.isEmpty && !showResult) {
      draggedWords = List.from(currentExercise.options)..shuffle(Random());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(Icons.reorder, size: 40, color: Colors.purple),
                const SizedBox(height: 12),
                Text(
                  currentExercise.question,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
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
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: draggedWords
                .map((word) => _buildDraggableWord(word))
                .toList(),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              selectedAnswer = draggedWords.join(' ');
              _checkAnswer();
            });
          },
          icon: const Icon(Icons.check),
          label: const Text('Verifica'),
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
            color: Colors.purple.shade300,
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
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: _buildWordChip(word),
      ),
      child: DragTarget<String>(
        onAcceptWithDetails: (draggedWord) {
          setState(() {
            final draggedIndex = draggedWords.indexOf(draggedWord.data);
            final targetIndex = draggedWords.indexOf(word);
            draggedWords.removeAt(draggedIndex);
            draggedWords.insert(targetIndex, draggedWord.data);
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
        color: Colors.purple.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.purple.shade300),
      ),
      child: Text(
        word,
        style: TextStyle(
          color: Colors.purple.shade900,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildListenAndCompleteExercise() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          color: Colors.orange.shade50,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(Icons.headphones, size: 50, color: Colors.orange),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    // Implementare riproduzione audio
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Audio: "Good morning! How are you?"'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Ascolta la frase'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              currentExercise.question,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ...currentExercise.options.map((option) => _buildOptionButton(option)),
      ],
    );
  }

  Widget _buildOptionButton(String option) {
    final isSelected = selectedAnswer == option;
    final isCorrect = option == currentExercise.correctAnswer;
    
    Color backgroundColor;
    Color textColor;
    Color borderColor;
    
    if (showResult) {
      if (isCorrect) {
        backgroundColor = Colors.green.shade50;
        textColor = Colors.green.shade900;
        borderColor = Colors.green;
      } else if (isSelected) {
        backgroundColor = Colors.red.shade50;
        textColor = Colors.red.shade900;
        borderColor = Colors.red;
      } else {
        backgroundColor = Colors.white;
        textColor = Colors.black87;
        borderColor = Colors.grey.shade300;
      }
    } else {
      backgroundColor = isSelected ? Colors.blue.shade50 : Colors.white;
      textColor = isSelected ? Colors.blue.shade900 : Colors.black87;
      borderColor = isSelected ? Colors.blue : Colors.grey.shade300;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: showResult ? null : () {
          setState(() {
            selectedAnswer = option;
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
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  option,
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              if (showResult && isCorrect)
                const Icon(Icons.check_circle, color: Colors.green),
              if (showResult && isSelected && !isCorrect)
                const Icon(Icons.cancel, color: Colors.red),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultFeedback() {
    final isCorrect = selectedAnswer == currentExercise.correctAnswer;
    
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isCorrect ? Colors.green.shade50 : Colors.red.shade50,
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
                    color: isCorrect ? Colors.green.shade900 : Colors.red.shade900,
                  ),
                ),
              ),
            ],
          ),
          if (currentExercise.explanation != null) ...[
            const SizedBox(height: 12),
            Text(
              currentExercise.explanation!,
              style: const TextStyle(fontSize: 16),
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
              textStyle: const TextStyle(fontSize: 18),
            ),
            child: Text(_getButtonText()),
          ),
        ),
      ),
    );
  }

  String _getButtonText() {
    if (currentExercise.type == ExerciseType.wordPosition && !showResult) {
      return 'Verifica in alto';
    }
    if (!showResult) {
      return 'Verifica';
    }
    return isLastExercise ? 'Completa' : 'Prossimo';
  }

  void _handleButtonPress() {
    if (currentExercise.type == ExerciseType.wordPosition && !showResult) {
      return;
    }

    if (!showResult) {
      _checkAnswer();
    } else {
      _nextExercise();
    }
  }

  void _checkAnswer() {
    if (selectedAnswer == null && currentExercise.type != ExerciseType.wordPosition) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Seleziona una risposta')),
      );
      return;
    }

    setState(() {
      showResult = true;
      if (selectedAnswer == currentExercise.correctAnswer) {
        correctAnswers++;
      }
    });
  }

  void _nextExercise() {
    if (isLastExercise) {
      setState(() {
        isCompleted = true;
      });
    } else {
      setState(() {
        currentExerciseIndex++;
        selectedAnswer = null;
        showResult = false;
        draggedWords = [];
      });
    }
  }

  Widget _buildCompletionScreen() {
    final percentage = (correctAnswers / widget.lesson.exercises.length * 100).round();
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.emoji_events,
                    size: 100,
                    color: Colors.amber,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Lezione Completata!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Hai risposto correttamente a $correctAnswers su ${widget.lesson.exercises.length} domande',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '$percentage%',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: percentage >= 70 ? Colors.green : Colors.orange,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          percentage >= 70 ? 'Eccellente!' : 'Continua così!',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.home),
                      label: const Text('Torna alla Home'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.all(16),
                        textStyle: const TextStyle(fontSize: 18),
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