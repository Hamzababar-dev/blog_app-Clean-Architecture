import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract interface class BlogLocalDataSource {
  void uploadLocalBlogs({required List<BlogModel> blogs});
  List<BlogModel> loadBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;

  BlogLocalDataSourceImpl(this.box);

  @override
  List<BlogModel> loadBlogs() {
    final List<BlogModel> blogs = [];

    for (final value in box.values) {
      final Map<String, dynamic> blogMap =
      Map<String, dynamic>.from(value as Map);

      blogs.add(BlogModel.fromJson(blogMap));
    }

    return blogs;
  }

  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) {
    box.clear();

    for (int i = 0; i < blogs.length; i++) {
      box.put(i, blogs[i].toJson()); // use int keys
    }
  }
}
