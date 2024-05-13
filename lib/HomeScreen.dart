import 'package:flutter/material.dart';
import 'package:mediscantstv2/Image_Picker.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MEDISCAN"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 111, 228, 15),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/plant.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImagePickerPage(),
                  ),
                );
              },
              child: const Text('Scan Plant'),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}