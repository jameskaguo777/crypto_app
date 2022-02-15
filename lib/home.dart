import 'dart:math';
import 'dart:ui';

import 'package:crypto_app/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

const SCALE_FRACTION = 0.7;
const FULL_SCALE = 1.0;
const PAGER_HEIGHT = 200.0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Size? _size;
  late int _currentPage = 0;
  late PageController _pageController;
  double page = 2.0;
  double viewPortFraction = 0.9;
  bool showAvg = false;
  String menuSelected = 'value';
  List<Color> gradientColors = [
    Colors.white,
  ];
  late double cardWidth, cardHeight;

  @override
  void initState() {
    _pageController =
        PageController(initialPage: 0, viewportFraction: viewPortFraction);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    cardWidth = _size!.width * 0.9;
    cardHeight = _size!.height * 0.26;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Flexible(flex: 1, child: _topButtons()),
          Flexible(flex: 2, child: _balance()),
          Flexible(flex: 5, child: _cards()),
          Flexible(flex: 6, child: _assets()),
        ],
      )),
    );
  }

  Widget _topButtons() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {},
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  direction: Axis.horizontal,
                  spacing: 5,
                  children: const [
                    Icon(
                      Icons.menu,
                      color: Colors.black87,
                    ),
                    Text(
                      'transactions',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ],
                )),
            const SizedBox(
              width: 30,
              height: 20,
              child: VerticalDivider(
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            TextButton(
                onPressed: () {},
                child: Wrap(
                  alignment: WrapAlignment.center,
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 5,
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        const Icon(
                          Icons.notifications_outlined,
                          color: Colors.black87,
                        ),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Center(
                              child: Text('4',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 8))),
                        )
                      ],
                    ),
                    const Text('notifications',
                        style: TextStyle(color: Colors.black87)),
                  ],
                )),
          ],
        ),
      );

  Widget _balance() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text('total balance',
                  style: Theme.of(context).textTheme.caption),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                'TZ\$13,936,727.06',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.arrow_upward_rounded,
                      color: Colors.green,
                      size: 13,
                    ),
                    Text(
                      'TZ\$149,652.30 ~ 48%',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                    )
                  ],
                )),
          ],
        ),
      );

  Widget _cards() => Column(
        children: [
          Flexible(
              flex: 5,
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification notification) {
                  if (notification is ScrollUpdateNotification) {
                    setState(() {
                      page = _pageController.page!;
                    });
                  }
                  return true;
                },
                child: PageView.builder(
                    controller: _pageController,
                    itemCount: holdingCardsCONST.length,
                    onPageChanged: (value) {
                      setState(() {
                        _currentPage = value;
                      });
                    },
                    itemBuilder: (context, index) {
                      final scale = max(
                          SCALE_FRACTION,
                          (FULL_SCALE - (index - page).abs()) +
                              viewPortFraction);
                      //  print('view scale in flutter $scale');
                      return _card(scale, holdingCardsCONST[index]);
                    }),
              )),
          Flexible(
            flex: 1,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 4,
                  effect: const WormEffect(
                    activeDotColor: Colors.green,
                    dotColor: Colors.black12,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                  ),
                ),
              ),
            ),
          )
        ],
      );

  Widget _assets() => Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 8.0, 18.0, 8.0),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Text('assets',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          )),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Wrap(
                    spacing: 5,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.horizontal,
                    children: [
                      const Text('sort by: '),
                      DropdownButton(
                          value: menuSelected,
                          items: <String>['value', 'name', 'trending']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              menuSelected = newValue.toString();
                            });
                          })
                    ],
                  ),
                )
              ],
            ),
            _assetsList(),
          ],
        ),
      );

  Widget _card(double scale, Map<String, dynamic> data) => Card(
        elevation: 0,
        color: Color(int.parse(data['color'])),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 18.0, 13.0, 18.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(flex: 1, child: _firstCardContent()),
              Flexible(
                  flex: 3, fit: FlexFit.tight, child: _secondCardContent(data['amount'], data['change'], data['percentage'])),
              Flexible(flex: 1, child: _thirdCardContent()),
            ],
          ),
        ),
      );

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: false,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: false,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: false,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 32,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1.0)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(-3, 1),
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
            FlSpot(12, 4),
          ],
          isCurved: false,
          colors: gradientColors,
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: false,
        drawHorizontalLine: false,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: false,
        bottomTitles: SideTitles(
          showTitles: false,
          reservedSize: 22,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
          interval: 1,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 32,
          interval: 1,
          margin: 12,
        ),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
            FlSpot(12, 3.44),
          ],
          isCurved: true,
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.1),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.1),
          ]),
        ),
      ],
    );
  }

  Widget _thirdCardContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {},
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 5,
                  direction: Axis.horizontal,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    Text(
                      'buy',
                      style: Theme.of(context)
                          .textTheme
                          .button!
                          .copyWith(color: Colors.white),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () {},
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 5,
                  direction: Axis.horizontal,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    Text(
                      'sell',
                      style: Theme.of(context)
                          .textTheme
                          .button!
                          .copyWith(color: Colors.white),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 8.0, 0),
            child: InkWell(
              onTap: () {},
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 5,
                direction: Axis.horizontal,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  Text(
                    'send',
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _secondCardContent(String amount, String change, String percent) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.center,
          width: _size!.width * 0.38,
          height: _size!.height * 0.08,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: 'TZ\$',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.white)),
                TextSpan(
                    text: amount,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white)),
              ])),
              Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.arrow_upward_rounded,
                        color: Colors.white,
                        size: 13,
                      ),
                      Text(
                        'TZ\$$change ~ $percent',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                      )
                    ],
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 22.0, 0),
          child: SizedBox(
            width: _size!.width * 0.25,
            height: _size!.height * 0.3,
            child: LineChart(
              showAvg ? avgData() : mainData(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _firstCardContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: '🤞🏾 ',
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: Colors.white)),
          TextSpan(
              text: 'holding portfolio',
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: Colors.white)),
        ])),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _assetsList() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return _assetListItem(
              assetsCONST[index]['name'],
              assetsCONST[index]['symbol'],
              assetsCONST[index]['balance'],
              assetsCONST[index]['priceChange'],
              assetsCONST[index]['direction'],
              assetsCONST[index]['icon'],
              assetsCONST[index]['coin']);
        },
        itemCount: assetsCONST.length,
      ),
    );
  }

  Widget _assetListItem(String name, String symbol, String balance,
      String change, String direction, String url, String coin) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                children: [
                  Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: Colors.grey[200],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.network(
                          url,
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.colorDodge,
                          filterQuality: FilterQuality.high,
                          width: 30,
                          height: 30,
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Wrap(
                      direction: Axis.vertical,
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      spacing: 3,
                      runSpacing: 3,
                      children: [
                        Text(name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold)),
                        Text(coin + ' ' + symbol,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.grey[500])),
                      ],
                    ),
                  )
                ],
              )),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.start,
              children: [
                Text(balance,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.black54)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    direction == 'up'
                        ? const Icon(
                            Icons.arrow_upward,
                            color: Colors.green,
                            size: 10,
                          )
                        : const Icon(Icons.arrow_downward,
                            color: Colors.red, size: 10),
                    direction == 'up'
                        ? Text(
                            change,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.green),
                          )
                        : Text(
                            change,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.red),
                          )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
