class Question {
  final String id;
  final String question;
  final List<String> options;
  final int correctOptionIndex;

  Question(
      {required this.id,
      required this.question,
      required this.options,
      required this.correctOptionIndex});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['question'],
      options: List<String>.from(json['options']),
      correctOptionIndex: json['correctOptionIndex'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'options': options,
      'correctOptionIndex': correctOptionIndex,
    };
  }
}