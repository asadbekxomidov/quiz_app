import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz {
  final String id;
  final String title;
  final String question;
  final List<String> options;
  final int correctOptionIndex;

  Quiz({
    required this.id,
    required this.title,
    required this.question,
    required this.options,
    required this.correctOptionIndex,
  });

  factory Quiz.fromJson(QueryDocumentSnapshot query) {
    return Quiz(
      id: query.id,
      title: query['title'] ?? '',
      question: query['question'] ?? '',
      options: List<String>.from(query['options'] ?? []),
      correctOptionIndex: query['correctOptionIndex'] ?? 0,
    );
  }
}
