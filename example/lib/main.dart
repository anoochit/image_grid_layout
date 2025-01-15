import 'package:flutter/material.dart';
import 'package:image_grid_layout/image_grid_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Image Grid Layout'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // image list
  List<String> images = [
    'https://fastly.picsum.photos/id/156/2177/3264.jpg?hmac=hjKWxNR5fYw1fbGYXknGDH6eRORZ_AlTeQBvyT2q_Cs',
    'https://fastly.picsum.photos/id/157/5000/3914.jpg?hmac=A23PziOOpi_DIdiPRI30m9_1A8keOtMF3a6Vb-D7dRA',
    'https://fastly.picsum.photos/id/158/4836/3224.jpg?hmac=Gu_3j3HxZgR74iw1sV0wcwlnSZSeCi7zDWLcjblOp_c',
    'https://fastly.picsum.photos/id/159/5000/2460.jpg?hmac=h12oeFVhY4-vOrALaICJ4k4dqemWn1lvaMN8yvnIU1w',
    'https://fastly.picsum.photos/id/160/3200/2119.jpg?hmac=cz68HnnDt3XttIwIFu5ymcvkCp-YbkEBAM-Zgq-4DHE',
    'https://fastly.picsum.photos/id/161/4240/2832.jpg?hmac=LxG8oJEn91SpyJrBtLXd85CZfw9KBcI10x5c5M4Y_NQ',
    'https://fastly.picsum.photos/id/162/1500/998.jpg?hmac=j-Xr1aKHzCJQigPBLF0nKTudXM2w9u1-Smxlam0YOt8'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          ImageGrid(
            type: ImageGridType.frame,
            images: images,
          ),
        ],
      ),
    );
  }
}
