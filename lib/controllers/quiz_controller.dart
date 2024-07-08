import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuizController with ChangeNotifier {
  final CollectionReference quizCollection = FirebaseFirestore.instance.collection('quizzes');

  Stream<QuerySnapshot> get list {
    return quizCollection.snapshots();
  }

  Future<void> addQuiz(String title, String question, List<String> options, int correctOptionIndex) {
    return quizCollection.add({
      'title': title,
      'question': question,
      'options': options,
      'correctOptionIndex': correctOptionIndex,
    });
  }

  Future<void> editQuiz(String id, String title, String question, List<String> options, int correctOptionIndex) {
    return quizCollection.doc(id).update({
      'title': title,
      'question': question,
      'options': options,
      'correctOptionIndex': correctOptionIndex,
    });
  }

  Future<void> deleteQuiz(String id) {
    return quizCollection.doc(id).delete();
  }
}
