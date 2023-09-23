import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:animated_background/animated_background.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SpaceXplor: Explore the wast space',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

GlobalKey key = GlobalKey();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  List planets = [
    'Sun',
    'Mercury',
    'Venus',
    'Earth',
    'Mars',
    'Jupiter',
    'Saturn',
    'Uranus',
    'Neptune',
    'Pluto',
    'Moon',
    'ISS'
  ];
  int page = 0;
  late PageController controller;
  @override
  void initState() {
    controller = PageController(initialPage: page, keepPage: true);
    super.initState();
  }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                setState(() {
                  controller.animateToPage(0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOutSine);
                });
              },
              icon: Icon(
                Icons.home,
                color: Colors.white,
              )),
          title: const Text('Planets'),
          backgroundColor: Colors.transparent,
        ),
        body: 
         
             Stack(
              children: [

                AnimatedBackground(
                  vsync: this,
                  behaviour: SpaceBehaviour(),
                  child: Container(
                
                   
                    //height: double.infinity,
                    child: PageView(
                      
                        key: key,
                        onPageChanged: (value) {
                          setState(() {
                            page = value;
                          });
                        },
                        physics: NeverScrollableScrollPhysics(),
                        controller: controller,
                        children: const [
                          Planet(url: 'assets/Sun.glb'),
                          Planet(url: 'assets/Mercury.glb'),
                          Planet(url: 'assets/Venus.glb'),
                          Planet(url: 'assets/earth.glb'),
                          Planet(url: 'assets/mars.glb'),
                          Planet(url: 'assets/Jupiter.glb'),
                          Planet(url: 'assets/Saturn.glb'),
                          Planet(url: 'assets/Uranus.glb'),
                          Planet(url: 'assets/Neptune.glb'),
                          Planet(url: 'assets/Pluto.glb'),
                          Planet(url: 'assets/moon.glb'),
                          Planet(url: 'assets/iss.glb'),
                        ]),
                  ),
                ),
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${planets[page]}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 80,
                            fontWeight: FontWeight.bold),
                      ),
                      
                      Column(
                        children: [
                          Container(
                            width: 100,
                            child: PageViewDotIndicator(
                              currentItem: page, count: planets.length, unselectedColor: Colors.white24, selectedColor: Colors.white,
                              onItemClicked: (index) {
                                setState(() {
                                  controller.animateToPage(index,
                                      duration: Duration(milliseconds: 1000),
                                      curve: Curves.easeInOutSine);
                                });
                              },
                              fadeEdges: false,
                              unselectedSize: Size(10, 10),
                          
                              ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      controller.previousPage(
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.easeInOutSine);
                                    });
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: page == 0 ? Colors.white38 : Colors.white,
                                  )),
                              SizedBox(
                                width: 50,
                              ), IconButton(
                                  onPressed: () {
                                    setState(() {
                                      showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        context: context, builder: 
                                      (context) => Container(
                                        color: Colors.transparent,
                                        height: 200,
                                        width: MediaQuery.of(context).size.width>700?400:MediaQuery.of(context).size.width-100,
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 20,),
                                            Text('${planets[page]}', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
                                            const SizedBox(height: 20,),
                                            Text('This is a ${planets[page]}', style: TextStyle(color: Colors.white, fontSize: 20),),
                                          ],
                                        ),
                                      ));
                                    });
                                  },
                                  icon: Icon(
                                    Icons.info_outlined,
                                    color: page == planets.length - 1
                                        ? Colors.white38
                                        : Colors.white,
                                  )), SizedBox(
                                width: 50,
                              ),

                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      controller.nextPage(
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.easeInOutSine);
                                    });
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: page == planets.length - 1
                                        ? Colors.white38
                                        : Colors.white,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          
        );
  }
}

class Planet extends StatefulWidget {
  final String url;
  const Planet({super.key, required this.url});

  @override
  State<Planet> createState() => _PlanetState();
}

class _PlanetState extends State<Planet> with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        child: ModelViewer(
          src: widget.url,
          alt: 'PlanetX',
          interactionPrompt: InteractionPrompt.none,
          cameraControls: true,
          disablePan: true,
          autoRotateDelay: 0,
          rotationPerSecond: '200%',
          autoRotate: true,
          autoPlay: true,
          //rotationPerSecond: '360deg',
        ));
  }
}
