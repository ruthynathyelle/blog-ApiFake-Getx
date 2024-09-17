// lib/models/post_model.dart

class PostModel {
  final int id;
  final String title;
  final String body;

  PostModel({
    required this.id,
    required this.title,
    required this.body,
  });

  // Converte um JSON para um PostModel
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  // Converte um PostModel para JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
    };
  }
}
