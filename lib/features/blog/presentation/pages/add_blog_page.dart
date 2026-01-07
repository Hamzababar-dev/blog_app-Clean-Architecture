import 'dart:io';

import 'package:blog_app/core/common/cubits/app_user_cubit.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/constants/constants.dart';
import 'package:blog_app/core/theme/appcolors.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/blog/presentation/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBlogPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddBlogPage());

  const AddBlogPage({super.key});

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? image;
  List<String> selectedChips = [];

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }
  void uploadBlog() {
    if (formKey.currentState!.validate() &&
        selectedChips.isNotEmpty &&
        image != null) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn)
              .user
              .id;

      context.read<BlogBloc>().add(
        BlogUpload(
          posterId: posterId,
          title: titleController.text.trim(),
          content: contentController.text.trim(),
          image: image!,
          topics: selectedChips,
        ),
      );
    }
  }
  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
              uploadBlog();
            },
            icon: const Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
  listener: (context, state) {
    if(state is BlogFailure){
      showSnackBar(context, state.error);
    }else if(state is BlogUploadSuccess){
      Navigator.pushAndRemoveUntil(context, BlogPage.route(), (route) => false,
      );

    }
  },
  builder: (context, state) {
    if(state is BlogLoading){
      return const Loader();
    }
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                image != null
                    ? GestureDetector(
                        onTap: selectImage,
                        child: SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(10),
                            child: Image.file(image!, fit: BoxFit.fill),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          print('selected');
                          selectImage();
                        },
                        child: DottedBorder(
                          options: RoundedRectDottedBorderOptions(
                            radius: Radius.circular(10),
                            color: AppColors.borderColor,
                            dashPattern: [10, 4],
                            strokeCap: StrokeCap.round,
                            strokeWidth: 2,
                          ),
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            // This is now correct because of the alignment
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.folder_open, size: 40),
                                SizedBox(height: 15),
                                Text(
                                  'Please Select an image',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                              Constants.topics
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    if (selectedChips.contains(e)) {
                                      selectedChips.remove(e);
                                    } else {
                                      selectedChips.add(e);
                                    }
                                    setState(() {});
                                  },
                                  child: Chip(
                                    label: Text(e),
                                    color: selectedChips.contains(e)
                                        ? MaterialStatePropertyAll(
                                            AppColors.gradient2,
                                          )
                                        : null,
                                    side: selectedChips.contains(e)
                                        ? null
                                        : BorderSide(
                                            color: AppColors.borderColor,
                                          ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
                SizedBox(height: 15),
                BlogField(controller: titleController, hintText: 'Blog title',),
                SizedBox(height: 10),
                BlogField(

                  controller: contentController,
                  hintText: 'Blog content',
                ),
              ],
            ),
          ),
        ),
      );
  },
),
    );
  }
}
