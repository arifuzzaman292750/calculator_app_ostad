import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class RestApiScreen extends StatefulWidget {
  const RestApiScreen({super.key});

  @override
  State<RestApiScreen> createState() => _RestApiScreenState();
}

class _RestApiScreenState extends State<RestApiScreen> {
  List _usersList = [];
  bool _isLoading = false;

  Future<void> fetchUsers() async {
    _isLoading = true;
    setState(() {});
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );
    _isLoading = false;
    setState(() {});

    if (response.statusCode == 200) {
      _usersList = jsonDecode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text(
          'User List',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? _buildShimmerEffect()
          : ListView.builder(
            itemCount: _usersList.length,
            itemBuilder: (context, index) {
              final user = _usersList[index];
              return Card(
                color: Colors.blue.shade300,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: ListTile(
                  leading: Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 22,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 20,
                        child: Text(
                          user['name'][0],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  title: Text(
                    'Name: ${user['name']}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    spacing: 2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('User Name: ${user['username']}',
                          style: TextStyle(fontSize: 16)),
                      Text('Email: ${user['email']}',
                          style: TextStyle(fontSize: 16)),
                      Text('Phone: ${user['phone']}',
                          style: TextStyle(fontSize: 16)),
                      Text('Website: ${user['website']}',
                          style: TextStyle(fontSize: 16)),
                      FittedBox(
                        child: Text(
                            'Address: ${user['address']['street']}, ${user['address']['suite']}',
                            style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }

  Widget _buildShimmerEffect() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: ListTile(
            leading: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: CircleAvatar(radius: 22, backgroundColor: Colors.white),
            ),
            title: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(height: 16, width: 100, color: Colors.white),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                  3,
                  (index) => Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                              height: 14, width: 150, color: Colors.white),
                        ),
                      )),
            ),
          ),
        );
      },
    );
  }
}
