// lib/views/home_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/post_controller.dart';

class HomePage extends StatelessWidget {
  final PostController postController = Get.put(PostController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Color.fromARGB(255, 169, 59, 200),

        title: Text('Blog',
        style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: bodyController,
              decoration: InputDecoration(labelText: 'Conteúdo'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                postController.createPost(
                  titleController.text,
                  bodyController.text,
                );
                titleController.clear();
                bodyController.clear();
              },
              child: Text('Criar Post'),
            ),
            SizedBox(height: 20),
            Obx(() {
              if (postController.isLoading.value) {
                return CircularProgressIndicator();
              } else if (postController.errorMessage.isNotEmpty) {
                return Text(postController.errorMessage.value);
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: postController.posts.length,
                    itemBuilder: (context, index) {
                      final post = postController.posts[index];
                      return ListTile(
                        title: Text(post.title),
                        subtitle: Text(post.body),
                      );
                    },
                  ),
                );
              }
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: postController.fetchPosts,
        child: Icon(Icons.refresh),
        tooltip: 'Atualizar Posts',
      ),
    );
  }
}
