import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(flex: 1, fit: FlexFit.tight, child: _top()),
          Flexible(flex: 6, fit: FlexFit.tight, child: _middle()),
          Flexible(flex: 3, fit: FlexFit.tight, child: _bottom())
        ],
      ),
    ));
  }

  Widget _top() => Container(
        width: double.infinity,
        alignment: Alignment.center,
        color: Colors.amber,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.title,
                style: TextStyle(
                    decoration:
                        TextDecoration.combine([TextDecoration.underline]))),
            Container(
              height: 10.0,
              color: Colors.accents[0],
            )
          ],
        ),
      );

  Widget _middle() => Column(
        children: [
          Flexible(
            flex: 9,
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
          Flexible(
              flex: 1,
              child: Center(
                child: ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, ind) {
                      return currentPageIndex == ind
                      ? SlideTransition(position: _offsetAnimation1, child: Icon(
                            Icons.circle,
                            size: 10,
                            color: Colors.lightGreen[300],
                          ))
                          : SlideTransition(
                              position: _offsetAnimation2,
                              child: Icon(
                                Icons.circle,
                                size: 10,
                                color: Colors.grey,
                              ));
                    }),
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
        width: double.infinity,
        color: Colors.red,
        child: Wrap(
          direction: Axis.vertical,
          children: [
            Text(widget.title),
          ],
        ),
      );
}
