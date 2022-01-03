import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sample_project/data/api.dart';
import 'package:sample_project/data/station.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  TextEditingController stationController = TextEditingController();
  StationApi api = StationApi();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            // InkWell(
            //   child: Container(
            //     width: 20,
            //     height: 30,
            //     decoration: BoxDecoration(
            //         color: Colors.amberAccent,
            //         borderRadius: BorderRadius.circular(17)
            //     ),
            //   ),
            //   onTap: () {
            //     return;
            //   },
            // ),
            TextField(
              maxLines: 1,
              minLines: 1,
              keyboardType: TextInputType.text,
              controller: stationController,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.amberAccent,
                          width: 0.5
                      ),
                      borderRadius: BorderRadius.circular(8)
                  )
              ),
              onChanged: (text) async {
                List<Station> stations = await api.getSubwayStation(text);

                for(final d in stations){
                  print(d.code);
                  print(d.name_kor);
                  print(d.name_eng);
                  print(d.line_num);
                }
              },
            )
          ],
        )
      ),
    );
  }
}
