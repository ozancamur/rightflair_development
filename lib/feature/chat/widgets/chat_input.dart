import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rightflair/core/constants/icons.dart';
import 'package:rightflair/core/constants/string.dart';
import 'package:rightflair/core/extensions/context.dart';
import 'package:rightflair/feature/chat/cubit/chat_cubit.dart';

class ChatInputWidget extends StatefulWidget {
  const ChatInputWidget({super.key});

  @override
  State<ChatInputWidget> createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _hasText = _controller.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final content = _controller.text.trim();
    if (content.isEmpty) return;

    context.read<ChatCubit>().sendMessage(content);
    _controller.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.width * 0.04,
        vertical: context.height * 0.01,
      ),
      decoration: BoxDecoration(
        color: context.colors.secondary,
        border: Border(
          top: BorderSide(
            color: context.colors.primary.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            _input(context),
            SizedBox(width: context.width * 0.02),
            _send(),
          ],
        ),
      ),
    );
  }

  Expanded _input(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: context.width * 0.04),
        decoration: BoxDecoration(
          color: context.colors.background,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: context.colors.primary.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                style: TextStyle(
                  color: context.colors.primary,
                  fontSize: context.width * 0.035,
                ),
                decoration: InputDecoration(
                  hintText: AppStrings.CHAT_TYPE_MESSAGE.tr(),
                  hintStyle: TextStyle(
                    color: context.colors.tertiary,
                    fontSize: context.width * 0.035,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: context.height * 0.012,
                  ),
                ),
                maxLines: 5,
                minLines: 1,
                textInputAction: TextInputAction.newline,
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BlocBuilder<ChatCubit, ChatState> _send() {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: state.isSending ? null : _sendMessage,
          child: Container(
            width: context.width * 0.11,
            height: context.width * 0.11,
            decoration: BoxDecoration(
              color: _hasText && !state.isSending
                  ? context.colors.primaryContainer
                  : context.colors.tertiary.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: state.isSending
                ? Padding(
                    padding: EdgeInsets.all(context.width * 0.03),
                    child: CircularProgressIndicator(
                      strokeWidth: context.width * 0.005,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        context.colors.onPrimaryContainer,
                      ),
                    ),
                  )
                : Center(
                    child: SvgPicture.asset(
                      AppIcons.SEND,
                      width: context.width * 0.05,
                      height: context.width * 0.05,
                      colorFilter: ColorFilter.mode(
                        _hasText
                            ? context.colors.onPrimaryContainer
                            : context.colors.tertiary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
