import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Success extends StatelessWidget {

  const Success({Key? key}) : super(key: key);
  static final String ROUTE_NAME = 'Success';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(top: 143),
          child: Center(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.indigo,
              radius: 70,
              backgroundImage: AssetImage("assets/done.png",),
            ),
          ),
        ),
        SizedBox(height: 55,),
        Text('User registration completed successfully',
          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),

        ),
      ],),
    );
  }
}
