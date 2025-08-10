
import 'dart:math';
import 'package:flutter/material.dart';
import '../../constants/app_icons.dart';
import 'circular_border_painter.dart';

class SyncedScrollingIcons extends StatefulWidget {
  final double iconSize;
  final double iconPadding;
  final double scrollSpeed;

  const SyncedScrollingIcons({
    Key? key,
    this.iconSize = 45.0,
    this.iconPadding = 16.0,
    this.scrollSpeed = 40.0,
  }) : super(key: key);

  @override
  State<SyncedScrollingIcons> createState() => _SyncedScrollingIconsState();
}

class _SyncedScrollingIconsState extends State<SyncedScrollingIcons>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  final ScrollController _scrollController1 = ScrollController();
  final ScrollController _scrollController2 = ScrollController();

  final Random _random = Random();

    late final List<IconData> _icons1;
  late final List<IconData> _icons2;

  late final List<Color> _colors1;
  late final List<Color> _colors2;

  late final List<double> _arcRatios1;
  late final List<double> _arcRatios2;


  @override
  void initState() {
    super.initState();

    _icons1 = List.from(kScrollingIcons)..addAll(kScrollingIcons);

    final List<IconData> shuffledOriginals = List.from(kScrollingIcons)..shuffle();
    _icons2 = List.from(shuffledOriginals)..addAll(shuffledOriginals);


    _colors1 = List.generate(_icons1.length, (_) => _getRandomColor());
    _colors2 = List.generate(_icons1.length, (_) => _getRandomColor());
    _arcRatios1 = List.generate(_icons1.length, (_) => _random.nextDouble());
    _arcRatios2 = List.generate(_icons1.length, (_) => _random.nextDouble());

    _animationController = AnimationController(vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScrolling();
    });
  }

  // The _startScrolling() and dispose() methods remain exactly the same...
  void _startScrolling() {
    if (!mounted || !_scrollController1.hasClients) return;

    final scrollExtent = _scrollController1.position.maxScrollExtent;
    final scrollExtentHalf = scrollExtent / 2;
    final durationInSeconds = scrollExtentHalf / widget.scrollSpeed;
    if (durationInSeconds <= 0) return;

    _animationController.duration = Duration(seconds: durationInSeconds.round());

    _animationController.addListener(() {
      final currentOffset = _animationController.value * scrollExtent;
      final itemWidth = widget.iconSize + 40 + (widget.iconPadding * 2);
      final interlockingOffset = itemWidth / 2;

      if (_scrollController1.offset >= scrollExtentHalf) {
        _scrollController1.jumpTo(_scrollController1.offset - scrollExtentHalf);
        _scrollController2.jumpTo(_scrollController2.offset - scrollExtentHalf);
      }

      _scrollController1.jumpTo(currentOffset);
      _scrollController2.jumpTo(currentOffset + interlockingOffset);
    });

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController1.dispose();
    _scrollController2.dispose();
    super.dispose();
  }

  Color _getRandomColor() {
    return HSLColor.fromAHSL(1, _random.nextDouble() * 360, 0.8, 0.6).toColor();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 100,
          left: 0,
          right: 0,
          child: _ScrollingIconList(
            scrollController: _scrollController1,
            icons: _icons1,
            colors: _colors1,
            arcRatios: _arcRatios1,
            iconSize: widget.iconSize,
            iconPadding: widget.iconPadding,
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 100,
          child: _ScrollingIconList(
            scrollController: _scrollController2,
            // 3. Pass the second (shuffled) icon list
            icons: _icons2,
            colors: _colors2,
            arcRatios: _arcRatios2,
            iconSize: widget.iconSize,
            iconPadding: widget.iconPadding,
          ),
        ),
      ],
    );
  }
}

class _ScrollingIconList extends StatelessWidget {
  const _ScrollingIconList({
    required this.scrollController,
    required this.icons,
    required this.colors,
    required this.arcRatios,
    required this.iconSize,
    required this.iconPadding,
  });

  final ScrollController scrollController;
  final List<IconData> icons;
  final List<Color> colors;
  final List<double> arcRatios;
  final double iconSize;
  final double iconPadding;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: iconSize + 40,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: icons.length,
        itemBuilder: (context, index) {
          final color1 = colors[index];
          // color2 is no longer used for drawing a partial arc, but the painter might still need it
          final color2 = color1.withOpacity(0.4);
          final arcRatio = arcRatios[index];

          return Container(
            margin: EdgeInsets.symmetric(horizontal: iconPadding),
            child: CustomPaint(
              size: Size(iconSize + 40, iconSize + 40),
              // Make sure you have your CircularBorderPainter class available
              painter: CircularBorderPainter(color1, color2, arcRatio),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Icon(icons[index], color: color1, size: iconSize),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}