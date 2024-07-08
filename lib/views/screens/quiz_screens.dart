// ignore_for_file: unnecessary_import, use_super_parameters, unused_local_variable

import 'package:dars_5/service/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:dars_5/controllers/quiz_controller.dart';
import 'package:dars_5/model/quiz.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  final titleController = TextEditingController();
  final questionController = TextEditingController();
  final optionsController = TextEditingController();
  final correctOptionIndexController = TextEditingController();
  int? selectedOptionIndex;
  int currentQuestionIndex = 0;
  AnimationController? _animationController;
  Animation<double>? _animation;
  String feedbackMessage = "";

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    );
    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  void _nextQuestion() {
    setState(() {
      currentQuestionIndex++;
      selectedOptionIndex = null;
      feedbackMessage = "";
    });
    _animationController!.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final quizController = context.watch<QuizController>();
    final fireBaseAuthService = FireBaseAuthService();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 168, 111, 243),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 168, 111, 243),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(
              Icons.logout,
              size: 25,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: quizController.list,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data == null) {
              return const Center(child: Text("No quizzes available"));
            }
            final quizzes = snapshot.data!.docs;
            if (currentQuestionIndex >= quizzes.length) {
              return const Center(child: Text("You've completed all quizzes!"));
            }
            final quiz = Quiz.fromJson(quizzes[currentQuestionIndex]);

            return FadeTransition(
              opacity: _animation!,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: const DecorationImage(
                              image:
                                  AssetImage('assets/images/imagesstiker.jpg'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 35),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(
                            quiz.question,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 140),
                    const SizedBox(height: 200),
                    ...List.generate(quiz.options.length, (optionIndex) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: selectedOptionIndex == optionIndex
                              ? Colors.white
                              : Colors.black,
                          backgroundColor: selectedOptionIndex == optionIndex
                              ? Colors.blueGrey
                              : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedOptionIndex = optionIndex;
                            if (optionIndex == quiz.correctOptionIndex) {
                              feedbackMessage = "Correct Answer!";
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                _nextQuestion();
                              });
                            } else {
                              feedbackMessage = "Wrong Answer!";
                            }
                          });
                        },
                        child: Text(quiz.options[optionIndex]),
                      );
                    }),
                    if (feedbackMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          feedbackMessage,
                          style: TextStyle(
                            color: feedbackMessage == "Correct Answer!"
                                ? Colors.green.shade900
                                : Colors.red.shade900,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.blue,
        onPressed: () {
          titleController.clear();
          questionController.clear();
          optionsController.clear();
          correctOptionIndexController.clear();

          showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text("Add Quiz"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    TextField(
                      controller: questionController,
                      decoration: const InputDecoration(labelText: 'Question'),
                    ),
                    TextField(
                      controller: optionsController,
                      decoration: const InputDecoration(
                          labelText: 'Options (comma separated)'),
                    ),
                    TextField(
                      controller: correctOptionIndexController,
                      decoration: const InputDecoration(
                          labelText: 'Correct Option Index'),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      final options = optionsController.text.split(',');
                      quizController.addQuiz(
                        titleController.text,
                        questionController.text,
                        options,
                        int.parse(correctOptionIndexController.text),
                      );
                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
          size: 35,
          color: Colors.white,
        ),
      ),
    );
  }
}
