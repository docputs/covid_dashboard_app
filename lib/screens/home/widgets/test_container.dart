import 'package:flutter/material.dart';

import '../../../constants.dart';

class TestContainer extends StatelessWidget {
  const TestContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                kPrimaryColor.withOpacity(.25),
                kPrimaryColor,
              ],
            ),
          ),
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                bottom: -7.2,
                left: -15,
                child: Image.asset(
                  'assets/images/woman-mask.png',
                  scale: 3.4,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.only(right: 10),
                  width: constraints.maxWidth * .6,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Faça seu próprio teste!\n',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              'Siga as instruções e realize seu próprio teste.',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
