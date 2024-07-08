import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Images Screeen'),
      ),
      body: Column(
        children: [
          Text(''),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.camera),
                label: Text('Kamera'),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.image),
                label: Text('Galery'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Bekor Qilish'),
                  ),
                  TextButton(onPressed: () {}, child: Text('Saqlash'),),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
