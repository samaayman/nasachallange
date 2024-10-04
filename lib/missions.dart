import 'package:flutter/material.dart';

// Define the Question class
class Question {
  final String questionText;
  final List<String> options;
  final String correctAnswer;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswer,
  });
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Question> _questions = [
    Question(
      questionText: 'What is an exoplanet?',
      options: [
        'A planet within our solar system',
        'A star that emits light',
        'A planet that orbits a star outside of our solar system',
        'A star that has exploded',
      ],
      correctAnswer: 'A planet that orbits a star outside of our solar system',
    ),
    Question(
      questionText: 'How are exoplanets detected?',
      options: [
        'By observing their gravitational pull on their parent star',
        'By seeing them with a telescope',
        'By listening to their radio signals',
        'By measuring the temperature of nearby space',
      ],
      correctAnswer: 'By observing their gravitational pull on their parent star',
    ),
    Question(
      questionText: 'What have scientists discovered by studying exoplanets?',
      options: [
        'The presence of aliens',
        'How planetary systems form and evolve',
        'The exact composition of all stars',
        'The origin of our solar system',
      ],
      correctAnswer: 'How planetary systems form and evolve',
    ),
  ];

  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _quizCompleted = false;

  void _checkAnswer(String selectedAnswer) {
    if (selectedAnswer == _questions[_currentQuestionIndex].correctAnswer) {
      _score += 1;
    }

    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _quizCompleted = true;
      }
    });
  }

  void _restartQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _quizCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Quiz', style: TextStyle(fontSize: 20, fontWeight:FontWeight.bold),),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: _quizCompleted ? _buildResultScreen() : _buildQuizScreen(),
    );
  }

  // Quiz screen
  Widget _buildQuizScreen() {
    final question = _questions[_currentQuestionIndex];

    return Column(
      children: [
        // Background image at the top
        Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            question.questionText,
            style: TextStyle(color: Colors.white, fontSize: 22),
            textAlign: TextAlign.center,
          ),
        ),
        // Displaying the quiz options
        ...question.options.map((option) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: SizedBox(
  width: 350, // Set your desired width
  height: 50, // Set your desired height
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
    ),
    onPressed: () => _checkAnswer(option),
    child: Text(
      option,
      style: TextStyle(color: Colors.black, fontSize: 16),
    ),
  ),
)

            )),
      ],
    );
  }

  // Result screen
  Widget _buildResultScreen() {
    bool isPassed = _score == _questions.length;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isPassed ? 'Well done!' : 'Try again, there are more chances!',
          style: TextStyle(color: Colors.white, fontSize: 32),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        if (isPassed)
          Icon(
            Icons.star,
            color: Colors.amber,
            size: 80,
          ),
        SizedBox(height: 20),
        Text(
          'Your Score: $_score/${_questions.length}',
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        SizedBox(height: 40),
        ElevatedButton(
          onPressed: _restartQuiz,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
          ),
          child: Text(
            'Restart Quiz',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
      ],
    );
  }
}
