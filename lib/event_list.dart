import 'package:flutter/material.dart';
import 'package:event_connect/event.dart';
import 'package:event_connect/database.dart';
import 'event_detail.dart';

class EventList extends StatefulWidget {
  final AppDatabase database;

  const EventList({Key? key, required this.database}) : super(key: key);

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  Future<List<Event>> _fetchEvents() async {
    return await widget.database.eventDao.findAllEvents();
  }

  void _addEvent() async {
    await Navigator.pushNamed(context, '/add');
    setState(() {}); // Refresh the list after adding a new event
  }

  void _showEventDetails(Event event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventDetail(event: event),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event List'),
      ),
      body: FutureBuilder<List<Event>>(
        future: _fetchEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading events'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No events found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final event = snapshot.data![index];
                return ListTile(
                  title: Text(event.name),
                  subtitle: Text(event.description),
                  trailing: Text(event.date),
                  onTap: () => _showEventDetails(event),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEvent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
