import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with SingleTickerProviderStateMixin {
  final PageController _pageController =
      PageController(initialPage: 0, keepPage: false);
  int currentPageIndex = 0;
  final PageStorageBucket _bucket = PageStorageBucket();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward();
  late final Animation<Offset> _offsetAnimation1 = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticInOut,
  ));

  late final Animation<Offset> _offsetAnimation2 = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ));

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
          body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(flex: 1, fit: FlexFit.tight, child: _top()),
            Flexible(flex: 6, fit: FlexFit.tight, child: _middle()),
            Flexible(flex: 2, fit: FlexFit.tight, child: _bottom())
          ],
        ),
      )),
    );
  }

  Widget _top() => Container(
        width: double.infinity,
        alignment: Alignment.center,
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            
            Text(widget.title,
                style: Theme.of(context).textTheme.headline6),
            Container(
              height: 5.0,
              width: 80,
              margin: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.green),
              
            ),
          ],
        ),
      );

  Widget _middle() => Column(
        children: [
          Flexible(
            flex: 9,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PageView(
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                onPageChanged: (index) {
                  
                  setState(() {
                    currentPageIndex = index;
                    _controller.forward(from: 0.0);
                  });
                },
                children: [
                  PageStorage(bucket: _bucket, child: _firstSlide()),
                  PageStorage(bucket: _bucket, child: _secondSlide()),
                  PageStorage(bucket: _bucket, child: _thirdSlide()),
                ],
              ),
            ),
          ),
          Flexible(
              flex: 1,
              child: Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: const WormEffect(
                    activeDotColor: Colors.green,
                    dotColor: Colors.black12,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                    
                  ),
                ),
              ))
        ],
      );

  Widget _firstSlide() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child:
                  Image.asset('assets/globe.png', height: 210.0, width: 210.0)),
          Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: Text('cryto currency made easy ✌🏾',
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center)),
          Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                child: Text(
                    'with the help of the world\'s most trusted and reliable cryptocurrency exchange',
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.center),
              )),
        ],
      );

  Widget _secondSlide() => Column(
    mainAxisSize: MainAxisSize.max,
    children: [
      Text('Slide 2')
    ],
  );

  Widget _thirdSlide() => Column(
        mainAxisSize: MainAxisSize.max,
        children: [Text('Slide 3')],
      );

  Widget _bottom() => Container(
    alignment: Alignment.center,
        width: double.infinity,
        
        child: CupertinoButton(
          color: Colors.green,
          child: Text('Get Started'),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/home');
          },
        ));
     
}
