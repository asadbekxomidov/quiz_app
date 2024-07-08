import 'package:cloud_firestore/cloud_firestore.dart';

class QuizService {
  final CollectionReference _quizCollection = FirebaseFirestore.instance.collection("quizzes");

  Stream<QuerySnapshot> getQuizzes() {
    return _quizCollection.snapshots();
  }

  void addQuiz(String title, String question, List<String> options, int correctOptionIndex) {
    _quizCollection.add({
      "title": title,
      "question": question,
      "options": options,
      "correctOptionIndex": correctOptionIndex,
    });
  }

  void editQuiz(String id, String title, String question, List<String> options, int correctOptionIndex) {
    _quizCollection.doc(id).update({
      "title": title,
      "question": question,
      "options": options,
      "correctOptionIndex": correctOptionIndex,
    });
  }
}
