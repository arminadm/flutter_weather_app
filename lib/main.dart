import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IndexWeatherPage(),
    ),
  );
}

class IndexWeatherPage extends StatefulWidget {
  const IndexWeatherPage({Key? key}) : super(key: key);

  @override
  State<IndexWeatherPage> createState() => _IndexWeatherPageState();
}

class _IndexWeatherPageState extends State<IndexWeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/index_bg.jpg'),
            fit: BoxFit.cover
          )
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Center(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 45),
                  child: Text('Mountain View', style: TextStyle(
                    color: Colors.white, fontSize: 35
                  )),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text('Clear Sky', style: TextStyle(
                    color: Colors.white, fontSize: 20
                  )),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 35),
                  child: Icon(Icons.wb_sunny_outlined, color: Colors.white, size: 65,)
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text("14" "\u00B0", style: TextStyle(
                    color: Colors.white, fontSize: 30
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: const [
                          Text('max', style: TextStyle(color: Colors.white, fontSize: 10),),
                          Text('16' '\u00B0', style: TextStyle(color: Colors.white, fontSize: 10),),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          height: 20,
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          children: const [
                            Text('min', style: TextStyle(color: Colors.white, fontSize: 10),),
                            Text('12' '\u00B0', style: TextStyle(color: Colors.white, fontSize: 10),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    width: double.infinity,
                    height: 80,
                    child: Center(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        itemBuilder: (BuildContext context, int pos) {
                          return Container(
                            height: 50,
                            width: 50,
                            child: Card(
                              color: Colors.transparent,
                              child: Column(children: const [
                                Text('Fri, 8pm', style: TextStyle(fontSize: 10, color: Colors.white)),
                                Icon(Icons.cloud, color: Colors.white),
                                Text('14' '\u00B0', style: TextStyle(fontSize: 15, color: Colors.white)),
                              ]),
                            ),
                          );
                        }
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 35,
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Column(children: const [
                      Text('wind speed', style: TextStyle(fontSize: 10, color: Colors.grey)),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text('4.73 m/s', style: TextStyle(fontSize: 10, color: Colors.white)),
                        ),
                      ]),
        
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Container(
                        height: 38,
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
        
                    Column(children: const [
                      Text('sunrise', style: TextStyle(fontSize: 10, color: Colors.grey)),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text('6:19 PM', style: TextStyle(fontSize: 10, color: Colors.white)),
                        ),
                      ]),
        
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Container(
                        height: 38,
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
        
                    Column(children: const [
                      Text('sunset', style: TextStyle(fontSize: 10, color: Colors.grey)),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text('9:30 AM', style: TextStyle(fontSize: 10, color: Colors.white)),
                        ),
                      ]),
        
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Container(
                        height: 38,
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
        
                    Column(children: const [
                      Text('humidity', style: TextStyle(fontSize: 10, color: Colors.grey)),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text('72%', style: TextStyle(fontSize: 10, color: Colors.white)),
                        ),
                      ])
                  ]),
                )
              ]
            ),
          ),
        ), 
      ),
    );
  }
}