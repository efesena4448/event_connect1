import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:event_connect/event.dart';
import 'package:event_connect/event_dao.dart';
import 'package:event_connect/favorite.dart';
import 'package:event_connect/favorite_dao.dart';
import 'package:event_connect/comment.dart';
import 'package:event_connect/comment_dao.dart';

part 'database.g.dart';

@Database(version: 1, entities: [Event, Favorite, Comment])
abstract class AppDatabase extends FloorDatabase {
  EventDao get eventDao;
  FavoriteDao get favoriteDao;
  CommentDao get commentDao;
}
