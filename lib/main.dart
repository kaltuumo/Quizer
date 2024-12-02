import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizPage(),
      theme: ThemeData.dark(), // Set the theme to dark for black background
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // List of questions and answers
  List<Map<String, dynamic>> questions = [
    {'question': 'Flutter is a programming language', 'answer': false},
    {
      'question': 'Dart is the programming language used by Flutter',
      'answer': true
    },
    {'question': 'The sun rises from the west', 'answer': false},
    {'question': 'The earth is round', 'answer': true},
  ];

  int currentQuestionIndex = 0;
  int score = 0;

  void checkAnswer(bool userAnswer) {
    setState(() {
      if (userAnswer == questions[currentQuestionIndex]['answer']) {
        score++;
      }
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        // If all questions are answered, show the score
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Quiz Over"),
            content: Text("Your score is $score/${questions.length}"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    // Reset the quiz
                    currentQuestionIndex = 0;
                    score = 0;
                  });
                },
                child: Text('Retry'),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'True or False Quiz',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ),

        backgroundColor: Colors.black, // AppBar color to match the theme
      ),
      backgroundColor: Colors.black, // Set background to black
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Question ${currentQuestionIndex + 1} of ${questions.length}',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 50),
            Text(
              questions[currentQuestionIndex]['question'],
              style: TextStyle(color: Colors.white, fontSize: 25),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1),
            // Buttons stacked vertically and made to fit inside the screen
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => checkAnswer(true),
                    child: Text('True'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      textStyle: TextStyle(
                        fontSize: 15.0,
                      ),
                      minimumSize: Size(double.infinity,
                          50), // Make the button fill the available width
                      disabledBackgroundColor: Colors.white, // Text color
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () => checkAnswer(false),
                    child: Text('False'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      textStyle: TextStyle(
                        fontSize: 15.0,
                      ),
                      minimumSize: Size(double.infinity,
                          50), // Make the button fill the available width
                      disabledBackgroundColor: Colors.white, // Text color
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Score: $score',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
