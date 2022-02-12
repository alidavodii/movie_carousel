import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Movies extends StatefulWidget {
  const Movies({Key? key}) : super(key: key);

  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<Movies> with TickerProviderStateMixin {
  CarouselController _carouselController = new CarouselController();

  late AnimationController _controller;
  late Animation<double> _animation;
  int _current = 0;

  late final AnimationController _controllerScale =
      AnimationController(duration: const Duration(seconds: 20), vsync: this)
        ..repeat(reverse: true);

  late final Animation<double> _animationScale = Tween<double>(
          begin: 1.0, end: 1.5)
      .animate(CurvedAnimation(parent: _controllerScale, curve: Curves.linear));

  final List<dynamic> _movies = [
    {
      'title': 'خاتون',
      'image':
          'https://amingames.ir/wp-content/uploads/2021/07/ashkan-poster.jpg',
      'desc': 'عاشقانه - خانوادگی'
    },
    {
      'title': 'می خواهم زنده بمانم',
      'image':
          'https://movienama.com/wp-content/uploads/2021/02/I-want-to-live-Poster-qnoo.jpg',
      'desc': 'عاشقانه - خانوادگی'
    },
    {
      'title': 'شنا پروانه',
      'image':
          'https://movienama.com/wp-content/uploads/2021/05/shenaye-par-poster.jpg',
      'desc': 'خانوادگی - اجتماعی'
    },
    {
      'title': 'آقازاده',
      'image':
          'https://rasaneh3.ir/wp-content/uploads/2020/09/%D8%AF%D8%A7%D9%86%D9%84%D9%88%D8%AF-%D8%B3%D8%B1%DB%8C%D8%A7%D9%84-%D8%A2%D9%82%D8%A7%D8%B2%D8%A7%D8%AF%D9%87-%D9%82%D8%B3%D9%85%D8%AA-11-%DB%8C%D8%A7%D8%B2%D8%AF%D9%87%D9%85.jpg',
      'desc': 'خانوادگی - اجتماعی'
    },
    {
      'title': 'قورباغه',
      'image': 'https://cdn.yjc.ir/files/fa/news/1399/7/6/12660143_883.jpg',
      'desc': 'خانوادگی - اجتماعی'
    },
  ];

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controllerScale.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          FadeTransition(
            opacity: _animation,
            child: ScaleTransition(
              scale: _animationScale,
              child: Image.network(
                _movies[_current]['image'],
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(1),
                  Colors.black.withOpacity(1),
                  Colors.black.withOpacity(1),
                  Colors.black.withOpacity(1),
                  Colors.black.withOpacity(0),
                  Colors.black.withOpacity(0),
                  Colors.black.withOpacity(0),
                  Colors.black.withOpacity(0),
                ],
              )),
            ),
          ),
          Positioned(
            bottom: 50,
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            child: CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                  height: 500.0,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.70,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    _controller.repeat(
                      reverse: false,
                    );
                    _controller.forward();

                    _controllerScale.value = 0.0;
                    _controllerScale.forward();
                    setState(() {
                      _current = index;
                    });
                  }),
              items: _movies.map((movie) {
                return Builder(builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[900],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 320,
                            width: 250,
                            margin: EdgeInsets.only(top: 20),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Image.network(
                              movie['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            movie['title'],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            movie['desc'],
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '۴.۵',
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.date_range_outlined,
                                      color: Colors.grey.shade600,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '۱۴۰۰ ایران',
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.play_circle_filled,
                                      color: Colors.grey.shade600,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'تماشا',
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              }).toList(),
            ),
          )
        ]),
      ),
    );
  }
}
