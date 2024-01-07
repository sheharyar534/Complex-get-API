import 'dart:convert';

import 'package:complex_api/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUser() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // ignore: unused_local_variable
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Third Api")),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getUser(),
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        if (!snapshot.hasData) {
                          return const Text("nahi hai");
                        } else {
                          return Card(
                              child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "name",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(userList[index].name.toString()),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "email",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(userList[index].email.toString()),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "address",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(userList[index].address!.city.toString()),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "lat",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(userList[index]
                                    .address!
                                    .geo!
                                    .lat
                                    .toString()),
                              ],
                            ),
                          ]));
                        }
                      });
                }),
          )
        ],
      ),
    );
  }
}
