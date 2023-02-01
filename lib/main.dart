import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course_b/Model/CurrentDayWeather.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';

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
  // initializing variables
  TextEditingController  textEditingController = TextEditingController();
  late Future<CurrentDayWeather> FuCurrentDayWeather;

  @override
  void initState() {
    // Call OpenWeather API
    super.initState();
    FuCurrentDayWeather = get_current_weather('tehran');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('weather app'),
        backgroundColor: Color.fromARGB(255, 38, 38, 38),
        actions: <Widget>[
          PopupMenuButton<String> (itemBuilder: (BuildContext context){
            return {"setting", "logout", "profile"}.map((String choice) {
              return PopupMenuItem(
                value: choice,
                child: Text(choice)
              );
            }).toList();
          })
        ],
      ),
      body:FutureBuilder(
        future: FuCurrentDayWeather,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            CurrentDayWeather? CurrentWeatherData = snapshot.data;

            return Container(
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
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 42, 42, 42)
                                ),
                                onPressed: (){
                                  setState(() {
                                    FuCurrentDayWeather = get_current_weather(textEditingController.text);
                                  });
                                }, 
                                child: const Text('Find', style: TextStyle(fontSize: 15),),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 12),
                                child: TextField(
                                  controller: textEditingController,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: 'Enter a city name'
                                  ),
                                ),
                              ))
                          ],
                        ),
                      Padding(
                        padding: const EdgeInsets.only(top: 45),
                        child: Text(CurrentWeatherData!.city_name, style: const TextStyle(
                          color: Colors.white, fontSize: 35
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(CurrentWeatherData.description, style: const TextStyle(
                          color: Colors.white, fontSize: 20
                        )),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 35),
                        child: Icon(Icons.wb_sunny_outlined, color: Colors.white, size: 65,)
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(CurrentWeatherData.temp.toString() + "\u00B0", style: const TextStyle(
                          color: Colors.white, fontSize: 30
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                const Text('max', style: TextStyle(color: Colors.white, fontSize: 10),),
                                Text(CurrentWeatherData.temp_max.toString() + '\u00B0',
                                style: const TextStyle(color: Colors.white, fontSize: 10),),
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
                                children: [
                                  const Text('min', style: TextStyle(color: Colors.white, fontSize: 10),),
                                  Text(CurrentWeatherData.temp_min.toString() + '\u00B0', 
                                  style: const TextStyle(color: Colors.white, fontSize: 10),),
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
                                    elevation: 0,
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
                          Column(children: [
                              const Text('wind speed', style: TextStyle(fontSize: 10, color: Colors.grey)),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(CurrentWeatherData.wind_speed.toString() + ' m/s', 
                                style: const TextStyle(fontSize: 10, color: Colors.white)),
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
              
                          Column(children: [
                            const Text('sunrise', style: TextStyle(fontSize: 10, color: Colors.grey)),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(CurrentWeatherData.sunrise.toString(), 
                              style: const TextStyle(fontSize: 10, color: Colors.white)),
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
              
                          Column(children: [
                            const Text('sunset', style: TextStyle(fontSize: 10, color: Colors.grey)),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                                child: Text(CurrentWeatherData.sunset.toString(), 
                                style: const TextStyle(fontSize: 10, color: Colors.white)),
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
              
                          Column(children: [
                            const Text('humidity', style: TextStyle(fontSize: 10, color: Colors.grey)),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(CurrentWeatherData.humidity.toString() + '%', 
                              style: const TextStyle(fontSize: 10, color: Colors.white)),
                              ),
                            ])
                        ]),
                      )
                    ]
                  ),
                ),
              ), 
            );
          }
          else{
            return Center(
              child: JumpingDotsProgressIndicator(
                color: Colors.black,
                dotSpacing: 3,
                fontSize: 80,
              ),
            );
          }
        },
      ) 
      
    );
  }

  Future<CurrentDayWeather> get_current_weather(city_name) async {
    var api_key = "522461028f3976c593ad2b47985ec2a3";

    // getting lat and lon of the selected city
    var lat_lon_response = await Dio().get(
      "http://api.openweathermap.org/geo/1.0/direct",
      queryParameters: {
        "q": city_name,
        "limit": 1,
        "appid": api_key
      },
    );
    var lat = lat_lon_response.data[0]['lat'].toString();
    var lon = lat_lon_response.data[0]['lon'].toString();

    // getting current weather of this lat and lon
    var current_weather = await Dio().get(
      "https://api.openweathermap.org/data/2.5/weather",
      queryParameters: {
        "lat": lat,
        "lon": lon,
        "units": "metric",
        "appid": api_key
      },
    );


    var sunrise = Convert_milisecs_to_std_time(current_weather.data['sys']['sunrise']);
    var sunset = Convert_milisecs_to_std_time(current_weather.data['sys']['sunset']);
    
    // creating current weather data model so later
    // we can use it in UI
    var CurrentWeatherDataModel = CurrentDayWeather(
      lat,
      lon,
      current_weather.data['weather'][0]['main'],
      current_weather.data['weather'][0]['description'],
      current_weather.data['main']['temp'],
      current_weather.data['main']['temp_min'],
      current_weather.data['main']['temp_max'],
      current_weather.data['wind']['speed'],
      sunrise,
      sunset,
      current_weather.data['main']['humidity'],
      city_name,
    );

    return CurrentWeatherDataModel;
  }

  String Convert_milisecs_to_std_time(time) {
    var millis = time * 1000;
    var dt = DateTime.fromMillisecondsSinceEpoch(millis);
    var time24 = DateFormat('HH:mm').format(dt);
    return time24.toString();
  }
}