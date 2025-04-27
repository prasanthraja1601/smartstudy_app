import 'package:flutter/material.dart';

void main() {
  runApp(SmartStudyApp());
}

class SmartStudyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartStudy Hub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SmartStudy Hub'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MenuButton(title: '📂 Study Materials', screen: StudyMaterialsScreen()),
            MenuButton(title: '🧠 Flashcards', screen: FlashcardsScreen()),
            MenuButton(title: '📝 Online Tests', screen: TestsScreen()),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String title;
  final Widget screen;

  MenuButton({required this.title, required this.screen});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          textStyle: TextStyle(fontSize: 20),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        child: Text(title),
      ),
    );
  }
}

// Study Materials Screen
class StudyMaterialsScreen extends StatelessWidget {
  final List<String> materials = [
    "Physics Notes - Chapter 1",
    "Mathematics Notes - Algebra",
    "Biology Notes - Cell Structure",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Study Materials')),
      body: ListView.builder(
        itemCount: materials.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(materials[index]),
            leading: Icon(Icons.picture_as_pdf),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Opening ${materials[index]}...')),
              );
            },
          );
        },
      ),
    );
  }
}

// Flashcards Screen
class FlashcardsScreen extends StatelessWidget {
  final List<Map<String, String>> flashcards = [
    {'question': 'What is Newton\'s First Law?', 'answer': 'An object in motion stays in motion.'},
    {'question': 'What is 2 + 2?', 'answer': '4'},
    {'question': 'Cell powerhouse?', 'answer': 'Mitochondria'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flashcards')),
      body: ListView.builder(
        itemCount: flashcards.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(flashcards[index]['question']!),
              subtitle: Text(flashcards[index]['answer']!),
            ),
          );
        },
      ),
    );
  }
}

// Tests Screen
class TestsScreen extends StatelessWidget {
  final List<Map<String, Object>> questions = [
    {
      'question': 'What is the capital of France?',
      'options': ['Paris', 'London', 'Rome', 'Berlin'],
      'answer': 'Paris'
    },
    {
      'question': 'What planet is known as the Red Planet?',
      'options': ['Earth', 'Mars', 'Venus', 'Jupiter'],
      'answer': 'Mars'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Online Tests')),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          var q = questions[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(q['question'] as String),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                    title: Text('Choose an answer'),
                    children: (q['options'] as List<String>).map((option) {
                      return SimpleDialogOption(
                        child: Text(option),
                        onPressed: () {
                          Navigator.pop(context);
                          bool correct = option == q['answer'];
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(correct ? 'Correct!' : 'Wrong!')),
                          );
                        },
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
