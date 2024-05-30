import 'package:flutter/material.dart';
import 'package:event_connect/event_list.dart';
import 'package:event_connect/event_form.dart';
import 'package:event_connect/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;

  const MyApp({Key? key, required this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Connect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EventList(database: database), // Burada `database` argümanı ekleniyor
      routes: {
        '/add': (context) => EventForm(database: database),
      },
    );
  }
}
