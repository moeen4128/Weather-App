import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset('assets/10.png');

      case >= 300 && < 400:
        return Image.asset('assets/rain.png');

      case >= 500 && < 600:
        return Image.asset('assets/snow.png');

      case >= 600 && < 700:
        return Image.asset('assets/windyyy.png');

      case >= 700 && < 800:
        return Image.asset('assets/10.png');

      case == 800:
        return Image.asset('assets/suncl.png');

      // case >= 200 && < 300:
      //   return Image.asset('assets/hot.png');

      case >= 800 && < 804:
        return Image.asset('assets/suncl.png');

      default:
        return Image.asset('assets/hot.png');
    }
  }

  Widget GreetingTimes(String format) {
    print(format);
    int value = int.parse(format);
    // final hour = DateTime.now().hour;

    if (value >= 6 && value <= 7) {
      return const Text(
        'Sunrise',
        style: TextStyle(
            color: Color.fromARGB(255, 158, 156, 156),
            fontWeight: FontWeight.bold,
            fontSize: 22),
      );
    } else if (value >= 12 && value <= 14) {
      return const Text(
        'Good afternoon',
        style: TextStyle(
            color: Color.fromARGB(255, 220, 156, 156),
            fontWeight: FontWeight.bold,
            fontSize: 22),
      );
    } else if (value >= 8 && value <= 11) {
      return const Text(
        'Good Morning',
        style: TextStyle(
            color: Color.fromARGB(255, 193, 155, 155),
            fontWeight: FontWeight.bold,
            fontSize: 22),
      );
    } else if (value >= 15 && value <= 18) {
      return const Text(
        'Good evening',
        style: TextStyle(
            color: Color.fromARGB(255, 244, 136, 136),
            fontWeight: FontWeight.bold,
            fontSize: 22),
      );
    } else {
      return const Text('Good night',
          style: TextStyle(
              color: Color.fromARGB(255, 148, 145, 145),
              fontWeight: FontWeight.bold,
              fontSize: 22));
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
        builder: (context, state) {
          if (state is WeatherBlocSuccess) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
              child: Stack(
                children: [
                  Positioned(
                    top: 250,
                    right: 0,
                    child: Container(
                      height: 250,
                      width: 250,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.purple),
                    ),
                  ),
                  Positioned(
                    top: 250,
                    left: 0,
                    child: Container(
                      height: 100,
                      width: 250,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.purple),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      height: 100,
                      width: 250,
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle, color: Colors.orange),
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
                    child: Container(
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '📍${state.weather.areaName}',
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                      ),
                      GreetingTimes(
                        DateFormat().add_H().format(state.weather.date!),
                      )
                    ],
                  ),
                  Positioned.fill(
                      top: 60,
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                              height: 258,
                              child: getWeatherIcon(
                                  state.weather.weatherConditionCode!)))),
                  Positioned.fill(
                      top: 350,
                      right: 10,
                      child: Builder(builder: (context) {
                        return Container(
                          child: Column(
                            children: [
                              Text(
                                '${state.weather.temperature!.celsius!.round()}°C',
                                style: const TextStyle(
                                    fontSize: 33,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                '${state.weather.weatherMain}',
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.white),
                              ),
                              Text(
                                DateFormat('EEEE dd .')
                                    .add_jm()
                                    .format(state.weather.date!),
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    color: Color.fromARGB(255, 193, 178, 178)),
                              )
                            ],
                          ),
                        );
                      })),
                  Positioned(
                      bottom: 180,
                      left: 22,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height: 60,
                                      child: Image.asset('assets/2.png')),
                                  Column(
                                    children: [
                                      const Text(
                                        'Sunrise',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                            color: Color.fromARGB(
                                                255, 193, 178, 178)),
                                      ),
                                      Text(
                                        DateFormat()
                                            .add_jm()
                                            .format(state.weather.sunrise!),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(width: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height: 60,
                                      child: Image.asset('assets/3.png')),
                                  Column(
                                    children: [
                                      const Text(
                                        'Sunset',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                            color: Color.fromARGB(
                                                255, 193, 178, 178)),
                                      ),
                                      Text(
                                        DateFormat()
                                            .add_jm()
                                            .format(state.weather.sunset!),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: Container(
                              height: 0.5,
                              width: width * .7,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      )),
                  Positioned(
                      bottom: 110,
                      left: 40,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height: 50,
                                      child: Image.asset('assets/hot.png')),
                                  Column(
                                    children: [
                                      const Text(
                                        'Temp Max',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: Color.fromARGB(
                                                255, 193, 178, 178)),
                                      ),
                                      Text(
                                        '${state.weather.tempMax!.celsius!.round()}°C',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(width: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height: 50,
                                      child: Image.asset('assets/cool.png')),
                                  Column(
                                    children: [
                                      const Text(
                                        'Temp Min',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: Color.fromARGB(
                                                255, 193, 178, 178)),
                                      ),
                                      Text(
                                        '${state.weather.tempMin!.celsius!.round()}°C',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          //   child: Container(
                          //     height: 0.5,
                          //     width: width * .7,
                          //     color: Colors.grey,
                          //   ),
                          // )
                        ],
                      ))
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
