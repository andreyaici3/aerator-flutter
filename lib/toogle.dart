import 'package:flutter/material.dart';

class AnimatedToogle extends StatefulWidget {
  final List<String> values;
  final ValueChanged onToogleCallback;
  final Color bgcolor;
  final Color btnColor;
  final Color textColor;
  final double width;
  final double height;

  const AnimatedToogle(
      {Key? key,
      required this.values,
      required this.onToogleCallback,
      this.bgcolor = const Color(0xFFe7e7e8),
      this.btnColor = Colors.blue,
      this.textColor = const Color(0XFF000000),
      required this.height,
      required this.width})
      : super(key: key);

  @override
  _AnimatedToogleState createState() => _AnimatedToogleState();
}

class _AnimatedToogleState extends State<AnimatedToogle> {
  bool aktif = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              aktif = !aktif;
              var index = 0;
              if (!aktif) {
                index = 1;
              }
              widget.onToogleCallback(index);
              setState(() {});
            },
            child: Container(
              width: widget.width,
              height: widget.height,
              decoration: ShapeDecoration(
                color: widget.bgcolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                ),
              ),
              child: Row(
                children: List.generate(
                  widget.values.length,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 11),
                    child: Text(
                      widget.values[index],
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.bold,
                        color: Color(0xAA000000),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedAlign(
            curve: Curves.decelerate,
            duration: const Duration(milliseconds: 250),
            alignment: aktif ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: widget.width,
              height: widget.height,
              decoration: ShapeDecoration(
                color: widget.btnColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text(
                aktif ? widget.values[0] : widget.values[1],
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}
