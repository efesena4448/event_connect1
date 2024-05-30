import 'package:floor/floor.dart';

@entity
class Comment {
  @primaryKey
  final int id;
  final int eventId;
  final String text;
  final double rating;
  final String date;

  Comment(this.id, this.eventId, this.text, this.rating, this.date);
}
