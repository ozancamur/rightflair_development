import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightflair/core/components/text.dart';
import 'package:rightflair/core/constants/font_size.dart';
import 'package:rightflair/core/constants/string.dart';
import 'package:rightflair/core/extensions/context.dart';
import 'package:rightflair/core/constants/dark_color.dart';

import '../cubit/create_post_cubit.dart';
import '../widgets/create_post_options.dart';
import '../widgets/create_post_appbar.dart';
import '../widgets/create_post_bottom_buttons.dart';
import '../widgets/create_post_description.dart';
import '../widgets/create_post_image_picker.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePostCubit, CreatePostState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppDarkColors.SECONDARY, // Matches AppBar
          appBar: CreatePostAppBarWidget(),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CreatePostImagePicker(),
                  SizedBox(height: context.height * 0.03),

                  // About your outfit section
                  TextComponent(
                    text: AppStrings.CREATE_POST_ABOUT_OUTFIT,
                    size: FontSizeConstants.LARGE,
                    weight: FontWeight.w600,
                  ),
                  SizedBox(height: context.height * 0.015),
                  CreatePostDescription(controller: _descriptionController),
                  SizedBox(height: context.height * 0.03),

                  // Options
                  CreatePostOptionsWidget(
                    isAnonymous: state.isAnonymous,
                    allowComments: state.allowComments,
                  ),
                  SizedBox(height: context.height * 0.02),

                  // Buttons
                  CreatePostBottomButtons(
                    onDraft: () {},
                    onPost: () {
                      context.read<CreatePostCubit>().createPost();
                    },
                  ),
                  SizedBox(height: context.height * 0.02),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
