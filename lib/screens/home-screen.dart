import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_mini_project/services/mqtt.service.dart'; //

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int _temperature = 40;
  late int _humidity = 31;

  late bool _isAirConditioner = false;
  late bool _isFridge = false;
  late bool _isTelevision = false;
  late bool _isWasher = false;

  late MqttService mqttService;

  @override
  void initState() {
    super.initState();
    mqttService = MqttService(onMessage);
    Get.put(mqttService);
  }

  void onMessage(String topic, String message) {
    debugPrint('Received message: $message from topic: $topic');
    if (topic == 'hl01012002/feeds/iot-mini-project.temp') {
      setState(() {
        _temperature = int.parse(message);
      });
    } else if (topic == 'hl01012002/feeds/iot-mini-project.humid') {
      setState(() {
        _humidity = int.parse(message);
      });
    }
  }

  //

  void _toggleAirConditioner(bool value) {
    setState(() {
      _isAirConditioner = value;
    });
    value
        ? mqttService.publish(
            'hl01012002/feeds/iot-mini-project.air-conditioner', '1')
        : mqttService.publish(
            'hl01012002/feeds/iot-mini-project.air-conditioner', '0');
  }

  void _toggleFridge(bool value) {
    setState(() {
      _isFridge = value;
    });
    value
        ? mqttService.publish('hl01012002/feeds/iot-mini-project.fridge', '1')
        : mqttService.publish('hl01012002/feeds/iot-mini-project.fridge', '0');
  }

  void _toggleTelevision(bool value) {
    setState(() {
      _isTelevision = value;
    });
    value
        ? mqttService.publish(
            'hl01012002/feeds/iot-mini-project.television', '1')
        : mqttService.publish(
            'hl01012002/feeds/iot-mini-project.television', '0');
  }

  void _toggleWasher(bool value) {
    setState(() {
      _isWasher = value;
    });
    value
        ? mqttService.publish('hl01012002/feeds/iot-mini-project.washer', '1')
        : mqttService.publish('hl01012002/feeds/iot-mini-project.washer', '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Text('Hi, Lương!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    )),
                Spacer(),
                Icon(Icons.notifications_none_outlined),
              ],
            ),
            Text('Welcome come to your Smart Home!',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[Color(0xffb65eba), Color(0xff2e8de1)]),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                height: 200,
                child: Column(
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 70,
                            height: 100,
                            child: const Image(
                              image: AssetImage(
                                'assets/images/sunny_weather_icon.png',
                              ),
                            )),
                        Container(
                            key: const Key('weather_info'),
                            width: 180,
                            height: 100,
                            alignment: Alignment.bottomCenter,
                            padding: const EdgeInsets.only(left: 10),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Sunny',
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white)),
                                Text('Ho Chi Minh City, Vietnam',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white)),
                              ],
                            )),
                        Container(
                            key: const Key('weather_temperature'),
                            alignment: Alignment.center,
                            width: 80,
                            height: 100,
                            padding: const EdgeInsets.only(top: 22),
                            child: const Text('39°',
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white))),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('$_temperature' '°',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                              const Text('Sensible',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('$_humidity' '%',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                              const Text('Humidity',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 100,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('0.5',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                              Text('W. Force',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 100,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('1009 hPa',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                              Text('Pressure',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            const SizedBox(height: 10),
            Container(
              height: 60,
              child: ListView(
                // This next line does the trick.
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    // width: 100,
                    alignment: Alignment.centerLeft,
                    child: const Text('All room',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    // width: 100,
                    alignment: Alignment.centerLeft,
                    child: const Text('Living room',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey)),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    // width: 100,
                    alignment: Alignment.centerLeft,
                    child: const Text('Bedroom',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey)),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    // width: 100,
                    alignment: Alignment.centerLeft,
                    child: const Text('Bathroom',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey)),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    // width: 100,
                    alignment: Alignment.centerLeft,
                    child: const Text('Kitchen',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey)),
                  ),
                ],
              ),
            ),
            GridView.count(
                crossAxisCount: 2, // number of columns
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(10),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.device_thermostat,
                                size: 50, color: Color(0xff2e8de1)),
                            Container(
                              padding: const EdgeInsets.only(left: 8),
                              child: const Text(
                                'Air conditioner',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Row(children: [
                              Container(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(_isAirConditioner ? 'On' : 'Off',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)),
                              ),
                              const Spacer(),
                              Switch(
                                value: _isAirConditioner,
                                onChanged: (value) {
                                  _toggleAirConditioner(value);
                                },
                              )
                            ])
                          ])),
                  Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.kitchen,
                                size: 50, color: Color(0xff2e8de1)),
                            Container(
                              padding: EdgeInsets.only(left: 8),
                              child: const Text(
                                'Fridge',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Row(children: [
                              Container(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(_isFridge ? 'On' : 'Off',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)),
                              ),
                              const Spacer(),
                              Switch(
                                value: _isFridge,
                                onChanged: (value) {
                                  _toggleFridge(value);
                                },
                              )
                            ])
                          ])),
                  Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 8),
                              child: const Icon(Icons.tv,
                                  size: 50, color: Color(0xff2e8de1)),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 8),
                              child: const Text(
                                'Television',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Row(children: [
                              Container(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(_isTelevision ? 'On' : 'Off',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)),
                              ),
                              const Spacer(),
                              Switch(
                                value: _isTelevision,
                                onChanged: _toggleTelevision,
                              )
                            ])
                          ])),
                  Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.local_laundry_service,
                                size: 50, color: Color(0xff2e8de1)),
                            Container(
                              padding: EdgeInsets.only(left: 8),
                              child: const Text(
                                'Washer',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Row(children: [
                              Container(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(_isWasher ? 'On' : 'Off',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)),
                              ),
                              const Spacer(),
                              Switch(
                                value: _isWasher,
                                onChanged: _toggleWasher,
                              )
                            ])
                          ]))
                ]),
            Container(
              //the rest height of the screen
              margin: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xffb65eba), Color(0xff2e8de1)]),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              height: 60,
              child: const Center(
                child: Text('Add Device',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
