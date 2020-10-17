import 'package:flutter/material.dart';

class SelectCountry extends StatefulWidget {
  const SelectCountry({
    Key key,
  }) : super(key: key);

  @override
  _SelectCountryState createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 10),
            height: 30,
            width: 30,
            child: CircleAvatar(
              backgroundImage:
                  AssetImage('assets/images/brazil-flag-icon-16.png'),
            ),
          ),
          DropdownButton(
            items: [],
            onChanged: (value) {},
            iconEnabledColor: Colors.black,
            iconDisabledColor: Colors.black,
            hint: Text(
              'BRA',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            underline: SizedBox(),
          ),
        ],
      ),
    );
  }
}
