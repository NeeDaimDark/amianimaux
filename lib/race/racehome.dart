import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'race_info.dart';

class Rhome extends StatefulWidget {
  final String? userId;

  const Rhome({Key? key, this.userId}) : super(key: key);

  @override
  State<Rhome> createState() => _RhomeState();
}

class _RhomeState extends State<Rhome> {
  final List<Race> _races = [];
  final String _baseUrl = "http://10.0.2.2:8000"; // Update the base URL with the correct port
  late Future<bool> _fetchedRaces;

  Future<bool> fetchRaces() async {
    try {
      String url = "$_baseUrl/race/races";
      print("Fetching data from: $url");

      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> racesFromServer = json.decode(response.body);
        setState(() {
          _races.clear(); // Clear existing races
          racesFromServer.forEach((element) {
            _races.add(Race(
              element["raceName"],
              element["description"],
              element["imageUrl"],
            ));
          });
        });
        return true;
      } else {
        print("Failed to fetch races. Status code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error fetching races: $e");
      return false;
    }
  }

  @override
  void initState() {
    _fetchedRaces = fetchRaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _fetchedRaces,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Center the loading indicator
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else {
          return ListView.builder(
            itemCount: _races.length,
            itemBuilder: (BuildContext context, int index) {
              return RaceInfo(_races[index]);
            },
          );
        }
      },
    );
  }
}

class Race {
  final String raceName;
  final String description;
  final String imageUrl;

  Race(this.raceName, this.description, this.imageUrl);

  @override
  String toString() {
    return 'Race{raceName: $raceName, description: $description, imageUrl: $imageUrl}';
  }
}
