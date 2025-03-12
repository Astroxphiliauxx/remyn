import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'circular_border_painter.dart';

class AutoScrollingIcons2 extends StatefulWidget {
  final double paddingOfIcons;
  final double sizeOfIcons;

  const AutoScrollingIcons2({
    Key? key,
    this.paddingOfIcons = 12.0, // Default padding
    this.sizeOfIcons = 40.0, // Default icon size
  }) : super(key: key);

  @override
  _AutoScrollingIcons2State createState() => _AutoScrollingIcons2State();
}

class _AutoScrollingIcons2State extends State<AutoScrollingIcons2> {
  final ScrollController _scrollController = ScrollController();
  final Random _random = Random();
  late List<IconData> _icons;
  late List<double> _arcRatios;
  late Timer _timer;
  final double _scrollSpeed = 27.0;

  final List<IconData> _originalIcons = [
    Icons.pages,
    Icons.nature,
    Icons.baby_changing_station_sharp,
    Icons.face,
    Icons.safety_check,
    Icons.label_important_outline_sharp,
    Icons.qr_code_2_outlined,
    Icons.earbuds_rounded,
    Icons.image_aspect_ratio,
    Icons.edgesensor_high_rounded,
    Icons.unpublished_rounded,
    Icons.pages,
    Icons.nature,
    Icons.baby_changing_station_sharp,
    Icons.face,
    Icons.safety_check,
    Icons.label_important_outline_sharp,
    Icons.qr_code_2_outlined,
    Icons.earbuds_rounded,
    Icons.image_aspect_ratio,
    Icons.edgesensor_high_rounded,
    Icons.unpublished_rounded,
    Icons.pages,
    Icons.nature,
    Icons.baby_changing_station_sharp,
    Icons.face,
    Icons.safety_check,
    Icons.label_important_outline_sharp,
    Icons.qr_code_2_outlined,
    Icons.earbuds_rounded,
    Icons.image_aspect_ratio,
    Icons.edgesensor_high_rounded,
    Icons.unpublished_rounded,
    Icons.pages,
    Icons.nature,
    Icons.baby_changing_station_sharp,
    Icons.face,
    Icons.safety_check,
    Icons.label_important_outline_sharp,
    Icons.qr_code_2_outlined,
    Icons.earbuds_rounded,
    Icons.image_aspect_ratio,
    Icons.edgesensor_high_rounded,
    Icons.unpublished_rounded,
    Icons.home,
    Icons.pages,
    Icons.nature,
    Icons.baby_changing_station_sharp,
    Icons.face,
    Icons.safety_check,
    Icons.label_important_outline_sharp,
    Icons.qr_code_2_outlined,
    Icons.earbuds_rounded,
    Icons.image_aspect_ratio,
    Icons.edgesensor_high_rounded,
    Icons.unpublished_rounded,

  ];

  @override
  void initState() {
    super.initState();
    _icons = List.from(_originalIcons)..addAll(_originalIcons);
    _arcRatios = List.generate(_icons.length, (_) => _random.nextDouble());

    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.offset + _scrollSpeed,
          duration: Duration(milliseconds: 500),
          curve: Curves.linear,
        );
        if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent / 2) {
          _scrollController.jumpTo(0);
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  Color _getRandomColor() {
    return HSLColor.fromAHSL(1, _random.nextDouble() * 360, 0.8, 0.6).toColor();
  }

  Color _getFadedColor(Color color) {
    return color.withOpacity(0.4);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.sizeOfIcons + 40,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: _icons.length,
        itemBuilder: (context, index) {
          Color color1 = _getRandomColor();
          Color color2 = _getFadedColor(color1);
          double arcRatio = _arcRatios[index];

          return Container(
            margin: EdgeInsets.symmetric(horizontal: widget.paddingOfIcons),
            child: CustomPaint(
              size: Size(widget.sizeOfIcons + 40, widget.sizeOfIcons + 40),
              painter: CircularBorderPainter(color1, color2, arcRatio),
              child: Padding(
                padding: EdgeInsets.all(widget.paddingOfIcons),
                child: Center(
                  child: Icon(
                    _icons[index],
                    color: color1,
                    size: widget.sizeOfIcons,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
