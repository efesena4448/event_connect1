import 'package:floor/floor.dart';
import 'package:event_connect/comment.dart';

@dao
abstract class CommentDao {
  @Query('SELECT * FROM Comment WHERE eventId = :eventId')
  Future<List<Comment>> findCommentsByEventId(int eventId);

  @insert
  Future<void> insertComment(Comment comment);

  @delete
  Future<void> deleteComment(Comment comment);
}
