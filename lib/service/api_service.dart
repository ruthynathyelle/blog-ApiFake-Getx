// lib/services/api_service.dart

import 'package:dio/dio.dart';
import '../models/post_model.dart';

class ApiService {
  final Dio _dio = Dio();

  // URL base da API
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  // Método GET para buscar posts
  Future<List<PostModel>> fetchPosts() async {
    try {
      final response = await _dio.get('$baseUrl/posts');
      List<PostModel> posts = (response.data as List)
          .map((json) => PostModel.fromJson(json))
          .toList();
      return posts;
    } catch (e) {
      print('Erro ao buscar posts: $e');
      return [];
    }
  }

  // Método POST para criar um novo post
  Future<PostModel?> createPost(PostModel post) async {
    try {
      final response = await _dio.post(
        '$baseUrl/posts',
        data: post.toJson(),
      );
      return PostModel.fromJson(response.data);
    } catch (e) {
      print('Erro ao criar post: $e');
      return null;
    }
  }
}
