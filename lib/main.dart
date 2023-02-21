import 'dart:convert';

import 'package:apiget/common.dart';
import 'package:apiget/userdata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'detailpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<UserData> userList = [];
  List<UserData> searUserList = [];
  final _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _getData();
    super.initState();
  }

  _getData() async {
    var client = http.Client();
    var url = "https://api.publicapis.org/entries";
    var uri = Uri.parse(url);
    var response = await client.get(uri);

    Map<String, dynamic> uMap = jsonDecode(response.body);
    List<dynamic> uList = uMap["entries"];
    for (int i = 0; i < uList.length; i++) {
      Map<String, dynamic> userMap = uList[i];
      UserData userData = UserData.fromJson(userMap);

      userList.add(userData);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: userList.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    width: double.infinity,
                    color: Colors.brown[200],
                    child: const Text(
                      "Business",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  _textInput(),
                  Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: _searchController.text.isEmpty
                            ? userList.length
                            : searUserList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _listItem(index);
                        }),
                  )
                ],
              ),
      ),
    );
  }

  Widget _listItem(int index) {
    UserData userData =
        _searchController.text.isEmpty ? userList[index] : searUserList[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailPage(
                    userData: userData,
                  )),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.brown[100],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Image.asset(
                Common.imageCategory(userData.Category),
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Category : ${userData.Category}".toUpperCase(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  Text(
                    "Api : ${userData.API}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  Text(
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    softWrap: false,
                    "Dec : ${userData.Description}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  Row(
                    children: [
                      Text(
                        "Cors : ${userData.Cors}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      Checkbox(
                        checkColor: Colors.white,
                        value: check(userData.Cors!),
                        onChanged: (bool? value) {
                          checked(index, value!);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  checked(int index, bool isSelect) {
    userList[index].Cors = isSelect ? 'yes' : 'no';
    setState(() {});
  }

  bool check(String cors) {
    if (cors == "yes") {
      return true;
    } else {
      return false;
    }
  }

  Widget _textInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          _searchUser(value);
        },
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          hintText: "Search",
          labelText: "search",
          suffixIcon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  _searchUser(String str) {
    searUserList.clear();
    if (str.isNotEmpty) {
      for (int i = 0; i < userList.length; i++) {
        if (userList[i].API.toLowerCase().contains(str.toLowerCase())) {
          searUserList.add(userList[i]);
        }
      }
    }
    setState(() {});
  }
}
