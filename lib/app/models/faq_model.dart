class FaqModel {
  String id;
  String title;
  String question;
  String answer;

  FaqModel({
    required this.id,
    required this.title,
    required this.question,
    required this.answer,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      id: json['id'],
      title: json['title'],
      question: json['meta']['question']['content'],
      answer: json['meta']['answer']['content'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    final meta = <String, dynamic>{};
    final questionMeta = <String, dynamic>{};
    questionMeta['content'] = question;
    meta['question'] = questionMeta;
    final answerMeta = <String, dynamic>{};
    answerMeta['content'] = answer;
    meta['answer'] = answerMeta;
    data['meta'] = meta;
    return data;
  }
}
