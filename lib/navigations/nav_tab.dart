import 'package:amianimauxx/race/racehome.dart';
import 'package:flutter/material.dart';

class NavTab extends StatelessWidget {
  final String userId;

  const NavTab({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Amis Animaux"),
          backgroundColor: Colors.green
      ),
      drawer: Drawer(
        child: Column(
          children: [
            AppBar(
              title: const Text("amis animaux"),
              automaticallyImplyLeading: false,
            ),
            ListTile(
              title: const Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Modifier Profil"),
                ],
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  "/home/updateUser",
                  arguments: {'userId': userId},
                );
              },
            ),
            ListTile(
              title: const Row(
                children: [
                  Icon(Icons.file_download_outlined),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Navigation du bas"),
                ],
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/homeBottom");
              },
            )
          ],
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(
                  text: "Race",
                  icon: Icon(Icons.show_chart),
                ),
                Tab(
                  text: "Reservations",
                  icon: Icon(Icons.shopping_basket),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Rhome(userId: userId), // Pass userId to Rhome
                  // Add your other TabBarView content here if needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
