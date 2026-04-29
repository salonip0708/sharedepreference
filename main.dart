import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  String savedData = "";

  // Save Data
  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("myData", controller.text);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Data Saved")),
    );
  }

  // Load Data
  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedData = prefs.getString("myData") ?? "No Data Found";
    });
  }

  // Delete Data
  Future<void> deleteData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("myData");

    setState(() {
      savedData = "Data Deleted";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SharedPreferences Demo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "Enter Data",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveData,
              child: Text("Save Data"),
            ),

            ElevatedButton(
              onPressed: loadData,
              child: Text("Load Data"),
            ),

            ElevatedButton(
              onPressed: deleteData,
              child: Text("Delete Data"),
            ),

            SizedBox(height: 20),

            Text(
              "Saved Data: $savedData",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}