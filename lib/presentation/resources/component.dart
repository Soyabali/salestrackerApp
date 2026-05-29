import 'package:flutter/material.dart';


class ContainerWithRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
     borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFf2f3f5),
          borderRadius: BorderRadius.circular(10.0), // Border radius
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Click Photo',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black54,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Please clock here to take a photo',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.redAccent,
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.forward_sharp,size: 10,color: Colors.redAccent),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  print('---------57-----');
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 10,top: 5),
                  child: Icon(
                    Icons.camera,
                    size: 24.0,
                    color: Color(0xFF255899),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}