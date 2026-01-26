import '../../navigation/page/feed/models/comment.dart';
import '../../navigation/page/feed/models/request_comment.dart';

abstract class CommentsRepository {
    Future<List<CommentModel>?> fetchPostComments({required String pId});
  Future<CommentModel?> sendCommentToPost({required RequestCommentModel body});
}