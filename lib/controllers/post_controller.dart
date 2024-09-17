// lib/controllers/post_controller.dart

import 'package:get/get.dart';
import '../models/post_model.dart';
import 'package:blog/service/api_service.dart';


class PostController extends GetxController {
  final ApiService _apiService = ApiService();
  var posts = <PostModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Busca posts da API - GET
  Future<void> fetchPosts() async {
    try {
      isLoading.value = true;
      var fetchedPosts = await _apiService.fetchPosts();
      posts.value = fetchedPosts;
    } catch (e) {
      errorMessage.value = 'Erro ao buscar posts: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // Cria um novo post - POST
  Future<void> createPost(String title, String body) async {
    try {
      var newPost = PostModel(id: 0, title: title, body: body); // id será atribuído pela API
      var createdPost = await _apiService.createPost(newPost);
      if (createdPost != null) {
        posts.add(createdPost);
      } else {
        errorMessage.value = 'Erro ao criar post';
      }
    } catch (e) {
      errorMessage.value = 'Erro: $e';
    }
  }
}
