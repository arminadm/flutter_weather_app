import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course_b/Model/CurrentDayWeather.dart';
import 'package:flutter_course_b/Model/SevenDaysForecast.dart';
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
  late StreamController<List<SevenDaysForecast>> six_days_forecast;

  @override
  void initState() {
    // Call OpenWeather API
    super.initState();
    FuCurrentDayWeather = get_current_weather('tehran');
    six_days_forecast = StreamController<List<SevenDaysForecast>>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: const Text('weather app'),
        backgroundColor: Color.fromARGB(255, 2, 119, 143),
        actions: <Widget>[
          PopupMenuButton<String> (itemBuilder: (BuildContext context){
            return {"this is", "just for", "testing"}.map((String choice) {
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
            six_days_forecast.add(get_six_days_forecast(CurrentWeatherData!.dt));
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
                                  backgroundColor: Color.fromARGB(255, 3, 127, 157)
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
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Color.fromARGB(255, 3, 127, 157))
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Color.fromARGB(255, 3, 127, 157))
                                    ),
                                    hintText: 'Enter a city name',
                                    hintStyle: TextStyle(color: Colors.white)
                                  ),
                                  style: TextStyle(color: Colors.white),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 35),
                        child: Image.network(
                          get_icon_url(CurrentWeatherData.icon),
                          scale: 0.6,),
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
                            child: StreamBuilder<List<SevenDaysForecast>>(
                              stream: six_days_forecast.stream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData){
                                  List<SevenDaysForecast>? forecast_list = snapshot.data;
                                  return ListView.builder(
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
                                        child: Column(children: [
                                          Text(forecast_list![pos].date.toString(), 
                                          style: const TextStyle(fontSize: 10, color: Colors.white)),
                                          Icon(generate_random_icon(forecast_list[pos].icon), color: Colors.white,),
                                          Text(forecast_list[pos].temp.toString() + '\u00B0', 
                                          style: const TextStyle(fontSize: 15, color: Colors.white)),
                                        ]),
                                      ),
                                    );
                                  }
                                );}
                                else {
                                  return Center(
                                    child: JumpingDotsProgressIndicator(
                                      color: Colors.black,
                                      dotSpacing: 3,
                                      fontSize: 80,
                                    ),
                                  );}
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

    // generate required data
    var sunrise = Convert_milisecs_to_std_time(current_weather.data['sys']['sunrise']);
    var sunset = Convert_milisecs_to_std_time(current_weather.data['sys']['sunset']);

    // creating current weather data model so later
    // we can use it in UI
    var CurrentWeatherDataModel = CurrentDayWeather(
      lat,
      lon,
      current_weather.data['dt'],
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
      current_weather.data['weather'][0]['icon'],
    );

    return CurrentWeatherDataModel;
  }

  List<SevenDaysForecast> get_six_days_forecast(time){
    // for saving days data
    List<SevenDaysForecast> six_days_list  = [];
    // this function was about to getting the weather
    // data of the next 6 days, but open weather api
    // doesn't serve these data as free service
    // so we generate random data
    for (int i = 0; i < 7; i++){
      // we have to increase time by a day after each iteration
      var millis = time * 1000;
      var dt = DateTime.fromMillisecondsSinceEpoch(millis);
      SevenDaysForecast model = SevenDaysForecast(
        Random().nextInt(50) - 15,
        Random().nextInt(5),
        DateFormat.MMMd().format(DateTime(dt.year, dt.month, dt.day + i)).toString(),
      );

      six_days_list.add(model);
    }
    return six_days_list;
  }

  String Convert_milisecs_to_std_time(time) {
    var millis = time * 1000;
    var dt = DateTime.fromMillisecondsSinceEpoch(millis);
    var time24 = DateFormat('HH:mm').format(dt);
    return time24.toString();
  }

  String get_icon_url(img_code) {
    String url = "http://openweathermap.org/img/w/${img_code}.png";
    return url;
  }

  IconData generate_random_icon(code) {
    if (code == 0) return Icons.cloud;
    else if (code == 1) return Icons.cloudy_snowing;
    else if (code == 2) return Icons.sunny_snowing;
    else if (code == 3) return Icons.sunny;
    else if (code == 4) return Icons.storm;
    else return Icons.error;
  }

}