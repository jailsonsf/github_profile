import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  String? username;

  Future<dynamic> callAPI() async {
    var client = http.Client();
    try {
      var response = await client.get(
        Uri.parse('https://api.github.com/users/$username'),
      );
      var decodedResponse = jsonDecode(response.body);
      return decodedResponse;
    } finally {
      client.close();
    }
  }

  @override
  void initState() {
    super.initState();

    callAPI().then((map) {
      // print(map);
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      username = ModalRoute.of(context)!.settings.arguments as String;
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('GitHub Profile'),
      ),
      body: FutureBuilder(
        future: callAPI(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center(
                child: Container(
                  width: 200,
                  height: 200,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 5.0,
                  ),
                ),
              );
            default:
              if (snapshot.hasError) {
                return Container();
              } else {
                return _createProfilePage(context, snapshot);
              }
          }
        },
      ),
    );
  }

  Widget _createProfilePage(BuildContext context, AsyncSnapshot snapshot) {
    return FutureBuilder(
      builder: (context, index) {
        return Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    snapshot.data["avatar_url"],
                  ),
                  radius: 100,
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  snapshot.data["name"],
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  snapshot.data["login"],
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    snapshot.data["bio"],
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.account_circle),
                      const SizedBox(width: 10),
                      Text(snapshot.data["followers"].toString() +
                          " seguidores"),
                      const SizedBox(width: 10),
                      Text(snapshot.data["following"].toString() + " seguindo"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
