import 'package:flutter/material.dart';
import 'package:event_connect/event_list.dart';
import 'package:event_connect/event_form.dart';
import 'package:event_connect/favorite_list.dart';
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
      home: HomeScreen(database: database),
      routes: {
        '/add': (context) => EventForm(database: database),
        '/favorites': (context) => FavoriteList(database: database),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  final AppDatabase database;

  const HomeScreen({Key? key, required this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Connect'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Favorites'),
              onTap: () {
                Navigator.pushNamed(context, '/favorites');
              },
            ),
            ListTile(
              title: const Text('Add Event'),
              onTap: () {
                Navigator.pushNamed(context, '/add');
              },
            ),
          ],
        ),
      ),
      body: EventList(database: database),
    );
  }
}
