import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'users_on_map.dart';
import 'widgets/my_row.dart';

class UsersDetailsScreen extends StatefulWidget {
  const UsersDetailsScreen({super.key});

  @override
  State<UsersDetailsScreen> createState() => _UsersDetailsScreenState();
}

class _UsersDetailsScreenState extends State<UsersDetailsScreen> {
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    getUserApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Display Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UsersOnMap(data: data),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                ReusableRow(title: 'Name', value: data[index]['name'].toString()),
                ReusableRow(title: 'Username', value: data[index]['username'].toString()),
                ReusableRow(title: 'Address', value: data[index]['address']['street'].toString()),
                ReusableRow(title: 'Lat', value: data[index]['address']['geo']['lat'].toString()),
                ReusableRow(title: 'Lng', value: data[index]['address']['geo']['lng'].toString()),
              ],
            ),
          );
        },
      ),
    );
  }

    Future<void> getUserApi() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body.toString());
      });
    }
  }
}
